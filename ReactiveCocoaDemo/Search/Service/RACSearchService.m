//
//  RACSearchService.m
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/18.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import "RACSearchService.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <AFNetworking/AFNetworking.h>
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>
#import "RACSearchResult.h"
#import "RACBookModel.h"

@implementation RACSearchService

- (RACSignal *)searchSignalWithText:(NSString *)searchText {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"q"] = searchText;
        [[AFHTTPRequestOperationManager manager] GET:@"https://api.douban.com/v2/book/search"
                                          parameters:parameters
                                             success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                                                 // 此处可以直接转成model，也可以返回原生数据给viewmodel，但是不能转成viewmodel
                                                 RACSearchResult *searchResult = [RACSearchResult new];
                                                 searchResult.start = [[responseObject valueForKeyPath:@"start"] integerValue];
                                                 searchResult.total = [[responseObject valueForKeyPath:@"total"] integerValue];
                                                 searchResult.count = [[responseObject valueForKeyPath:@"count"] integerValue];
                                                 NSArray *books = [responseObject valueForKeyPath:@"books"];
                                                 searchResult.booksArray = [books linq_select:^id(NSDictionary *bookDict) {
                                                     RACBookModel *book = [[RACBookModel alloc] initWithDict:bookDict];
                                                     return book;
                                                 }];
                                                 [subscriber sendNext:searchResult];
                                                 [subscriber sendCompleted];
                                             }
                                             failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                                                 [subscriber sendError:error];
                                             }];
        return nil;
    }];
}

@end

//
//  RACSearchViewModel.m
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/18.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import "RACSearchViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RACSearchService.h"
#import "RACSearchResult.h"
#import "RACBookModel.h"
#import "RACDetailViewModel.h"

@interface RACSearchViewModel ()

@property (nonatomic, strong) RACSearchService *searchService;

@end

@implementation RACSearchViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithNaviImpl:(id<RACViewModelNavigationProtocol>)naviImpl {
    self = [super init];
    if (self) {
        [self initialize];
        _naviImpl = naviImpl;
    }
    return self;
}

- (void)initialize {
    
    self.title = @"搜索";
    self.searchService = [RACSearchService new];
    @weakify(self);
    RACSignal *validSearchSignal =
    [[RACObserve(self, searchText)
      map:^id(NSString *text) {
          @strongify(self);
          return @([self isValidSearchText:text]);
      }]
     distinctUntilChanged];
    
    self.executeSearch =
    [[RACCommand alloc] initWithEnabled:validSearchSignal
                            signalBlock:^RACSignal *(id input) {
                                @strongify(self);
                                return [self executeSearchSignal];
    }];
    
    self.connectionErrors = self.executeSearch.errors;
    
    self.executeSelection =
    [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *index) {
                                @strongify(self);
                                return [self executeSelectionSignalWithIndex:index];
    }];
}

// 跳转到对应详情页
- (RACSignal *)executeSelectionSignalWithIndex:(NSNumber *)index {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        RACBookModel *bookModel = [self.searchResults objectAtIndex:[index integerValue]];
        RACDetailViewModel *detailViewModel = [[RACDetailViewModel alloc] initWithBookModel:bookModel naviImpl:self.naviImpl];
        if (_naviImpl && [_naviImpl respondsToSelector:@selector(pushViewModel:)]) {
            [_naviImpl pushViewModel:detailViewModel];
        }
        [subscriber sendCompleted];
        return nil;
    }];
}

- (RACSignal *)executeSearchSignal {
    @weakify(self);
    return [[self.searchService searchSignalWithText:self.searchText] doNext:^(RACSearchResult *searchResult) {
        @strongify(self);
        self.searchResults = searchResult.booksArray;
    }];
    // 注意如此按钮会不可点击状态持续2s
    return [[[[RACSignal empty] logAll] delay:2.0] logAll];
}

- (BOOL)isValidSearchText:(NSString *)text {
    return text.length > 3;
}

@end



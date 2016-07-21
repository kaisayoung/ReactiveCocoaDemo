//
//  RACDetailViewModel.m
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/19.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import "RACDetailViewModel.h"

@implementation RACDetailViewModel

- (instancetype)initWithBookModel:(RACBookModel *)bookModel naviImpl:(id<RACViewModelNavigationProtocol>)naviImpl {
    if (self = [super init]) {
        [self initialize];
        _bookModel = bookModel;
        _naviImpl = naviImpl;
    }
    return self;
}

- (void)initialize {
    
    self.title = @"详情";
}

- (NSString *)bookTitle {
    return self.bookModel.title;
}

- (NSString *)pages {
    return [NSString stringWithFormat:@"%@页",self.bookModel.pages];
}

- (NSString *)price {
    return self.bookModel.price;
}

- (NSString *)summary {
    return self.bookModel.summary;
}

- (NSString *)pubdate {
    return self.bookModel.pubdate;
}

- (NSString *)publisher {
    return self.bookModel.publisher;
}

- (NSString *)firstAuthor {
    return [self.bookModel.author firstObject];
}

- (NSString *)imageUrl {
    return [self.bookModel.images objectForKey:@"large"];
}

@end

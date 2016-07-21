//
//  RACSearchResult.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/19.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  如此相当于在model上又包了一层，类似于管理model，有无必要看个人理解
 */

@interface RACSearchResult : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger start;
@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray *booksArray;

@end

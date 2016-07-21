//
//  RACBookModel.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/19.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  最基本的一个model类
 */

@interface RACBookModel : NSObject

@property (nonatomic, copy) NSString *bid;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pages;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *pubdate;
@property (nonatomic, copy) NSString *publisher;

@property (nonatomic, strong) NSArray *author;

@property (nonatomic, strong) NSDictionary *images;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

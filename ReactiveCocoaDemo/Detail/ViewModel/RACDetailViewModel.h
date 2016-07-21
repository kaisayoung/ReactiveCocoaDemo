//
//  RACDetailViewModel.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/19.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RACBookModel.h"
#import "RACViewModelNavigationImpl.h"

/**
 *  详情页面中分离出的用于处理逻辑的类
 *  注意命名规则，一个controller和其对应的viewmodel最好只是Controller和Model的差别
 *  注意每个viewmodel都要写清楚初始化方法，或者初始化时必须由外界传入的值
 */

@interface RACDetailViewModel : NSObject

@property (nonatomic, strong) RACBookModel *bookModel;

// 对应controller的title
@property (nonatomic, copy) NSString *title;

// 如下几个属性能体现出MVVM的精髓
@property (nonatomic, copy) NSString *bookTitle;
@property (nonatomic, copy) NSString *pages;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *pubdate;
@property (nonatomic, copy) NSString *publisher;
@property (nonatomic, copy) NSString *firstAuthor;
@property (nonatomic, copy) NSString *imageUrl;

// 为了实现页面跳转而创建的属性，和本页面本身的逻辑无关
@property (nonatomic, strong) id<RACViewModelNavigationProtocol>naviImpl;

- (instancetype)initWithBookModel:(RACBookModel *)bookModel naviImpl:(id<RACViewModelNavigationProtocol>)naviImpl;

@end

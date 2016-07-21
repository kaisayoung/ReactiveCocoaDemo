//
//  RACSearchViewModel.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/18.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RACViewModelNavigationImpl.h"

/**
 *  搜索页面中分离出的用于处理逻辑的类
 *  注意命名规则，一个controller和其对应的viewmodel最好只是Controller和Model的差别
 *  一般来说，viewmodel中主要是三种类型变量：普通的property，signal，command。当然还有可能有一堆方法
 *  此类中控制页面的跳转
 */

@interface RACSearchViewModel : NSObject

// 对应controller的title
@property (nonatomic, copy) NSString *title;
// 用户输入的搜索文字
@property (nonatomic, copy) NSString *searchText;
// 搜索到的结果
@property (nonatomic, strong) NSArray *searchResults;
// 执行搜索的命令
@property (nonatomic, strong) RACCommand *executeSearch;
// API交互产生的错误
@property (nonatomic, strong) RACSignal *connectionErrors;
// 点击cell时的命令
@property (nonatomic, strong) RACCommand *executeSelection;

// 为了实现页面跳转而创建的属性，和本页面本身的逻辑无关
@property (nonatomic, strong) id<RACViewModelNavigationProtocol>naviImpl;

- (instancetype)initWithNaviImpl:(id<RACViewModelNavigationProtocol>)naviImpl;

@end

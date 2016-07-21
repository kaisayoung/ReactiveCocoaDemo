//
//  RACSearchService.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/18.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

/**
 *  搜索页面分离出来的专用于和API／数据库交互的类，隶属于model层
 */

@protocol RACSearchServiceProtocol <NSObject>

// 此处可定义在协议中，也可直接定义成方法
- (RACSignal *)searchSignalWithText:(NSString *)searchText;

@end

@interface RACSearchService : NSObject<RACSearchServiceProtocol>

@end

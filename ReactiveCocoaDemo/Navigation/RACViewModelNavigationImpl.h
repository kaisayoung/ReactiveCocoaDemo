//
//  RACViewModelNavigationImpl.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/20.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RACViewModelNavigationProtocol.h"
#import <UIKit/UIKit.h>

/**
 *  MVVM正确的姿势：以viewmodel层驱动整个项目或者整个模块页面之间的跳转
 *  上面协议的实现类，以非短链的方式控制页面之间的跳转
 */

@interface RACViewModelNavigationImpl : NSObject<RACViewModelNavigationProtocol>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end

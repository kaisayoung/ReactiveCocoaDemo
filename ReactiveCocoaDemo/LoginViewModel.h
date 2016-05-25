//
//  LoginViewModel.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/5/25.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  在LoginViewController中分离出来的用于处理逻辑的类
 */

@interface LoginViewModel : NSObject

// 触发API
- (void)loginWithUsername:(NSString *)username password:(NSString *)password complete:(void (^)(BOOL))loginResult;

// 逻辑判断
- (BOOL)isValidUsername:(NSString *)username;
- (BOOL)isValidPassword:(NSString *)password;
 

@end

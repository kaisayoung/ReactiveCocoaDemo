//
//  RACLoginViewModel.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/11.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

/**
 *  应用RAC的情况下在LoginViewController中分离出来的用于处理逻辑的类
 */

@interface RACLoginViewModel : NSObject

// property
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

// signal
@property (nonatomic, strong) RACSignal *usernameSignal;
@property (nonatomic, strong) RACSignal *passwordSignal;
@property (nonatomic, strong) RACSignal *loginEnableSignal;
@property (nonatomic, strong) RACSignal *connectionErrors;

// command
@property (nonatomic, strong) RACCommand *loginCommand;

@end

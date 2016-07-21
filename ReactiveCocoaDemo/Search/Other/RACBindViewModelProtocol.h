//
//  RACBindViewModelProtocol.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/18.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  将MVVM的核心方法定义成一个协议，只需遵守此协议可保证应用同一方法
 */

@protocol RACBindViewModelProtocol <NSObject>

- (void)bindViewModel:(id)viewModel;

@end

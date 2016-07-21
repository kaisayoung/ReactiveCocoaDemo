//
//  RACDetailViewController.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/19.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RACDetailViewModel.h"

/**
 *  详情页面，主要是演示如何跨页面传值
 *  注意命名规则，一个controller和其对应的viewmodel最好只是Controller和Model的差别
 */

@interface RACDetailViewController : UIViewController

@property (nonatomic, strong) RACDetailViewModel *viewModel;

- (instancetype)initWithViewModel:(RACDetailViewModel *)viewModel;

@end

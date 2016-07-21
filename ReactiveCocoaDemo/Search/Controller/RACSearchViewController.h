//
//  RACSearchViewController.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/18.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RACSearchViewModel.h"

/**
 *  搜索页面，主要是演示如何展示列表和跨页面传值：点击cell时即跳转到对应详情页
 *  注意命名规则，一个controller和其对应的viewmodel最好只是Controller和Model的差别
 *  通过观察可以发现，一个controller或者一个view中除了子view和viewmodel外，几乎没有任何属性值或者变量了，相当简洁
 */

@interface RACSearchViewController : UIViewController

@property (nonatomic, strong) RACSearchViewModel *viewModel;

+ (instancetype)viewController;

- (instancetype)initWithViewModel:(RACSearchViewModel *)viewModel;

@end

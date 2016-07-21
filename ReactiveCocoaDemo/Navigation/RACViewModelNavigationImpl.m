//
//  RACViewModelNavigationImpl.m
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/20.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import "RACViewModelNavigationImpl.h"
#import "RACDetailViewModel.h"
#import "RACDetailViewController.h"

@interface RACViewModelNavigationImpl ()

// 注意这里！！这是一个弱引用！！引用但没有拥有～
@property (nonatomic, weak) UINavigationController *navigationController;
// 暂时还没用上
@property (nonatomic, strong) NSMutableArray *navigationControllers;

@end

@implementation RACViewModelNavigationImpl

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    
    self = [super init];
    if (self) {
        _navigationController = navigationController;
    }
    return self;
}

- (void)pushViewModel:(id)viewModel {
    
    if (!_navigationController) {
        NSLog(@"navigationController is null!");
        return;
    }
    if ([viewModel isKindOfClass:[RACDetailViewModel class]]) {
        RACDetailViewController *detailViewController = [[RACDetailViewController alloc] initWithViewModel:viewModel];
        [_navigationController pushViewController:detailViewController animated:YES];
        
    } else {
        NSLog(@"an unknown ViewModel was pushed!");
    }
}

- (void)popViewModel {
    
}

- (void)popToRootViewModel {
    
}

@end

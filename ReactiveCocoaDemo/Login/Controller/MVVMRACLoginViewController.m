//
//  MVVMRACLoginViewController.m
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/5/25.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import "MVVMRACLoginViewController.h"
#import "LoginResultViewController.h"
#import "RACLoginViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface MVVMRACLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *loginFailureLabel;

// 引入一个viewModel专门处理逻辑
@property (nonatomic, strong) RACLoginViewModel *viewModel;

@end

@implementation MVVMRACLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MVVM+RAC Login";
    self.viewModel = [[RACLoginViewModel alloc] init];
    
    RAC(self.viewModel, username) = self.usernameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    
    // 应用宏定义控制控件的UI
    RAC(self.usernameTextField, backgroundColor) = [self.viewModel.usernameSignal map:^id(NSNumber *usernameValid) {
        return [usernameValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    RAC(self.passwordTextField, backgroundColor) = [self.viewModel.passwordSignal map:^id(NSNumber *passwordValid) {
        return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    // 注意：得到结果，是否正在执行，发生错误 是用三个信号来分别表示，虽然麻烦些，但结构相当清晰
    @weakify(self);
    [self.viewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        BOOL success = [x boolValue];
        self.loginButton.enabled = YES;
        self.loginFailureLabel.hidden = success;
        // 严格意义上讲，根据结果决定跳转到哪个页面也属于逻辑范畴
        if (success) {
            [self goToLoginSuccessVC];
        }
    }];
    [[self.viewModel.loginCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            NSLog(@"正在执行，显示loading");
        } else {
            NSLog(@"执行完成，隐藏loading");
        }
    }];
    [self.viewModel.connectionErrors subscribeNext:^(NSError *error) {
        NSLog(@"错误了，给个提示 error is %@",error);
    }];
    
    // 通常两种方法使用command
    // 一种方法是可以将button的rac_command属性赋值，此时能自动控制enable属性，按钮点击时就执行了
//    self.loginButton.rac_command = self.viewModel.loginCommand;
    // 另一种方法是直接调用execute:方法，类似[loginCommand execute:@2]，此时还能传进去一个自己可控制的值
    RAC(self.loginButton, enabled) = self.viewModel.loginEnableSignal;
    
    [[[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
          @strongify(self);
        [self.view endEditing:YES];
        self.loginButton.enabled = NO;
        self.loginFailureLabel.hidden = YES;
      }]
     subscribeNext:^(id x) {
         @strongify(self);
        [self.viewModel.loginCommand execute:@2];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)goToLoginSuccessVC {
    LoginResultViewController *loginSuccessVC = [[LoginResultViewController alloc] initWithNibName:@"LoginResultViewController" bundle:nil];
    [self.navigationController pushViewController:loginSuccessVC animated:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

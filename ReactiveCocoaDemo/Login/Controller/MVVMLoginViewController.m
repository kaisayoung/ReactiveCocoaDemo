//
//  MVVMLoginViewController.m
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/5/25.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import "MVVMLoginViewController.h"
#import "RACSearchViewController.h"
#import "LoginViewModel.h"

@interface MVVMLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *loginFailureLabel;

// 引入一个viewModel专门处理逻辑
@property (nonatomic, strong) LoginViewModel *viewModel;

// 为了监控状态仍然添加了两个中间变量
@property (nonatomic, assign) BOOL isUsernameValid;
@property (nonatomic, assign) BOOL isPasswordValid;

@end

@implementation MVVMLoginViewController

+ (instancetype)viewController {
    return [[MVVMLoginViewController alloc] initWithNibName:@"MVVMLoginViewController" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MVVM Login";
    self.viewModel = [[LoginViewModel alloc] init];
    [self.usernameTextField addTarget:self action:@selector(usernameTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(passwordTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
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

- (IBAction)onLoginButtonTapped:(id)sender {
    [self.view endEditing:YES];
    self.loginButton.enabled = NO;
    self.loginFailureLabel.hidden = YES;
    [self.viewModel loginWithUsername:self.usernameTextField.text password:self.passwordTextField.text complete:^(BOOL success) {
        self.loginButton.enabled = YES;
        self.loginFailureLabel.hidden = success;
        if (success) {
            [self goToLoginSuccessVC];
        }
    }];
}

// 登录成功这里只是单纯的界面跳转，若是逻辑修改，也应尽可能的放到ViewModel中
- (void)goToLoginSuccessVC {
    RACSearchViewController *loginSuccessVC = [RACSearchViewController viewController];
    [self.navigationController pushViewController:loginSuccessVC animated:YES];
}

- (void)updateUI {
    self.usernameTextField.backgroundColor = self.isUsernameValid ? [UIColor clearColor] : [UIColor yellowColor];
    self.passwordTextField.backgroundColor = self.isPasswordValid ? [UIColor clearColor] : [UIColor yellowColor];
    self.loginButton.enabled = self.isUsernameValid && self.isPasswordValid;
}

- (void)usernameTextFieldChanged {
    self.isUsernameValid = [self.viewModel isValidUsername:self.usernameTextField.text];
    [self updateUI];
}

- (void)passwordTextFieldChanged {
    self.isPasswordValid = [self.viewModel isValidPassword:self.passwordTextField.text];
    [self updateUI];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

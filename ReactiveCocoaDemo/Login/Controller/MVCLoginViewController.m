//
//  MVCLoginViewController.m
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/5/25.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import "MVCLoginViewController.h"
#import "LoginResultViewController.h"

@interface MVCLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *loginFailureLabel;

// 为了监控状态添加了两个中间变量
@property (nonatomic, assign) BOOL isUsernameValid;
@property (nonatomic, assign) BOOL isPasswordValid;

@end

@implementation MVCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MVC Login";
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

// 模拟触发一个API: 用户名和密码分别为username和password才登录成功
// 调用API属于逻辑范畴，和UI无关
- (void)loginWithUsername:(NSString *)username password:(NSString *)password complete:(void (^)(BOOL))loginResult {
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        BOOL success = [username isEqualToString:@"username"] && [password isEqualToString:@"password"];
        loginResult(success);
    });
}

- (IBAction)onLoginButtonTapped:(id)sender {
    [self.view endEditing:YES];
    self.loginButton.enabled = NO;
    self.loginFailureLabel.hidden = YES;
    [self loginWithUsername:self.usernameTextField.text password:self.passwordTextField.text complete:^(BOOL success) {
        self.loginButton.enabled = YES;
        self.loginFailureLabel.hidden = success;
        if (success) {
            [self goToLoginSuccessVC];
        }
    }];
}

- (void)goToLoginSuccessVC {
    LoginResultViewController *loginSuccessVC = [[LoginResultViewController alloc] initWithNibName:@"LoginResultViewController" bundle:nil];
    [self.navigationController pushViewController:loginSuccessVC animated:YES];
}

- (void)updateUI {
    self.usernameTextField.backgroundColor = self.isUsernameValid ? [UIColor clearColor] : [UIColor yellowColor];
    self.passwordTextField.backgroundColor = self.isPasswordValid ? [UIColor clearColor] : [UIColor yellowColor];
    self.loginButton.enabled = self.isUsernameValid && self.isPasswordValid;
}

- (void)usernameTextFieldChanged {
    self.isUsernameValid = [self isValidUsername:self.usernameTextField.text];
    [self updateUI];
}

- (void)passwordTextFieldChanged {
    self.isPasswordValid = [self isValidPassword:self.passwordTextField.text];
    [self updateUI];
}

// 这两个判断都属于逻辑范畴，和UI无关
- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 6;
}

- (BOOL)isValidPassword:(NSString *)password {
    return password.length > 6;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

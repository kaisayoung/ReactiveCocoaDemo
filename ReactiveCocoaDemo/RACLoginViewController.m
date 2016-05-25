//
//  RACLoginViewController.m
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/5/25.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import "RACLoginViewController.h"
#import "LoginResultViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *loginFailureLabel;

// 监控状态也无需引用任何中间变量

@end

@implementation RACLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RAC Login";
    
    // 创建一个username的signal
    RACSignal *usernameSignal = [self.usernameTextField.rac_textSignal map:^id(NSString *text) {
        return @([self isValidUsername:text]);
    }];
    // 创建一个password的signal
    RACSignal *passwordSignal = [self.passwordTextField.rac_textSignal map:^id(NSString *text) {
        return @([self isValidPassword:text]);
    }];
    // 创建一个login的signal
    RACSignal *loginEnableSignal = [RACSignal combineLatest:@[usernameSignal, passwordSignal]
                                                     reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
                                                         return @([usernameValid boolValue] && [passwordValid boolValue]);}];
    
    // 应用宏定义控制几个控件的UI
    RAC(self.usernameTextField, backgroundColor) = [usernameSignal map:^id(NSNumber *usernameValid) {
        return [usernameValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    RAC(self.passwordTextField, backgroundColor) = [passwordSignal map:^id(NSNumber *passwordValid) {
        return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    RAC(self.loginButton, enabled) = loginEnableSignal;
    
    // 登录按钮点击
    [[[[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    // 添加附加操作
    doNext:^(id x) {
        [self.view endEditing:YES];
        self.loginButton.enabled = NO;
        self.loginFailureLabel.hidden = YES;
    }]
    // 按钮信号转换为登录信号
    flattenMap:^RACStream *(id value) {
        return [self loginSignal];
    }]
    // 获得数据流
    subscribeNext:^(NSNumber *result) {
        BOOL success = [result boolValue];
        self.loginButton.enabled = YES;
        self.loginFailureLabel.hidden = success;
        if (success) {
            [self goToLoginSuccessVC];
        }
    }];
}

- (RACSignal *)loginSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self loginWithUsername:self.usernameTextField.text password:self.passwordTextField.text complete:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
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

- (void)goToLoginSuccessVC {
    LoginResultViewController *loginSuccessVC = [[LoginResultViewController alloc] initWithNibName:@"LoginResultViewController" bundle:nil];
    [self.navigationController pushViewController:loginSuccessVC animated:YES];
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

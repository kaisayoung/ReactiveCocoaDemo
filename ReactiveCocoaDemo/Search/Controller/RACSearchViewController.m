//
//  RACSearchViewController.m
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/18.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import "RACSearchViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RACTableViewBindingHelper.h"
#import "RACSearchResultTableViewCell.h"

@interface RACSearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) RACTableViewBindingHelper *bindingHelper;

@end

@implementation RACSearchViewController

+ (instancetype)viewController {
    return [[RACSearchViewController alloc] initWithNibName:@"RACSearchViewController" bundle:nil];
}

- (instancetype)initWithViewModel:(RACSearchViewModel *)viewModel {
    self = [super initWithNibName:@"RACSearchViewController" bundle:nil];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
}

- (void)bindViewModel {
    
    // 因为本类为一个模块中入口controller，所以要在内部创建viewmodel，以后进入的子级controller的viewmodel由上一层级的viewmodel创建
    if (!_viewModel) {
        RACViewModelNavigationImpl *naviImpl = [[RACViewModelNavigationImpl alloc] initWithNavigationController:self.navigationController];
        _viewModel = [[RACSearchViewModel alloc] initWithNaviImpl:naviImpl];
    }
    self.title = self.viewModel.title;
    @weakify(self);
    RAC(self.viewModel, searchText) = self.searchTextField.rac_textSignal;
    self.searchButton.rac_command = self.viewModel.executeSearch;
    RAC([UIApplication sharedApplication], networkActivityIndicatorVisible) = self.viewModel.executeSearch.executing;
    UINib *nib = [UINib nibWithNibName:@"RACSearchResultTableViewCell" bundle:nil];
    self.bindingHelper = [RACTableViewBindingHelper bindingHelperForTableView:self.tableView
                                                                 sourceSignal:RACObserve(self.viewModel, searchResults)
                                                             selectionCommand:self.viewModel.executeSelection
                                                                 templateCell:nib];
    [self.viewModel.executeSearch.executionSignals subscribeNext:^(id x) {
        @strongify(self);
        [self.searchTextField resignFirstResponder];
    }];
    [self.viewModel.connectionErrors subscribeNext:^(NSError *error) {
        NSLog(@"哎呀错误啦！");
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

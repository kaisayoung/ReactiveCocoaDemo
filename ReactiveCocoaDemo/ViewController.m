//
//  ViewController.m
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/5/24.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import "ViewController.h"
#import "MVCLoginViewController.h"
#import "MVVMLoginViewController.h"
#import "RACLoginViewController.h"
#import "MVVMRACLoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onGoToDemoButtonTapped:(id)sender {
    
    NSInteger type = 4;
    
    switch (type) {
        case 1:
        {
            MVCLoginViewController *loginViewController = [[MVCLoginViewController alloc] initWithNibName:@"MVCLoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginViewController animated:YES];
        }
            break;
        case 2:
        {
            MVVMLoginViewController *loginViewController = [[MVVMLoginViewController alloc] initWithNibName:@"MVVMLoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginViewController animated:YES];
        }
            break;
        case 3:
        {
            RACLoginViewController *loginViewController = [[RACLoginViewController alloc] initWithNibName:@"RACLoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginViewController animated:YES];
        }
            break;
        case 4:
        {
            MVVMRACLoginViewController *loginViewController = [[MVVMRACLoginViewController alloc] initWithNibName:@"MVVMRACLoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginViewController animated:YES];
        }
            break;
        default:
            break;
    }
    
}

@end

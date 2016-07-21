//
//  RACDetailViewController.m
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/19.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import "RACDetailViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface RACDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthorLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookPubdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookPublisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookPagesLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookSummaryLabel;

@end

@implementation RACDetailViewController

- (instancetype)initWithViewModel:(RACDetailViewModel *)viewModel {
    self = [super initWithNibName:@"RACDetailViewController" bundle:nil];
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
    
    self.title = self.viewModel.title;
    self.bookTitleLabel.text = self.viewModel.bookTitle;
    self.bookAuthorLabel.text = self.viewModel.firstAuthor;
    self.bookPubdateLabel.text = self.viewModel.pubdate;
    self.bookPublisherLabel.text = self.viewModel.publisher;
    self.bookPriceLabel.text = self.viewModel.price;
    self.bookPagesLabel.text = self.viewModel.pages;
    self.bookSummaryLabel.text = self.viewModel.summary;
    [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.imageUrl]];
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

@end

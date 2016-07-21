//
//  RACSearchResultTableViewCell.m
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/18.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import "RACSearchResultTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RACBookModel.h"

@interface RACSearchResultTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthorLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookPublisherLabel;

@end

@implementation RACSearchResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindViewModel:(id)viewModel {
    
    // 注意这里传进来的并不是viewmodel，而只是model，因为此处只是简单展示，没有复杂交互，所以可直接用model，从而减少不必要的复杂度
    RACBookModel *bookModel = viewModel;
    
    NSString *firstAuthor = [bookModel.author firstObject];
    _bookAuthorLabel.text = firstAuthor;
    _bookTitleLabel.text = bookModel.title;
    _bookPublisherLabel.text = bookModel.publisher;
    [_bookImageView sd_setImageWithURL:[NSURL URLWithString:bookModel.image]];
    
}

@end

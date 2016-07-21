//
//  RACTableViewBindingHelper.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/18.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

/**
 *  tableview绑定数据的工具类
 */

@interface RACTableViewBindingHelper : NSObject

@property (weak, nonatomic) id<UITableViewDelegate> delegate;

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                             sourceSignal:(RACSignal *)source
                         selectionCommand:(RACCommand *)selection
                             templateCell:(UINib *)templateCellNib;

@end

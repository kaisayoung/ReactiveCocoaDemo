//
//  RACSearchResultTableViewCell.h
//  ReactiveCocoaDemo
//
//  Created by 恺撒 on 16/7/18.
//  Copyright © 2016年 TSJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RACBindViewModelProtocol.h"

/**
 *  搜索页面结果cell，只需要实现上面协议，不需要写绑定数据方法
 */

@interface RACSearchResultTableViewCell : UITableViewCell<RACBindViewModelProtocol>

@end

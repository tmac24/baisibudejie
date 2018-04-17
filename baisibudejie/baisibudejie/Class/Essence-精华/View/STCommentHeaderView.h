//
//  STCommentHeaderView.h
//  baisibudejie
//
//  Created by readygo on 2018/4/17.
//  Copyright © 2018年 孙涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STCommentHeaderView : UITableViewHeaderFooterView
/** 文字数据 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end

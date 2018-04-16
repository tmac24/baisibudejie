//
//  STCommentCell.h
//  baisibudejie
//
//  Created by readygo on 2018/4/16.
//  Copyright © 2018年 孙涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STComment;

@interface STCommentCell : UITableViewCell
/** 评论 */
@property (nonatomic, strong) STComment *comment;
@end

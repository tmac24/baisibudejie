//
//  STCommentViewController.h
//  baisibudejie
//
//  Created by readygo on 2018/4/12.
//  Copyright © 2018年 孙涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STTopic;
@interface STCommentViewController : UIViewController
/** 帖子模型 */
@property (nonatomic, strong) STTopic *topic;
@end

//
//  STTopicVideoView.h
//  baisibudejie
//
//  Created by readygo on 2018/4/12.
//  Copyright © 2018年 孙涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STTopic;

@interface STTopicVideoView : UIView

+ (instancetype)videoView;

/** 帖子数据 */
@property (nonatomic, strong) STTopic *topic;
@end

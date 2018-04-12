//
//  STTopicVoiceView.h
//  baisibudejie
//
//  Created by readygo on 2018/4/11.
//  Copyright © 2018年 孙涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STTopic;

@interface STTopicVoiceView : UIView

+ (instancetype)voiceView;

/** 帖子数据 */
@property (nonatomic, strong) STTopic *topic;
@end

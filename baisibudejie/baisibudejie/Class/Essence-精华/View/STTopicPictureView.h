//
//  STTopicPictureView.h
//  baisibudejie
//
//  Created by readygo on 2017/12/4.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STTopic;
@interface STTopicPictureView : UIView

+ (instancetype)pictureView;

/** 帖子数据 */
@property (nonatomic, strong) STTopic *topic;

@end

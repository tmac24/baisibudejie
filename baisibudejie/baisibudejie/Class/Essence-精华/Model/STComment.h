//
//  STComment.h
//  baisibudejie
//
//  Created by readygo on 2018/4/12.
//  Copyright © 2018年 孙涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STUser;

@interface STComment : NSObject
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) STUser *user;
@end

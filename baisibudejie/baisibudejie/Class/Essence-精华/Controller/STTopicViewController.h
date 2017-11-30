//
//  STTopicViewController.h
//  baisibudejie
//
//  Created by readygo on 2017/11/30.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    STTopicTypeAll = 1,
    STTopicTypePicture = 10,
    STTopicTypeWord = 29,
    STTopicTypeVoice = 31,
    STTopicTypeVideo = 41
} STTopicType;

@interface STTopicViewController : UITableViewController
/** 帖子类型(交给子类去实现) */
@property (nonatomic, assign) STTopicType type;

@end

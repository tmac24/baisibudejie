//
//  STTopicCell.h
//  baisibudejie
//
//  Created by readygo on 2017/11/30.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STTopic;
@interface STTopicCell : UITableViewCell
/**< 模型数据 */
@property (nonatomic, strong) STTopic *topic;

+ (instancetype)cell;
@end

//
//  STTopicPictureView.m
//  baisibudejie
//
//  Created by readygo on 2017/12/4.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STTopicPictureView.h"
#import "STTopic.h"

@interface STTopicPictureView ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@end

@implementation STTopicPictureView

+ (instancetype)pictureView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(STTopic *)topic {
    
    _topic = topic;
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
}
@end

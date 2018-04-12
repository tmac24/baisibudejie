//
//  STTopicVoiceView.m
//  baisibudejie
//
//  Created by readygo on 2018/4/11.
//  Copyright © 2018年 孙涛. All rights reserved.
//

#import "STTopicVoiceView.h"
#import "STTopic.h"

@interface STTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *voicelengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@end

@implementation STTopicVoiceView

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(STTopic *)topic {
    
    _topic = topic;
    
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    // 时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicelengthLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}
@end

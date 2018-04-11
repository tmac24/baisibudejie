//
//  STTopicVoiceView.m
//  baisibudejie
//
//  Created by readygo on 2018/4/11.
//  Copyright © 2018年 孙涛. All rights reserved.
//

#import "STTopicVoiceView.h"

@implementation STTopicVoiceView

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end

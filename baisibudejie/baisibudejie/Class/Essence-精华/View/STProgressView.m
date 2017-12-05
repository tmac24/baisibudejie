//
//  STProgressView.m
//  baisibudejie
//
//  Created by readygo on 2017/12/5.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STProgressView.h"

@implementation STProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end

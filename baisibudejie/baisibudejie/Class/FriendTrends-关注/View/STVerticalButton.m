//
//  STVerticalButton.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/20.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STVerticalButton.h"

@implementation STVerticalButton

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)awakeFromNib {

    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.size.width;
    self.imageView.height = self.size.width;
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.size.width;
    self.titleLabel.height = self.size.height - self.imageView.height;
}

@end

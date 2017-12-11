//
//  STTopicPictureView.m
//  baisibudejie
//
//  Created by readygo on 2017/12/4.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STTopicPictureView.h"
#import "STTopic.h"
//#import "STProgressView.h"
#import "STShowPictureViewController.h"

@interface STTopicPictureView ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/** 进度条控件 */
//@property (weak, nonatomic) IBOutlet STProgressView *progressView;
@end

@implementation STTopicPictureView

+ (instancetype)pictureView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
  
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture {
    
    STShowPictureViewController *showVC = [[STShowPictureViewController alloc] init];
    showVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVC animated:YES completion:nil];
}
- (void)setTopic:(STTopic *)topic {
    
    _topic = topic;
    
    /**
     在不知道图片扩展名的情况下, 如何知道图片的真实类型?
     * 取出图片数据的第一个字节, 就可以判断出图片的真实类型
     */
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
//    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //        self.progressView.hidden = NO;
        // 计算进度值
        //        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        //        [self.progressView setProgress:topic.pictureProgress animated:NO];
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        self.progressView.hidden = YES;
    }];
    
    // 判断是否为gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否显示"点击查看全图"
    if (topic.isBigPicture) { // 大图
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else { // 非大图
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}
@end

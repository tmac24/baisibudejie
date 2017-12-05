//
//  STShowPictureViewController.m
//  baisibudejie
//
//  Created by readygo on 2017/12/5.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STShowPictureViewController.h"
#import "STTopic.h"

@interface STShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** 图片 */
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation STShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 屏幕尺寸
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片尺寸
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > screenH) { // 图片显示高度超过一个屏幕, 需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
}
- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save {
    // 将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}
@end

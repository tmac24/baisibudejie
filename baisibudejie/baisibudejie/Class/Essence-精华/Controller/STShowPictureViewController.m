//
//  STShowPictureViewController.m
//  baisibudejie
//
//  Created by readygo on 2017/12/5.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STShowPictureViewController.h"
#import "STTopic.h"
#import <Photos/Photos.h>
//#import "STProgressView.h"

@interface STShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** 图片 */
@property (nonatomic, weak) UIImageView *imageView;
//@property (weak, nonatomic) IBOutlet STProgressView *progressView;

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
    // 马上显示当前图片的下载进度
//    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
 
    //下载图片    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
////        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:YES];
//    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
////        self.progressView.hidden = YES;
//    }];
    
}
- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save {
    // 将图片写入相册
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并没下载完毕!"];
        return;
    }
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [self loadImageFinished:self.imageView.image];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}
- (void)loadImageFinished:(UIImage *)image
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
//        NSLog(@"success = %d, error = %@", success, error);
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"保存失败!"];
        } else {
            [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
        }
        
    }];
}
@end

//
//  STRecommendViewController.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/17.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface STRecommendViewController ()

@end

@implementation STRecommendViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.title = @"推荐关注";
    
    //设置背景颜色
    self.view.backgroundColor = STGlobalBg;
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDStyleLight];

    //发送请求
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"category";
    parms[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:^(NSProgress * _Nonnull downloadProgress) {
        STLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        //
        STLog(@"%@", responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

@end

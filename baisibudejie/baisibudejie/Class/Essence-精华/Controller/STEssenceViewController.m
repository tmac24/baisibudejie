//
//  STEssenceViewController.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/14.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STEssenceViewController.h"

@interface STEssenceViewController ()

@end

@implementation STEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = STGlobalBg;
}

- (void)tagClick
{
    STLogFunc;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

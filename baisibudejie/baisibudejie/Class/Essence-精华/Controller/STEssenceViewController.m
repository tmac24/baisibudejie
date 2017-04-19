//
//  STEssenceViewController.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/14.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STEssenceViewController.h"
#import "STRecommendTagsViewController.h"

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
    STRecommendTagsViewController *vc = [[STRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

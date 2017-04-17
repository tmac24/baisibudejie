//
//  STFriendTrendsViewController.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/14.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STFriendTrendsViewController.h"
#import "STRecommendViewController.h"

@interface STFriendTrendsViewController ()

@end

@implementation STFriendTrendsViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    // 设置背景色
    self.view.backgroundColor = STGlobalBg;
}

- (void)friendsClick
{
    STRecommendViewController *reVc = [[STRecommendViewController alloc] init];
    
    [self.navigationController pushViewController:reVc animated:YES];
}

@end

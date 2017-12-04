//
//  STEssenceViewController.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/14.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STEssenceViewController.h"
#import "STRecommendTagsViewController.h"
#import "STAllViewController.h"
#import "STWordViewController.h"
#import "STVideoViewController.h"
#import "STPictureViewController.h"
#import "STVoiceTableViewController.h"

#import "STTopicViewController.h"

@interface STEssenceViewController ()<UIScrollViewDelegate>
/** 标签栏红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, strong) UIButton *selectedButton;
/** 顶部所有的标签 */
@property (nonatomic, strong) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation STEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置导航栏
    [self setNav];
    
    //初始化子控制器
    [self setupChildVces];
    
    //设置顶部标签栏
    [self setupTitleView];

    //底部的scrollView
    [self setupContentView];
    

}

/**
 * 初始化子控制器
 */
- (void)setupChildVces {

    STTopicViewController *all = [[STTopicViewController alloc] init];
    all.title = @"全部";
    all.type = STTopicTypeAll;
    [self addChildViewController:all];
    
    STTopicViewController *video = [[STTopicViewController alloc] init];
    video.title = @"视频";
    video.type = STTopicTypeVideo;
    [self addChildViewController:video];
    
    STTopicViewController *voice = [[STTopicViewController alloc] init];
    voice.title = @"声音";
    voice.type = STTopicTypeVoice;;
    [self addChildViewController:voice];
    
    STTopicViewController *picture = [[STTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = STTopicTypePicture;
    [self addChildViewController:picture];
    
    STTopicViewController *word = [[STTopicViewController alloc] init];
    word.title = @"段子";
    word.type = STTopicTypeWord;
    [self addChildViewController:word];
}

/**
 * 底部的scrollView
 */
- (void)setupContentView {

    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];

}


- (void)titleClick:(UIButton *)button {
    
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}

- (void)tagClick
{
    STRecommendTagsViewController *vc = [[STRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 * 设置顶部标签栏
 */
- (void)setupTitleView {
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 0;//64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        //        [button layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];//对应上面的选中按钮不能点击，enabled = no;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    //得把红色指示器添加到最后面
    [titlesView addSubview:indicatorView];

}

/**
 * 设置导航栏
 */
- (void)setNav {
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = STGlobalBg;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end

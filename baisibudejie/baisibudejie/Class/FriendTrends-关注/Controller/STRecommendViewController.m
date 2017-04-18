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
#import <MJExtension.h>
#import "STRecommendCategoryCell.h"
#import "STRecommendCategory.h"
#import "STRecommendUser.h"
#import "STRecommendUserCell.h"

@interface STRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

/** 右边的表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;


@end

@implementation STRecommendViewController

static NSString * const STCategoryId = @"category";
static NSString * const STUserId = @"user";

- (void)viewDidLoad {

    [super viewDidLoad];
    
    //控件初始化
    [self setupTableView];
    
    //显示指示器
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];

    //发送请求
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"category";
    parms[@"c"] = @"subscribe";
    //http://api.budejie.com/api/api_open.php
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回Json数据,字典数组转模型数组
        self.categories = [STRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:(UITableViewScrollPositionTop)];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

- (void)setupTableView {

    //注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([STRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:STCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([STRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:STUserId];
    //设置insert
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    self.title = @"推荐关注";
    
    //设置背景颜色
    self.view.backgroundColor = STGlobalBg;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTableView) { //左边的类别表格
        return self.categories.count;

    }else{//右边的用户表格
        
        STRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        return c.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.categoryTableView) { //左边的类别数据
        STRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:STCategoryId];
        cell.category = self.categories[indexPath.row];
        
        return cell;
    }else {
        STRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:STUserId];
        STRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    STRecommendCategory *c = self.categories[indexPath.row];
    
    //发送给服务器，加载右边的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(c.id);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users= [STRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [c.users addObjectsFromArray:users];
        
        //刷新右边表格
        [self.userTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        STLog(@"%@",error);
    }];
}

/**
 1.目前只能显示1页数据
 2.重复发送请求
 3.网络慢带来的细节问题
 */


@end

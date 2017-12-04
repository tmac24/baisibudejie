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
#import <MJRefresh.h>
#define STSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface STRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/**< 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;
/**< AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation STRecommendViewController

static NSString * const STCategoryId = @"category";
static NSString * const STUserId = @"user";

- (AFHTTPSessionManager *)manager {
    
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    //控件初始化
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //加载左侧类别数据
    [self loadCategories];
}

/** 加载左侧类别数据 */
- (void)loadCategories{
    //显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"a"] = @"category";
    parms[@"c"] = @"subscribe";
    //http://api.budejie.com/api/api_open.php
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回Json数据,字典数组转模型数组
        self.categories = [STRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:(UITableViewScrollPositionTop)];
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

- (void)setupRefresh {
    
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

- (void)loadMoreUsers {
    
    STRecommendCategory *rc = STSelectedCategory;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.ID);
    params[@"page"] = @(++rc.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 字典数组 -> 模型数组
        NSArray *users= [STRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        //不是最后一次请求
        if (self.params != params) return;
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

- (void)loadNewUsers {
    
    STRecommendCategory *rc = STSelectedCategory;
    //设置当前页码为1
    rc.currentPage = 1;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.ID);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        STLog(@"%@",responseObject);
        // 字典数组 -> 模型数组
        NSArray *users= [STRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清除所有旧数据
        [rc.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        //保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求
        if (self.params != params) return;
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        //让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}
/** 时刻监测footer的状态 */
- (void)checkFooterState {
    
    STRecommendCategory *rc = STSelectedCategory;
    //每次刷新右边数据时，都控制footer显示还是隐藏
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    //让底部控件结束刷新
    if (rc.users.count == rc.total) { //全部数据已加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.userTableView.mj_footer endRefreshing];
    }
}

- (void)setupTableView {

    //注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([STRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:STCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([STRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:STUserId];
    //设置insert
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    self.categoryTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.userTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.title = @"推荐关注";
    
    //设置背景颜色
    self.view.backgroundColor = STGlobalBg;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //左边的类别表格
    if (tableView == self.categoryTableView) return self.categories.count;
    
    // 监测footer的状态
    [self checkFooterState];
    //右边的用户表格
    return [STSelectedCategory users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.categoryTableView) { //左边的类别数据
        STRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:STCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else {
        STRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:STUserId];
        cell.user = [STSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // 结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    STRecommendCategory *c = self.categories[indexPath.row];
    
    if (c.users.count) {
        //显示曾经的数据
        [self.userTableView reloadData];
    }else{
        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
        
        // 进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark - 控制器的销毁
- (void)dealloc
{
    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}
@end

//
//  STWordViewController.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/23.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STTopicViewController.h"
#import "STTopic.h"
#import "STTopicCell.h"


@interface STTopicViewController ()
/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation STTopicViewController

- (NSArray *)topics {
    
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

static NSString *const STTopicCellId = @"topic";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化表格
    [self setupTableView];
    
    //添加新控件
    [self setupRefresh];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([STTopicCell class]) bundle:nil] forCellReuseIdentifier:STTopicCellId];
    
}
/**
 * 初始化表格
 */
- (void)setupTableView
{
    // 设置内边距
    //    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = STTitilesViewY + STTitilesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)setupRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动更新透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}
#pragma mark - 数据处理
/**
 * 加载新的帖子数据
 */

- (void)loadNewTopics {
    
    [self.tableView.mj_footer endRefreshing];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;
//        STLog(@"%@",responseObject);
        //        [responseObject writeToFile:@"/Users/readygo/Desktop/practice/topic.plist" atomically:YES];
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        self.topics = [STTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 清空页码
        self.page = 0;
        [responseObject writeToFile:@"/Users/suntao/Desktop/duanzi.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
}
// 先下拉刷新, 再上拉刷新第5页数据

// 下拉刷新成功回来: 只有一页数据, page == 0
// 上啦刷新成功回来: 最前面那页 + 第5页数据

/**
 * 加载更多的帖子数据
 */
- (void)loadMoreTopics {
    
    //结束下拉
    [self.tableView.mj_header endRefreshing];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        NSArray *newTopics = [STTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        // 设置页码
        self.page = page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STTopic *top = self.topics[indexPath.row];
    [top cellHeight];
    
    STTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:STTopicCellId];
    
    cell.topic = self.topics[indexPath.row];

    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STTopic *top = self.topics[indexPath.row];
    
    return top.cellHeight;
}

@end


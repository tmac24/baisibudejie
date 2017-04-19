//
//  STRecommendTagsViewController.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/19.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STRecommendTagsViewController.h"
#import "STRecommendTagCell.h"
#import "STRecommendTag.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>


@interface STRecommendTagsViewController ()
/** 标签数据 */
@property (nonatomic, strong) NSArray *tags;

@end
static NSString * const STTagsId = @"tag";
@implementation STRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadTags];
}

- (void)setupTableView{
    
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([STRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:STTagsId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = STGlobalBg;
}

- (void)loadTags{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];

    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tags = [STRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    STRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:STTagsId];
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}


@end

//
//  STLoginRegisterViewController.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/19.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STLoginRegisterViewController.h"

@interface STLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginView;

@end

@implementation STLoginRegisterViewController
- (IBAction)closeClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showLoginOrRegister:(UIButton *)sender {
    
//    // 退出键盘
//    [self.view endEditing:YES];
//    
//    if (self.loginViewLeftMargin.constant == 0) { // 显示注册界面
//        self.loginViewLeftMargin.constant = - self.view.width;
//        button.selected = YES;
//        //        [button setTitle:@"已有账号?" forState:UIControlStateNormal];
//    } else { // 显示登录界面
//        self.loginViewLeftMargin.constant = 0;
//        button.selected = NO;
//        //        [button setTitle:@"注册账号" forState:UIControlStateNormal];
//    }
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        [self.view layoutIfNeeded];
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

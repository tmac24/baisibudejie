//
//  STRecommendUserCell.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/18.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STRecommendUserCell.h"
#import "STRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface STRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end
@implementation STRecommendUserCell

- (void)setUser:(STRecommendUser *)user {

    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

}

@end

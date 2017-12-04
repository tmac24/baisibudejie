//
//  STRecommendCategory.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/17.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STRecommendCategory.h"

@implementation STRecommendCategory

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

- (NSMutableArray *)users {

    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end

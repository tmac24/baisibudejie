//
//  STRecommendCategory.h
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/17.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STRecommendCategory : NSObject
/** id */
@property (nonatomic, assign) NSInteger ID;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;

/**< 总数 */
@property (nonatomic, assign) NSInteger total;
/**< 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@end


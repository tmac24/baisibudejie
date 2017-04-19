//
//  STRecommendTag.h
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/19.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STRecommendTag : NSObject
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;
@end

//
//  STRecommendCategoryCell.m
//  baisibudejie
//
//  Created by 孙涛 on 2017/4/17.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STRecommendCategoryCell.h"
#import "STRecommendCategory.h"

@interface STRecommendCategoryCell ()
/** 选中时显示的指示器控件 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;
@end

@implementation STRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = STRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = STRGBColor(219, 21, 26);
    // 当cell的selection为None时, cell被选中时, 内部的子控件就不会进入高亮状态
    //    self.textLabel.textColor = XMGRGBColor(78, 78, 78);
    //    self.textLabel.highlightedTextColor = XMGRGBColor(219, 21, 26);
    //    UIView *bg = [[UIView alloc] init];
    //    bg.backgroundColor = [UIColor clearColor];
    //    self.selectedBackgroundView = bg;
 
}

- (void)setCategory:(STRecommendCategory *)category {

    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : STRGBColor(78, 78, 78);    
}

@end

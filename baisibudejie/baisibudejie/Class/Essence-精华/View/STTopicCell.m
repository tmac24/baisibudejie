//
//  STTopicCell.m
//  baisibudejie
//
//  Created by readygo on 2017/11/30.
//  Copyright © 2017年 孙涛. All rights reserved.
//

#import "STTopicCell.h"
#import "STTopic.h"
#import "STTopicPictureView.h"

@interface STTopicCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 帖子文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间图片内容 */
@property (nonatomic, weak) STTopicPictureView *pictureView;

@end

@implementation STTopicCell

- (STTopicPictureView *)pictureView {
    
    if (!_pictureView) {
        STTopicPictureView *pictureView = [STTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
  
}

- (void)setTopic:(STTopic *)topic {
    _topic = topic;
    
//    NSInteger i = arc4random_uniform(100)%2;
    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;//!i;
    // 设置其他控件
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    //设置帖子文字内容
    self.text_label.text = topic.text;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == STTopicTypePicture) { // 图片帖子
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    } else if (topic.type == STTopicTypeVoice) { // 声音帖子
        //        self.voiceView.topic = topic;
        //        self.voiceView.frame = topic.voiceF;
    }
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    //    NSString *title = nil;
    //    if (count == 0) {
    //        title = placeholder;
    //    } else if (count > 10000) {
    //        title = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    //    } else {
    //        title = [NSString stringWithFormat:@"%zd", count];
    //    }
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = STTopicCellMargin;
    frame.size.width -= 2 * STTopicCellMargin;
    frame.size.height -= STTopicCellMargin;
    frame.origin.y += STTopicCellMargin;
    
    [super setFrame:frame];
}
@end

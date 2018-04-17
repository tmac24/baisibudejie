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
#import "STTopicVoiceView.h"
#import "STTopicVideoView.h"

#import "STUser.h"
#import "STComment.h"

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
/** 声音帖子中间图片内容 */
@property (nonatomic, weak) STTopicVoiceView *voiceView;
/** 视频帖子中间的内容 */
@property (nonatomic, weak) STTopicVideoView *videoView;

/** 最热评论的内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论的整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation STTopicCell

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


- (STTopicVideoView *)videoView {
    
    if (!_videoView) {
        STTopicVideoView *videoView = [STTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (STTopicPictureView *)pictureView {

    if (!_pictureView) {
        STTopicPictureView *pictureView = [STTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (STTopicVoiceView *)voiceView {
    
    if (!_voiceView) {
        STTopicVoiceView *voiceView = [STTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.autoresizingMask = UIViewAutoresizingNone;
    
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
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == STTopicTypeVoice) { // 声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == STTopicTypeVideo) { // 视频帖子
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else { // 段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    // 处理最热评论
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
    
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{

    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
//    frame.origin.x = STTopicCellMargin;
//    frame.size.width -= 2 * STTopicCellMargin;
//    frame.size.height -= STTopicCellMargin;
    frame.size.height = self.topic.cellHeight - STTopicCellMargin;
    frame.origin.y += STTopicCellMargin;
    
    [super setFrame:frame];
}


- (IBAction)more {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    [sheet showInView:self.window];
}
@end


#import <UIKit/UIKit.h>

typedef enum {
    STTopicTypeAll = 1,
    STTopicTypePicture = 10,
    STTopicTypeWord = 29,
    STTopicTypeVoice = 31,
    STTopicTypeVideo = 41
} STTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const STTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const STTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const STTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const STTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const STTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const STTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const STTopicCellPictureBreakH;

/** XMGUser模型-性别属性值 */
UIKIT_EXTERN NSString * const STUserSexMale;
UIKIT_EXTERN NSString * const STUserSexFemale;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const STTopicCellTopCmtTitleH;

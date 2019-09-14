//
//  JDHomePageStarRatingView.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBACKGROUND_STAR @"HomePagePingfen"
#define kFOREGROUND_STAR @"HomePagePingfenSel"
#define kNUMBER_OF_STAR  5

@class JDHomePageStarRatingView;

@protocol StarRatingViewDelegate <NSObject>

@optional

-(void)starRatingView:(JDHomePageStarRatingView *_Nullable)view score:(float)score;

@end


NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageStarRatingView : UIView

@property (nonatomic, readonly) int numberOfStar;
@property (nonatomic, weak) id <StarRatingViewDelegate> delegate;

/**
 *  Init TQStarRatingView
 *
 *  @param frame  Rectangles
 *  @param number 星星个数
 *
 *  @return TQStarRatingViewObject
 */
- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number;

/**
 *  设置控件分数
 *
 *  @param score     分数，必须在 0 － 1 之间
 *  @param isAnimate 是否启用动画
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate;

/**
 *  设置控件分数
 *
 *  @param score      分数，必须在 0 － 1 之间
 *  @param isAnimate  是否启用动画
 *  @param completion 动画完成block
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END

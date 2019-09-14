//
//  JDHomePageStarRatingView.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageStarRatingView.h"
/** 图片的间隔 */
static NSInteger kInterval = 5;
/** 图片的宽度 */
static NSInteger kIconWidth = 20;

@interface JDHomePageStarRatingView ()

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;

@end


@implementation JDHomePageStarRatingView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStar:kNUMBER_OF_STAR];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _numberOfStar = kNUMBER_OF_STAR;
    [self commonInit];
}

/**
 *  初始化TQStarRatingView
 *
 *  @param frame  Rectangles
 *  @param number 星星个数
 *
 *  @return TQStarRatingViewObject
 */
- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStar = number;
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.starBackgroundView = [self buidlStarViewWithImageName:kBACKGROUND_STAR];
    self.starForegroundView = [self buidlStarViewWithImageName:kFOREGROUND_STAR];
    [self addSubview:self.starBackgroundView];
    [self addSubview:self.starForegroundView];
}

#pragma mark -
#pragma mark - Set Score

/**
 *  设置控件分数
 *
 *  @param score     分数，必须在 0 － 1 之间
 *  @param isAnimate 是否启用动画
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate
{
    [self setScore:score withAnimation:isAnimate completion:^(BOOL finished){}];
}

/**
 *  设置控件分数
 *
 *  @param score      分数，必须在 0 － 1 之间
 *  @param isAnimate  是否启用动画
 *  @param completion 动画完成block
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion
{
    NSAssert((score >= 0.0)&&(score <= 1.0), @"score must be between 0 and 1");
    
    if (score < 0){
        score = 0;
    }
    
    if (score > 1){
        score = 1;
    }
    
    CGPoint point = CGPointMake(score * kIconWidth * _numberOfStar, 0);
    
    if(isAnimate){
        __weak __typeof(self)weakSelf = self;
        
        [UIView animateWithDuration:0.2 animations:^{
            [weakSelf changeStarForegroundViewWithPoint:point];
        } completion:^(BOOL finished){
            if (completion){
                completion(finished);
            }
        }];
    } else {
        [self changeStarForegroundViewWithPoint:point];
    }
}

#pragma mark -
#pragma mark - Touche Event
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self];
//    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    if(CGRectContainsPoint(rect,point)){
//        [self changeStarForegroundViewWithPoint:point];
//    }
//}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self].x;
    
    int number = ceilf([touch locationInView:self].x / (kIconWidth + 2 * kInterval));
    
    CGFloat mobileDistance =  number * kIconWidth;
    
    CGPoint point = CGPointMake(mobileDistance, 0);
    __weak __typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf changeStarForegroundViewWithPoint:point];
    }];
}

#pragma mark -
#pragma mark - Buidl Star View

/**
 *  通过图片构建星星视图
 *
 *  @param imageName 图片名称
 *
 *  @return 星星视图
 */
- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < self.numberOfStar; i ++){
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(kInterval + i * (kIconWidth + 2 * kInterval), 0, kIconWidth, 20);
        [view addSubview:imageView];
    }
    return view;
}

#pragma mark -
#pragma mark - Change Star Foreground With Point

/**
 *  通过坐标改变前景视图
 *
 *  @param point 坐标
 */
- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    
    if (p.x < 0){
        p.x = 0;
    }
//   除去间隔的总宽度
    float totalStarWidth = kIconWidth * _numberOfStar;
    
    if (p.x > totalStarWidth){
        p.x = totalStarWidth;
    }
    
    
    float coversWidth = p.x + (int)(p.x/kIconWidth) * 2 * kInterval + kInterval;
    
    
    NSString * str = [NSString stringWithFormat:@"%0.2f", p.x / kIconWidth];
    float score = [str floatValue];
//    p.x = score * self.frame.size.width;
    self.starForegroundView.frame = CGRectMake(0, 0, coversWidth, self.frame.size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)]){
        [self.delegate starRatingView:self score:score];
    }
}

@end

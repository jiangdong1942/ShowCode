//
//  JDHomePageProductDetailsAgencyRatingsHeaderView.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsAgencyRatingsHeaderView.h"
#import "JDHomePageStarRatingView.h"
#import "JDHomePageProductDetailsAgencyRatingsModel.h"

@interface JDHomePageProductDetailsAgencyRatingsHeaderView ()
/** 顶部的分割线 */
@property(nonatomic, strong)UIView *topView;
/** 底部的分割线 */
@property(nonatomic, strong)UIView *bottomView;

/** 平均数 */
@property(nonatomic, strong)UILabel *scoreLabel;
/** 显示星星 */
@property(nonatomic, strong)JDHomePageStarRatingView *startView;

@end

@implementation JDHomePageProductDetailsAgencyRatingsHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
        }];
        
        [self addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(10);
        }];
        
        [self addSubview:self.scoreLabel];
        [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(10);
        }];
        
        [self addSubview:self.startView];
        [self.startView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-60);
            make.bottom.mas_equalTo(-12);
            make.width.mas_equalTo(140);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

- (void)setModel:(JDHomePageProductDetailsAgencyRatingsModel *)model{
    _model = model;
    
    self.titleLabel.text = [NSString stringWithFormat:@"服务综合能力评价(%@)", model.total];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@分", model.score];
    [self.startView setScore:[[NSString stringWithFormat:@"%@", model.score] doubleValue] * 0.2
               withAnimation:YES];
}

#pragma mark - 懒加载
- (UIView *)topView{
    
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = UIColor.zt_backgroundView;
    }
    return _topView;
}

- (UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = UIColor.zt_backgroundView;
    }
    return _bottomView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        
        _titleLabel.textColor = UIColor.zt_fontBlack;
        _titleLabel.font = UIFont.zt_font14;
        _titleLabel.text = @"服务综合能力评价";
    }
    return _titleLabel;
}

- (UILabel *)scoreLabel{
    
    if (!_scoreLabel) {
        _scoreLabel = [UILabel new];
        
        _scoreLabel.textColor = UIColor.zt_fontBlack;
        _scoreLabel.font = UIFont.zt_font14;
    }
    return _scoreLabel;
}

- (JDHomePageStarRatingView *)startView{
    
    if (!_startView) {
        _startView = [[JDHomePageStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 150, 20)
                                                        numberOfStar:5];
        _startView.userInteractionEnabled = NO;
    }
    return _startView;
}
@end

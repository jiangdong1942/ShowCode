//
//  JDHomePageProductDetailsAgencyRatingsTableViewCell.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsAgencyRatingsTableViewCell.h"
#import "JDHomePageStarRatingView.h"
#import "JDHomePageProductDetailsAgencyRatingsDetailModel.h"

@interface JDHomePageProductDetailsAgencyRatingsTableViewCell ()
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
/** 星星的背景 */
@property (weak, nonatomic) IBOutlet UIView *startView;
/** 评分 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 项目的背景 */
@property (weak, nonatomic) IBOutlet UIView *projectBackgroundView;
/** 项目的标题 */
@property (weak, nonatomic) IBOutlet UILabel *projectTitleLabel;
/** 分割线 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property(nonatomic, strong)JDHomePageStarRatingView *start;

@end

@implementation JDHomePageProductDetailsAgencyRatingsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.startView addSubview:self.start];
    
    self.titleLabel.textColor = UIColor.zt_fontBlack;
    self.timerLabel.textColor = UIColor.zt_fontGray999;
    self.scoreLabel.textColor = UIColor.zt_fontBlack;
    self.contentLabel.textColor = UIColor.zt_fontBlack;
    self.projectTitleLabel.textColor = UIColor.zt_fontColor666;
    self.projectBackgroundView.backgroundColor = UIColor.zt_backgroundView;
    self.bottomView.backgroundColor = UIColor.zt_backgroundView;
    
    self.projectBackgroundView.layer.masksToBounds = YES;
    self.projectBackgroundView.layer.cornerRadius = 2.0f;
}

- (JDHomePageStarRatingView *)start{
    
    if (!_start) {
        _start = [[JDHomePageStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 150, 20)
                                                    numberOfStar:5];
        _start.userInteractionEnabled = NO;
        
    }
    return _start;
}

- (void)setModel:(JDHomePageProductDetailsAgencyRatingsDetailModel *)model{
    _model = model;
    
    self.titleLabel.text = model.creator;
    self.timerLabel.text = model.create_time;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@分", model.score];
    self.contentLabel.text = model.jd_description;
    self.projectTitleLabel.text = model.project_name;
    [self.start setScore:[[NSString stringWithFormat:@"%@", model.score] doubleValue] * 0.2
           withAnimation:YES];
}

@end

//
//  JDHomePageFinancialPolicyThreeTableViewCell.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageFinancialPolicyThreeTableViewCell.h"
#import "UIImageView+Border.h"
#import "JDHomePageFinancialPolicyModel.h"

@interface JDHomePageFinancialPolicyThreeTableViewCell ()
/** 新闻的标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 新闻的第一张图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconFirstImageView;
/** 新闻的第二张图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconSecondImageView;
/** 新闻的第三张图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconThreeImageView;
/** 来源 */
@property (weak, nonatomic) IBOutlet UILabel *resourceLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
/** 分割线 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation JDHomePageFinancialPolicyThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.textColor = UIColor.zt_fontGray;
    self.titleLabel.font = UIFont.zt_font15;
    
    self.resourceLabel.textColor = UIColor.zt_fontColor666;
    self.resourceLabel.font = UIFont.zt_font12;
    
    self.timerLabel.textColor = UIColor.zt_fontGray999;
    self.timerLabel.font = UIFont.zt_font12;
    
    self.bottomView.backgroundColor = UIColor.zt_bottomViewColore1e1e1;
    
    [self.iconFirstImageView addBorders];
    [self.iconSecondImageView addBorders];
    [self.iconThreeImageView addBorders];
    
    self.iconFirstImageView.layer.masksToBounds = YES;
    self.iconFirstImageView.layer.cornerRadius = 5.0f;
}


- (void)setModel:(JDHomePageFinancialPolicyModel *)model{
    self.titleLabel.text = model.title;
    self.resourceLabel.text = model.vicetitle;
    self.timerLabel.text = model.releasetime;
    

    
    if ([DataCheck isValidString:model.newsImage.firstObject]) {
        [self.iconFirstImageView sd_setImageWithURL:[NSURL URLWithString:model.newsImage.firstObject]];
    }
    
    if ([DataCheck isValidString:model.newsImage[1]]) {
        [self.iconSecondImageView sd_setImageWithURL:[NSURL URLWithString:model.newsImage[1]]];
    }
    
    if ([DataCheck isValidString:model.newsImage[2]]) {
        [self.iconThreeImageView sd_setImageWithURL:[NSURL URLWithString:model.newsImage[2]]];
    }
}


- (void)setIsShowBottom:(BOOL)isShowBottom{
    _isShowBottom = isShowBottom;
    
    self.bottomView.hidden = isShowBottom;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

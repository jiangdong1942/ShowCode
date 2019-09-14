//
//  JDHomePageFinancialPolicyTableViewCell.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageFinancialPolicyTableViewCell.h"
#import "JDHomePageFinancialPolicyModel.h"
#import "UIImageView+Border.h"

@interface JDHomePageFinancialPolicyTableViewCell ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/** 图片的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImageViewHeight;
/** 如果没有图片文字居右15，如果有图片居右125 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleRight;
/** 新闻的标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 新闻的来源 */
@property (weak, nonatomic) IBOutlet UILabel *resourceLabel;
/** 新闻的时间 */
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
/** 分割线 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end
@implementation JDHomePageFinancialPolicyTableViewCell

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
    [self.iconImageView addBorders];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(JDHomePageFinancialPolicyModel *)model{
    _model = model;
    if ([DataCheck isValidArray:model.newsImage]) {
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.newsImage.firstObject]];
        self.iconImageView.hidden = NO;
        self.iconImageViewHeight.constant = 72;
        
        self.titleRight.constant = 125;
        
        
    }else{
        self.iconImageView.hidden = YES;
        self.iconImageViewHeight.constant = 0;
        
        self.titleRight.constant = 15;
    }
    
    self.titleLabel.text = model.title;
    self.resourceLabel.text = model.vicetitle;
    self.timerLabel.text = model.releasetime;
    
}

- (void)setIsShowBottom:(BOOL)isShowBottom{
    _isShowBottom = isShowBottom;
    
    self.bottomView.hidden = isShowBottom;
}

@end

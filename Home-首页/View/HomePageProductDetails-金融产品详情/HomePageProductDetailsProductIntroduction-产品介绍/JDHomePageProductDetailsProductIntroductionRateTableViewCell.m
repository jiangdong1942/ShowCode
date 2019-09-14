//
//  JDHomePageProductDetailsProductIntroductionRateTableViewCell.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsProductIntroductionRateTableViewCell.h"
#import "JDHomePageProductDetailsProductIntroductionModel.h"
#import "UIFont+JDSize.h"

@interface JDHomePageProductDetailsProductIntroductionRateTableViewCell ()
/** 贷款类型的宽度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loanTypeWite;
/** 产品名称 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 产品类型 */
@property (weak, nonatomic) IBOutlet UILabel *loanTypeLabel;
/** 贷款额度 */
@property (weak, nonatomic) IBOutlet UILabel *loanAmountLabel;
/** 年费率 */
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
/** 贷款的期限 */
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
/** 提示性文字，主要是为了修改文字大小，文字的颜色 */
@property (weak, nonatomic) IBOutlet UILabel *loanAmountTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *LimitTipLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation JDHomePageProductDetailsProductIntroductionRateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.loanAmountTipLabel.textColor = UIColor.zt_fontGray999;
    self.rateTipLabel.textColor = UIColor.zt_fontGray999;
    self.LimitTipLabel.textColor = UIColor.zt_fontGray999;
    
    
    self.loanAmountTipLabel.font = UIFont.zt_font12;
    self.rateTipLabel.font = UIFont.zt_font12;
    self.LimitTipLabel.font = UIFont.zt_font12;
    
    self.loanAmountLabel.textColor = UIColor.zt_textColorFc8930;
    self.titleLabel.textColor = UIColor.zt_fontGray;
    
    self.bottomView.backgroundColor = UIColor.zt_backgroundView;
    
    self.loanTypeLabel.textColor = UIColor.zt_textColorFc8930;
    self.loanTypeLabel.layer.borderWidth = 0.5f;
    self.loanTypeLabel.layer.borderColor = UIColor.zt_textColorFc8930.CGColor;
    self.loanTypeLabel.layer.masksToBounds = YES;
    self.loanTypeLabel.layer.cornerRadius = 2.0f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) setModel:(JDHomePageProductDetailsProductIntroductionModel *)model{
    _model = model;
    
    self.titleLabel.text = model.product_name;
    
    self.loanTypeLabel.text = model.product_type_name;
    
    self.loanAmountLabel.text = [NSString stringWithFormat:@"%@-%@W", model.loan_limit_begin, model.loan_limit_end];
    
    self.rateLabel.text = [NSString stringWithFormat:@"%@%%-%@%%", model.reference_rate_begin, model.reference_rate_end];
    
    self.limitLabel.text = [NSString stringWithFormat:@"%@-%@", model.loan_period_begin, model.loan_period_end];
    
    CGSize typeSize = [UIFont zt_string:model.loan_type_name WithHight:16 font:12];
    
    self.loanTypeWite.constant = typeSize.width + 10;
    
}

@end

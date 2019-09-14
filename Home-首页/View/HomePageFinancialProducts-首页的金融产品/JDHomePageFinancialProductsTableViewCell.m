//
//  JDHomePageFinancialProductsTableViewCell.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageFinancialProductsTableViewCell.h"
#import "JDHomePageFinancialProductsModel.h"
@interface JDHomePageFinancialProductsTableViewCell ()

/** 贷款类型 */
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
/** 金融产品名称 */
@property (weak, nonatomic) IBOutlet UILabel *productName;
/** 产品贷款的期限 */
@property (weak, nonatomic) IBOutlet UILabel *loanTimeLimitLabel;
/** 产品贷款的利率 */
@property (weak, nonatomic) IBOutlet UILabel *loanInterestRateLabel;
/** 贷款公司的图片  */
@property (weak, nonatomic) IBOutlet UIImageView *companyLog;
/** 贷款的额度 */
@property (weak, nonatomic) IBOutlet UILabel *loanAmountLabel;
/** 申请融资的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *applyFForFundingButton;
/** 分割线 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@end

@implementation JDHomePageFinancialProductsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.productName.textColor = UIColor.zt_fontGray;
    self.loanTimeLimitLabel.textColor = UIColor.zt_fontColor666;
    self.loanInterestRateLabel.textColor = UIColor.zt_fontColor666;
    self.loanAmountLabel.textColor = UIColor.zt_textColorFc8930;
    
    [self.applyFForFundingButton setTitleColor:UIColor.zt_redButton
                                      forState:UIControlStateNormal];
    [self.applyFForFundingButton setBackgroundColor:UIColor.zt_buttonBackgroundColorffebe8];
    
    self.applyFForFundingButton.layer.masksToBounds = YES;
    self.applyFForFundingButton.layer.cornerRadius = 13.0f;
    
    self.bottomView.backgroundColor = UIColor.zt_bottomViewColore1e1e1;
}

- (void)setModel:(JDHomePageFinancialProductsModel *)model{
    _model = model;
    
    
    [self.companyLog sd_setImageWithURL:[NSURL URLWithString:model.head_portrait]];
    
    self.productName.text = self.model.product_name;
    self.loanTimeLimitLabel.text = [NSString stringWithFormat:@"%@-%@月", self.model.loan_period_begin, self.model.loan_period_end];
    self.loanInterestRateLabel.text = [NSString stringWithFormat:@"%@-%@%%", self.model.reference_rate_begin, self.model.reference_rate_end];
    self.loanAmountLabel.text = [NSString stringWithFormat:@"%@-%@W", self.model.loan_limit_begin, self.model.loan_limit_end];
}

- (void)setIsShowBottom:(BOOL)isShowBottom{
    _isShowBottom = isShowBottom;
    
    self.bottomView.hidden = isShowBottom;
}
/** 申请融资的按钮点击事件 */
- (IBAction)applyForfundingButtonClick:(UIButton *)sender {
}
@end

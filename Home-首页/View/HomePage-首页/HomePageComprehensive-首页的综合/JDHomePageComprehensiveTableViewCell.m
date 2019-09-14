//
//  JDHomePageComprehensiveTableViewCell.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageComprehensiveTableViewCell.h"
#import "NSString+attribute.h"
#import "JDHomePageComprehensiveModel.h"

@interface JDHomePageComprehensiveTableViewCell ()
/** 认证企业 */
@property (weak, nonatomic) IBOutlet UILabel *authenticationEnterpriseTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authenticationEnterpriseNumberLabel;
/** 金融产品 */
@property (weak, nonatomic) IBOutlet UILabel *cooperationAgencyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cooperationAgencyNumberLabel;
/** 融资需求 */
@property (weak, nonatomic) IBOutlet UILabel *projectRequirementTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectRequirementDetailLabel;
/** 解决资金 */
@property (weak, nonatomic) IBOutlet UILabel *solveMoneyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *solveMoneyNumberLabel;

@end

@implementation JDHomePageComprehensiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = UIColor.zt_backgroundView;
    
    self.solveMoneyNumberLabel.textColor = UIColor.zt_redButton;
    self.solveMoneyTitleLabel.textColor = UIColor.zt_fontColor666;
    
    self.cooperationAgencyNumberLabel.textColor = UIColor.zt_redButton;
    self.cooperationAgencyTitleLabel.textColor = UIColor.zt_fontColor666;
    
    self.projectRequirementDetailLabel.textColor = UIColor.zt_redButton;
    self.projectRequirementTitleLabel.textColor = UIColor.zt_fontColor666;
    
    self.authenticationEnterpriseNumberLabel.textColor = UIColor.zt_redButton;
    self.authenticationEnterpriseTitleLabel.textColor = UIColor.zt_fontColor666;
    
    
    
}

- (void)setModel:(JDHomePageComprehensiveModel *)model{
    _model = model;
    self.authenticationEnterpriseNumberLabel.attributedText = [[NSString stringWithFormat:@"%@家", model.authenticationCompanyCount] stringTurnAttributeString:@"家" withFont:12 withColor:UIColor.redColor];
    self.cooperationAgencyNumberLabel.attributedText = [[NSString stringWithFormat:@"%@家", model.auditApprovalProductCount] stringTurnAttributeString:@"家" withFont:12 withColor:UIColor.redColor];
    self.projectRequirementDetailLabel.attributedText = [[NSString stringWithFormat:@"%@个", model.adoptCompanyProjectCount] stringTurnAttributeString:@"个" withFont:12 withColor:UIColor.redColor];
    self.solveMoneyNumberLabel.attributedText = [[NSString stringWithFormat:@"%@亿", model.loanAmountCount] stringTurnAttributeString:@"亿" withFont:12 withColor:UIColor.redColor];
    
}

@end

//
//  JDHomePageProductDetailsProductContactPersonTableViewCell.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsProductContactPersonTableViewCell.h"
#import "JDHomePageProductDetailsProductIntroductionContactModel.h"

@interface JDHomePageProductDetailsProductContactPersonTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIView *VerBarView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end

@implementation JDHomePageProductDetailsProductContactPersonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.VerBarView.backgroundColor = UIColor.zt_backgroundView;
    self.bottomView.backgroundColor = UIColor.zt_backgroundView;
    
    self.phoneLabel.textColor = UIColor.zt_fontColor666;
    self.nameLabel.textColor = UIColor.zt_fontColor666;
}

- (void)setModel:(JDHomePageProductDetailsProductIntroductionContactModel *)model{
    _model = model;
    
    self.nameLabel.text = model.product_contact;
    self.phoneLabel.text = model.product_contact_phone;
}
@end

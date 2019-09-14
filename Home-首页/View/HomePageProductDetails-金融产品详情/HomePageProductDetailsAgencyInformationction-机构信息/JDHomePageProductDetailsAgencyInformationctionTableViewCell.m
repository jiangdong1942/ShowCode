//
//  JDHomePageProductDetailsAgencyInformationctionTableViewCell.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsAgencyInformationctionTableViewCell.h"
#import "JDHomePageProductDetailsAgencyInformationctionModel.h"

@interface JDHomePageProductDetailsAgencyInformationctionTableViewCell ()
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation JDHomePageProductDetailsAgencyInformationctionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nameLabel.textColor = UIColor.zt_fontColor666;
    self.contentLabel.textColor = UIColor.zt_fontGray;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setModel:(JDHomePageProductDetailsAgencyInformationctionModel *)model{
    _model = model;
    
    self.contentLabel.text = model.content;
    self.nameLabel.text = model.name;
}

@end

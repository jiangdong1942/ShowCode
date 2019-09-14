//
//  JDHomePageProductDetailsTextDetailTableViewCell.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsTextDetailTableViewCell.h"
#import "JDHomePageProductDetailsProductIntroductionTextModel.h"

@interface JDHomePageProductDetailsTextDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end
@implementation JDHomePageProductDetailsTextDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization codes
    self.lineView.backgroundColor = UIColor.zt_backgroundView;
    self.bottomView.backgroundColor = UIColor.zt_backgroundView;
    
    self.titleLabel.textColor = UIColor.zt_fontGray;
    self.contentLabel.textColor = UIColor.zt_fontColor666;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(JDHomePageProductDetailsProductIntroductionTextModel *)model{
    _model = model;
    
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
}

@end

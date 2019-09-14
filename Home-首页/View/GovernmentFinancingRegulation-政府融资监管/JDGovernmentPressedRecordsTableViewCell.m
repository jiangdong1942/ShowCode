//
//  JDGovernmentPressedRecordsTableViewCell.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDGovernmentPressedRecordsTableViewCell.h"
#import "JDGovernmentPressedRecordsModel.h"

@interface JDGovernmentPressedRecordsTableViewCell ()
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
/** 描述 */
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
/** 分隔线 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation JDGovernmentPressedRecordsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.textColor = UIColor.zt_fontGray;
    self.timerLabel.textColor = UIColor.zt_fontGray999;
    self.detailLabel.textColor = UIColor.zt_fontGray999;
    
    self.bottomView.backgroundColor = UIColor.zt_bottomViewColore1e1e1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(JDGovernmentPressedRecordsModel *)model{
    _model = model;
    
    self.titleLabel.text = model.government_name;
    self.timerLabel.text = model.press_time;
    self.detailLabel.text = model.press_content;
}

- (void)setIsShowLine:(BOOL)isShowLine{
    _isShowLine = isShowLine;
    
    self.bottomView.hidden = isShowLine;
}

@end

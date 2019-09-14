//
//  JDHomePageProductDetailsProductIntroductionApplicationProcessTableViewCell.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsProductIntroductionApplicationProcessTableViewCell.h"
@interface JDHomePageProductDetailsProductIntroductionApplicationProcessTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end
@implementation JDHomePageProductDetailsProductIntroductionApplicationProcessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lineView.backgroundColor = UIColor.zt_backgroundView;
    self.bottomView.backgroundColor = UIColor.zt_backgroundView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  HeadLinesCollectionViewCell.m
//  moumouRedPackage
//
//  Created by Moumou on 17/6/7.
//  Copyright © 2017年 陈洋的MBP. All rights reserved.
//

#import "HeadLinesCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HeadLinesCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *connetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation HeadLinesCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
}

- (void)setImageString:(NSString *)imageString{
    _imageString = imageString;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:imageString]];
}

//- (void)setIsRightAngle:(BOOL)isRightAngle{
//    _isRightAngle = isRightAngle;
//    if (isRightAngle) {
//        self.headImageView.layer.masksToBounds = YES;
//        self.headImageView.layer.cornerRadius = .0f;
//    }else{
//        self.headImageView.layer.masksToBounds = YES;
//        self.headImageView.layer.cornerRadius = 5.0f;
//    }
//    
//}

@end

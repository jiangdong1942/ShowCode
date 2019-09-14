//
//  HeadLinesCollectionViewCell.h
//  moumouRedPackage
//
//  Created by Moumou on 17/6/7.
//  Copyright © 2017年 陈洋的MBP. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JDHomePageShufflingFigureModel.h"

@interface HeadLinesCollectionViewCell : UICollectionViewCell

/**  数据模型 */
@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, strong) NSString *imageString;

///** 是不是直角 */
//@property(nonatomic, assign)BOOL isRightAngle;
@end

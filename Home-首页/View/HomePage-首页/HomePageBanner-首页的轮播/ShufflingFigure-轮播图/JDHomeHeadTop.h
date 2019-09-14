//
//  JDHomeHeadTop.h
//  SmartEasyBuyCarDemo
//
//  Created by Moumou on 17/7/1.
//  Copyright © 2017年 陈洋的MBP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadLinesCollectionViewCellDelegate <NSObject>

//轮播图的点击回调
- (void)HeadLinesCollectionViewClick:(NSString *)webString;

@end

@interface JDHomeHeadTop : UIView
/** 有定时器的初始化 */
- (id)initWithBaranerView:(CGRect )rect;
/** 没有定时器的初始化 */
- (id)initWithNoTimerBaranerView:(CGRect)rect;
/** 是不是直角 */
@property(nonatomic, assign)BOOL isRightAngle;

/**  轮播图的数据源 */
@property (nonatomic, strong) NSArray * dataArray;

/**  分类进入的轮播图的数据源 */
@property (nonatomic, strong) NSArray * classifficationDataArray;

/**  轮播图代理 */
@property (nonatomic, weak) id<HeadLinesCollectionViewCellDelegate> delegate;

@end

//
//  JDHomePageProductDetailsAgencyRatingsHeaderView.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDHomePageProductDetailsAgencyRatingsModel;
NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageProductDetailsAgencyRatingsHeaderView : UIView

/** 服务综合能力评价 */
@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, strong)JDHomePageProductDetailsAgencyRatingsModel *model;

@end

NS_ASSUME_NONNULL_END

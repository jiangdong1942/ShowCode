//
//  JDHomePageFinancialProductsTableViewCell.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDBaseTableViewCell.h"
@class JDHomePageFinancialProductsModel;
NS_ASSUME_NONNULL_BEGIN

typedef void(^applyFunding)(JDHomePageFinancialProductsModel * selectModel);

@interface JDHomePageFinancialProductsTableViewCell : JDBaseTableViewCell

@property(nonatomic, strong)JDHomePageFinancialProductsModel *model;
/** 是否显示下面的分割线 */
@property(nonatomic, assign)BOOL isShowBottom;

@property(nonatomic, copy)applyFunding applyFundingSelectModel;

@property(nonatomic, copy) NSString *cellType;
/** 是否显示申请融资按钮 */
@property(nonatomic, assign)BOOL isHideButton;



@end

NS_ASSUME_NONNULL_END

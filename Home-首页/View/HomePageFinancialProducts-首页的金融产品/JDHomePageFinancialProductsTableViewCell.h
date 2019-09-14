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

@interface JDHomePageFinancialProductsTableViewCell : JDBaseTableViewCell

@property(nonatomic, strong)JDHomePageFinancialProductsModel *model;

@property(nonatomic, assign)BOOL isShowBottom;

@end

NS_ASSUME_NONNULL_END

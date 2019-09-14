//
//  JDHomePageFinancialPolicyTableViewCell.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDBaseTableViewCell.h"
@class JDHomePageFinancialPolicyModel;
NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageFinancialPolicyTableViewCell : JDBaseTableViewCell

@property(nonatomic, strong)JDHomePageFinancialPolicyModel *model;

@property(nonatomic, assign)BOOL isShowBottom;

@end

NS_ASSUME_NONNULL_END

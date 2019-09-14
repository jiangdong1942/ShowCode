//
//  JDHomePageComprehensiveModel.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageComprehensiveModel : NSObject
/** 已认证企业数量 */
@property(nonatomic, strong)NSString *authenticationCompanyCount;
/** 金融产品 */
@property(nonatomic, strong)NSString *auditApprovalProductCount;
/** 解决资金 */
@property(nonatomic, strong)NSString *loanAmountCount;
/** 融资需求 */
@property(nonatomic, strong)NSString *adoptCompanyProjectCount;

@end

NS_ASSUME_NONNULL_END

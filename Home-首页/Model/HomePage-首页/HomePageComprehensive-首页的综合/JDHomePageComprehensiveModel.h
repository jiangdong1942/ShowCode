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
/** 企业用户拥有的项目总数(不区分状态) */
@property(nonatomic, strong)NSString *haveProjectCount2;
/** 企业用户拥有的项目总数 */
@property(nonatomic, strong)NSString *haveProjectCount;
/** 企业用户拥有的项目总数(审批通过的项目总数) */
@property(nonatomic, strong)NSString *timeoutReminderCount;
/** 机构我的催办次数 */
@property(nonatomic, strong)NSString *pressCount;
/** 金融政策数量 */
@property(nonatomic, strong)NSString *policyCount;
/** 政府项目审核数量 */
@property(nonatomic, strong)NSString *projectReviewCount;

@end

NS_ASSUME_NONNULL_END

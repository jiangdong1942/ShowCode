//
//  JDHomePageProductDetailsAgencyInformationctionViewController+Network.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsAgencyInformationctionViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageProductDetailsAgencyInformationctionViewController (Network)
/**  企业号登录获取机构信息 */
- (void)agencyInformationctionNetwork;

/**  机构号登录获取企业信息 */
- (void)getCompanyInfoByIdNetwork;

/** 企业对机构进行评价 */
- (void)enterprisesEvaluateInstitutionsParameter:(NSDictionary *)param;
@end

NS_ASSUME_NONNULL_END

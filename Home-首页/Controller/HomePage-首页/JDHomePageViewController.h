//
//  JDHomePageViewController.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDTableViewBaseViewController.h"
@class JDHomePageComprehensiveModel;
NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageViewController : JDTableViewBaseViewController
- (void)homeNetworkRequestCallbackBannerArray:(NSArray *)bannerArray
                    andComprehensiveDataModel:(JDHomePageComprehensiveModel *)comprehensiveDataModel
                    andFinancialProductsArray:(NSArray *)financialProductsArray
                      andFinancialPolicyArray:(NSArray *)financialPolicyArray;
@end

NS_ASSUME_NONNULL_END

//
//  JDHomePageProductDetailsViewController+Network.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageProductDetailsViewController (Network)

/** 企业用户收藏产品 */
- (void)collectionFinancialProductsEnterprises:(NSMutableDictionary *)param;

@end

NS_ASSUME_NONNULL_END

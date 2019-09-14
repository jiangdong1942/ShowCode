//
//  JDHomePageProductDetailsAgencyProductViewController.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDTableViewBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageProductDetailsAgencyProductViewController : JDTableViewBaseViewController
/** 金融产品的ID */
@property(nonatomic, strong)NSString *productId;

/** 机构id */
@property(nonatomic, strong)NSString *orgId;
/** 这是从父控制传入，如果是yes就隐藏掉 */
@property(nonatomic, assign)BOOL isHideButton;

#pragma mark - 网络请求的回调
- (void)callbacksNetworkRequests:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END

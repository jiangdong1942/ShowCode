//
//  JDHomePageProductDetailsAgencyRatingsViewController.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDTableViewBaseViewController.h"
@class JDHomePageProductDetailsAgencyRatingsModel;
NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageProductDetailsAgencyRatingsViewController : JDTableViewBaseViewController
/** 金融产品的ID */
@property(nonatomic, strong)NSString *ID;

- (void)callbacksNetworkRequests:(JDHomePageProductDetailsAgencyRatingsModel *)showModel;
@end

NS_ASSUME_NONNULL_END

//
//  JDHomePageSearchListViewController.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDTableViewBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageSearchListViewController : JDTableViewBaseViewController


/** 搜索网络请求的回调 */
- (void)homePageSearchListNetworData:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END

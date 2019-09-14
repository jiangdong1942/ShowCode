//
//  JDHomePageFinancialPolicyListViewController.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDTableViewBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageFinancialPolicyListViewController : JDTableViewBaseViewController

@property(nonatomic, strong)NSString *titleString;

/** 接口返回数据 */
- (void)interfaceRequestReturnData:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END

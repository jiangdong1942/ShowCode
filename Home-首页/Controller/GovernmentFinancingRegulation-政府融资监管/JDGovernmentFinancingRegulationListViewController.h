//
//  JDGovernmentFinancingRegulationListViewController.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDTableViewBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDGovernmentFinancingRegulationListViewController : JDTableViewBaseViewController

@property(nonatomic, strong)NSString *type;

/** 政府融资监管列表 */
- (void)govFinancingSupervisionListNetworkSuccess:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END

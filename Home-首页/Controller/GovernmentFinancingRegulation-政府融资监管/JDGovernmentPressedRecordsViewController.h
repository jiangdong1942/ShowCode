//
//  JDGovernmentPressedRecordsViewController.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDTableViewBaseViewController.h"
@class JDEnterpriseServiceaListModel;
NS_ASSUME_NONNULL_BEGIN

@interface JDGovernmentPressedRecordsViewController : JDTableViewBaseViewController

@property(nonatomic, strong)JDEnterpriseServiceaListModel *model;

/** 政府催办列表 */
- (void)allPressMessageListNetworkSuccess:(NSArray *)array;

@property (nonatomic,strong) NSString *typeString;

@end

NS_ASSUME_NONNULL_END

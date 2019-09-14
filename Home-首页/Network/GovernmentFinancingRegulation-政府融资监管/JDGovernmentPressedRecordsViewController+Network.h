//
//  JDGovernmentPressedRecordsViewController+Network.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDGovernmentPressedRecordsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDGovernmentPressedRecordsViewController (Network)
/** 政府催办列表 */
- (void)allPressMessageListNetwork;


/**
 催办次数详情列表
 */
- (void)listofCuiBanCount;

@end

NS_ASSUME_NONNULL_END

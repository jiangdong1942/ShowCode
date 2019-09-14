//
//  JDHomePageProductDetailsAgencyRatingsModel.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageProductDetailsAgencyRatingsModel : NSObject

/** 逾期还款次数 */
@property(nonatomic, strong)NSString *latePaymentCount;
/** 评价列表 */
@property(nonatomic, strong)NSArray *list;
/** 平均分 */
@property(nonatomic, strong)NSString *score;
/** 评价列表总数 */
@property(nonatomic, strong)NSString *total;

@end

NS_ASSUME_NONNULL_END

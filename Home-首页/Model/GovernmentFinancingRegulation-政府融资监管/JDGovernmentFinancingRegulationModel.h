//
//  JDGovernmentFinancingRegulationModel.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDScreeningItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDGovernmentFinancingRegulationModel : NSObject

+ (instancetype)sharedSingleton;

@property(nonatomic, strong)JDScreeningItemModel *selectModel;
/** 搜索内容 */
@property(nonatomic, strong)NSString *searchContent;

@end

NS_ASSUME_NONNULL_END

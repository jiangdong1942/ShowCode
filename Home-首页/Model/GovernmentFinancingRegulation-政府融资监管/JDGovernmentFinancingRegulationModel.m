//
//  JDGovernmentFinancingRegulationModel.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDGovernmentFinancingRegulationModel.h"

@implementation JDGovernmentFinancingRegulationModel

+ (instancetype)sharedSingleton {
    static JDGovernmentFinancingRegulationModel *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [JDGovernmentFinancingRegulationModel new];
    });
    return shareInstance;
}

@end

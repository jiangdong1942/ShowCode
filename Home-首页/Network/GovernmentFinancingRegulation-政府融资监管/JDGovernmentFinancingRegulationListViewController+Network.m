//
//  JDGovernmentFinancingRegulationListViewController+Network.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDGovernmentFinancingRegulationListViewController+Network.h"
#import "JDNetworkManager+JDNetworkInterface.h"
#import "JDEnterpriseServiceaListModel.h"
#import "JDGovernmentFinancingRegulationModel.h"
#import "JDHomePageFinancialProductsModel.h"

@implementation JDGovernmentFinancingRegulationListViewController (Network)
/** 政府融资监管列表 */
- (void)govFinancingSupervisionListNetwork{
    NSMutableDictionary *param = @{
                                   @"pageIndex":[NSString stringWithFormat:@"%ld", self.pageNumber],
                                   @"pageSize":@"10",
                                   }.mutableCopy;
    
    if ([DataCheck isValidString:self.type]) {
        [param setObject:self.type
                  forKey:@"status"];
    }
    
    if ([DataCheck isValidString:[JDGovernmentFinancingRegulationModel sharedSingleton].selectModel.ID]) {
        [param setObject:[JDGovernmentFinancingRegulationModel sharedSingleton].selectModel.ID forKey:@"product_type"];
    }
    
    if ([DataCheck isValidString:[JDGovernmentFinancingRegulationModel sharedSingleton].searchContent]) {
        [param setObject:[JDGovernmentFinancingRegulationModel sharedSingleton].searchContent forKey:@"project_name"];
    }
    
    [fb_NetworkManager zt_getGovFinancingSupervisionListNetwork:param
                                              completionHandler:^(JDNetWorkResult * _Nullable result) {
                                                  DLog(@"融资监管%@",result.responseInfo);
                                                  [self jd_endFresh:result];
                                                  if (result.isSuccess) {
                                                      [self govFinancingSupervisionListNetworkSuccess:[JDEnterpriseServiceaListModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]]];
                                                  }else{
                                                      [self zt_networkRequestFailed:result];
                                                  }
                                              }];
}

@end

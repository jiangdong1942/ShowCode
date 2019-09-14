//
//  JDHomePageFinancialPolicyListViewController+Network.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageFinancialPolicyListViewController+Network.h"
#import "JDNetworkManager+JDNetworkInterface.h"

@implementation JDHomePageFinancialPolicyListViewController (Network)

- (void)JDHomePageFinancialPolicyListNetwork{
    NSMutableDictionary *param = @{
                                   @"pageIndex":[NSString stringWithFormat:@"%ld", (long)self.pageNumber],
                                   @"pageSize":@"10"
                                   }.mutableCopy;
    
    if ([DataCheck isValidString:self.titleString]) {
        [param setObject:self.titleString forKey:@"title"];
    }
    
    [fb_NetworkManager zt_getPolicyListNetwork:param
                             completionHandler:^(JDNetWorkResult * _Nullable result) {
                                 
                                 [self jd_endFresh:result];
                                 if (result.isSuccess) {
                                     [self interfaceRequestReturnData:result.data[@"policyList"]];
                                 }else{
                                     [self zt_networkRequestFailed:result];
                                 }
                             }];
}

@end

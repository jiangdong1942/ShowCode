//
//  JDHomePageProductDetailsAgencyRatingsViewController+Network.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsAgencyRatingsViewController+Network.h"
#import "JDNetworkManager+JDNetworkInterface.h"
#import "JDHomePageProductDetailsAgencyRatingsModel.h"

@implementation JDHomePageProductDetailsAgencyRatingsViewController (Network)

- (void)agencyRatingsRequest{
    [fb_NetworkManager zt_agencyRatingsNetwork:@{
                                                 @"pageIndex":[NSString stringWithFormat:@"%ld", self.pageNumber],
                                                 @"pageSize":@"10",
                                                 @"byEvaluation":self.ID,//被评价者id(机构/企业id)
                                                 @"type":@"1"//    评价类型(1=企业评价机构，2=机构评价企业)
                                                 }
                             completionHandler:^(JDNetWorkResult * _Nullable result) {
                                 DLog(@"%@", result);
                                 
                                 if (result.isSuccess) {
                                     JDHomePageProductDetailsAgencyRatingsModel *model = [JDHomePageProductDetailsAgencyRatingsModel mj_objectWithKeyValues:result.data];
                                     
                                     [self callbacksNetworkRequests:model];
                                 }else{
                                     [self zt_networkRequestFailed:result];
                                 }
                             }];
}

@end

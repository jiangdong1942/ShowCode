//
//  JDHomePageProductDetailsAgencyProductViewController+Network.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsAgencyProductViewController+Network.h"
#import "JDNetworkManager+JDNetworkInterface.h"
#import "JDHomePageFinancialProductsModel.h"

@implementation JDHomePageProductDetailsAgencyProductViewController (Network)

- (void)agencyProductList{
    [fb_NetworkManager zt_agencyProductListNetwork:@{
                                                     @"productId":self.productId,//    产品id
                                                     @"orgId":self.orgId, //    机构id
                                                     }
                                 completionHandler:^(JDNetWorkResult * _Nullable result) {
                                     DLog(@"机构产品列表%@",result.responseInfo);
                                     if(result.isSuccess){
                                         [self callbacksNetworkRequests:[JDHomePageFinancialProductsModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]]];
                                     }else{
                                         [self zt_networkRequestFailed:result];
                                     }
                                 }];
}

@end

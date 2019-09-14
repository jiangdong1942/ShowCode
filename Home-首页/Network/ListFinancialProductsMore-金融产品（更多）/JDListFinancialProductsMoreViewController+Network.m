//
//  JDListFinancialProductsMoreViewController+Network.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDListFinancialProductsMoreViewController+Network.h"
#import "JDNetworkManager+JDNetworkInterface.h"
#import "JDHomePageFinancialProductsModel.h"


@implementation JDListFinancialProductsMoreViewController (Network)

- (void)ListFinancialProductsMoreNetwork{
    
    NSMutableDictionary *param = @{
                                   @"pageIndex":[NSString stringWithFormat:@"%ld", self.pageNumber],
                                   @"pageSize":@"10"
                                   }.mutableCopy;
    
    if ([DataCheck isValidString:self.projectId]) {
        [param setObject:self.projectId
                  forKey:@"projectId"];
    }
    
    if ([DataCheck isValidString:self.product_type]) {
        [param setObject:self.product_type
                  forKey:@"product_type"];
    }
    
    if ([DataCheck isValidString:self.proName]) {
        [param setObject:self.proName
                  forKey:@"proName"];
    }
    
    [fb_NetworkManager zt_orgProductListNetwork:param
                              completionHandler:^(JDNetWorkResult * _Nullable result) {
                                  DLog(@"金融产品列表（更多金融产品） -- %@", result.data);
                                  
                                  [self jd_endFresh:result];

                                  if (result.isSuccess) {
                                      
                                      [self interfaceRequestReturnData:[JDHomePageFinancialProductsModel mj_objectArrayWithKeyValuesArray:result.data[@"pruductList"]]];
                                  }else{
                                      [self zt_networkRequestFailed:result];
                                  }
                              }];
}

@end

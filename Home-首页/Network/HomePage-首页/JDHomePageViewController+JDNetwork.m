//
//  JDHomePageViewController+JDNetwork.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageViewController+JDNetwork.h"
#import "JDNetworkManager+JDNetworkInterface.h"
#import "JDHomePageBannerModel.h"
#import "JDHomePageComprehensiveModel.h"
#import "JDHomePageFinancialProductsModel.h"
#import "JDHomePageFinancialPolicyModel.h"

@implementation JDHomePageViewController (JDNetwork)

- (void)jd_homePageNetwork:(NSDictionary *)parame{
    [fb_NetworkManager zt_homePageNetwork:parame
                        completionHandler:^(JDNetWorkResult * _Nullable result) {
                            
                            if (result.isSuccess) {

//                                轮播图的数据
                                NSArray *bannerArray = [JDHomePageBannerModel mj_objectArrayWithKeyValuesArray:result.data[@"bannerList"]];
//                                综合的数据
                                
                                JDHomePageComprehensiveModel *comprehensiveDataModel = [JDHomePageComprehensiveModel mj_objectWithKeyValues:result.data];

//                                金融产品的数据
                                NSArray *financialProductsArray = [JDHomePageFinancialProductsModel mj_objectArrayWithKeyValuesArray:result.data[@"pruductList"]];
                                
//                                金融政策数据
                                NSArray *financialPolicyArray = [JDHomePageFinancialPolicyModel mj_objectArrayWithKeyValuesArray:result.data[@"policyList"]];
                                
                                [self homeNetworkRequestCallbackBannerArray:bannerArray
                                                  andComprehensiveDataModel:comprehensiveDataModel
                                                  andFinancialProductsArray:financialProductsArray
                                                    andFinancialPolicyArray:financialPolicyArray];
                            }else{
                                [self zt_networkRequestFailed:result];
                            }
            
                            
                        }];
    
    if ([UserModel sharedSingleton].app_token) {
        DLog(@"token %@",[UserModel sharedSingleton].app_token);
        [self getUserLoginInfo:@{}];
    }
    
}

- (void)getUserLoginInfo:(NSDictionary *)param{
    [fb_NetworkManager zd_userGetUserLoginInfo:param completionHandler:^(JDNetWorkResult * _Nullable result) {
        DLog(@"获取信息%@",result.responseInfo);
        if (result.isSuccess) {
           [UserModel mj_objectWithKeyValues:result.data];
        }else{
            [self zt_networkRequestFailed:result];
            
        }
    }];
}

@end

//
//  JDHomePageProductDetailsAgencyInformationctionViewController+Network.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsAgencyInformationctionViewController+Network.h"
#import "JDNetworkManager+JDNetworkInterface.h"
#import "JDHomePageProductDetailsAgencyInformationctionModel.h"
#import "JDNetworkManager+ZFDNetworkInterface.h"

@implementation JDHomePageProductDetailsAgencyInformationctionViewController (Network)
/**  企业号登录获取机构信息 */
- (void)agencyInformationctionNetwork{
    if ([DataCheck isValidString:self.ID]) {
        [fb_NetworkManager zt_agencyInformationctionNetwork:@{@"id":self.ID}
                                          completionHandler:^(JDNetWorkResult * _Nullable result) {
                                              DLog(@"机构信息%@",result.responseInfo);
                                              if (result.isSuccess) {
                                                  NSArray *array = @[
                                                                     @{
                                                                         @"name":@"机构名称:",
                                                                         @"content":@"",
                                                                         @"backgroundFiled":@"organization_name"
                                                                         }.mutableCopy,
                                                                     @{
                                                                         @"name":@"机构介绍:",
                                                                         @"content":@"",
                                                                         @"backgroundFiled":@"organization_introduce"
                                                                         }.mutableCopy,
                                                                     @{
                                                                         @"name":@"机构地址:",
                                                                         @"content":@"",
                                                                         @"backgroundFiled":@"organization_address"
                                                                         }.mutableCopy,
//                                                                     @{
//                                                                         @"name":@"融资偏好:",
//                                                                         @"content":@"",
//                                                                         @"backgroundFiled":@"financing_preference_name"
//                                                                         }.mutableCopy,
                                                                     @{
                                                                         @"name":@"联系人:",
                                                                         @"content":@"",
                                                                         @"backgroundFiled":@"organization_contacts"
                                                                         }.mutableCopy,
                                                                     @{
                                                                         @"name":@"联系电话:",
                                                                         @"content":@"",
                                                                         @"backgroundFiled":@"organization_contacts_telephone"
                                                                         }.mutableCopy
                                                                     ];
                                                  
                                                  for (NSInteger i = 0; i < array.count; i++) {
                                                      NSMutableDictionary *dic = array[i];
                                                      
                                                      if ([dic[@"backgroundFiled"] isEqualToString:@"organization_address"]) {
                                                          NSString *address = [NSString stringWithFormat:@"%@%@%@%@", result.data[@"gov_province_name"], result.data[@"gov_city_name"], result.data[@"district_name"], result.data[@"organization_address"]];
                                                          [dic setObject:address forKey:@"content"];
                                                      }else{
                                                          [dic setObject:result.data[dic[@"backgroundFiled"]] forKey:@"content"];
                                                      }
                                                      
                                                      
                                                      
                                                  }
                                                  
                                                  NSArray *dataArray = [JDHomePageProductDetailsAgencyInformationctionModel mj_objectArrayWithKeyValuesArray:array];
                                                  
                                                  [self callbacksNetworkRequests:dataArray];
                                                  DLog(@"%@", dataArray);
                                              }else{
                                                  [self zt_networkRequestFailed:result];
                                              }
                                              
                                              
                                          }];
    }
    
}

/**  机构号登录获取企业信息 */
- (void)getCompanyInfoByIdNetwork{
    if ([DataCheck isValidString:self.ID]) {
        [fb_NetworkManager zd_getCompanyInfoById:@{@"companyId":self.ID}
                              completionHandler:^(JDNetWorkResult * _Nullable result) {
                                  DLog(@"企业信息%@",result.responseInfo);
                                  if (result.isSuccess) {
                                      NSArray *array = @[
                                                         @{
                                                             @"name":@"企业名称:",
                                                             @"content":@"",
                                                             @"backgroundFiled":@"company_name"
                                                             }.mutableCopy,
                                                         @{
                                                             @"name":@"所属行业:",
                                                             @"content":@"",
                                                             @"backgroundFiled":@"company_industry_name"
                                                             }.mutableCopy,
                                                         @{
                                                             @"name":@"信用代码:",
                                                             @"content":@"",
                                                             @"backgroundFiled":@"company_code"
                                                             }.mutableCopy,
                                                         @{
                                                             @"name":@"企业法人:",
                                                             @"content":@"",
                                                             @"backgroundFiled":@"company_legal_person_name"
                                                             }.mutableCopy,
                                                         @{
                                                             @"name":@"企业地址:",
                                                             @"content":@"",
                                                             @"backgroundFiled":@"company_address"
                                                             }.mutableCopy,
//                                                         @{
//                                                             @"name":@"联系电话:",
//                                                             @"content":@"",
//                                                             @"backgroundFiled":@"organization_contacts_telephone"
//                                                             }.mutableCopy
                                                         ];
                                      
                                      for (NSInteger i = 0; i < array.count; i++) {
                                          NSMutableDictionary *dic = array[i];
                                          
                                          [dic setObject:result.data[dic[@"backgroundFiled"]] forKey:@"content"];
                                          
                                      }
                                      
                                      NSArray *dataArray = [JDHomePageProductDetailsAgencyInformationctionModel mj_objectArrayWithKeyValuesArray:array];
                                      
                                      [self callbacksNetworkRequests:dataArray];
                                      DLog(@"%@", dataArray);
                                  }else{
                                      [self zt_networkRequestFailed:result];
                                  }
                                  
                                  
                              }];
    }
    
}

/** 企业对机构进行评价 */
- (void)enterprisesEvaluateInstitutionsParameter:(NSDictionary *)param{
//    zt_evaluateNetwork
    [fb_NetworkManager zt_evaluateNetwork:param
                        completionHandler:^(JDNetWorkResult * _Nullable result) {
                            if (result.isSuccess) {
                                [self evaluationComplete];
                            }else{
                                [self zt_networkRequestFailed:result];
                            }
                        }];
    
}

@end

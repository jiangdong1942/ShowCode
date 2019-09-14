//
//  JDHomePageProductDetailsProductIntroductionViewController+Network.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsProductIntroductionViewController+Network.h"
#import "JDNetworkManager+JDNetworkInterface.h"
#import "JDHomePageProductDetailsProductIntroductionModel.h"
#import "JDHomePageProductDetailsProductIntroductionTextModel.h"
#import "JDHomePageProductDetailsProductIntroductionContactModel.h"

@implementation JDHomePageProductDetailsProductIntroductionViewController (Network)

- (void)productIntroductionNetwork{
    [fb_NetworkManager zt_productIntroductionNetwork:@{@"id":self.ID}
                                   completionHandler:^(JDNetWorkResult * _Nullable result) {
                                       DLog(@"%@", result);
                                       if (result.isSuccess) {
                                           
                                           NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:7];
                                           
                                           JDHomePageProductDetailsProductIntroductionModel *productIntroductionModel = [JDHomePageProductDetailsProductIntroductionModel mj_objectWithKeyValues:result.data];
                                           
                                           [resultArray addObject:productIntroductionModel];
                                           [resultArray addObject:@""];
                                           
                                           NSArray *array = @[
                                                              @{
                                                                  @"title":@"产品简介",
                                                                  @"content":@"",
                                                                  @"backgroundField":@"product_introduce"
                                                                  }.mutableCopy,
                                                              @{
                                                                  @"title":@"产品特点",
                                                                  @"content":@"",
                                                                  @"backgroundField":@"product_trait"
                                                                  }.mutableCopy,
                                                              @{
                                                                  @"title":@"所需材料",
                                                                  @"content":@"",
                                                                  @"backgroundField":@"required_materials"
                                                                  }.mutableCopy,
                                                              @{
                                                                  @"title":@"申请条件",
                                                                  @"content":@"",
                                                                  @"backgroundField":@"application_condition"
                                                                  }.mutableCopy
                                                              ];
                                           
                                           for (NSInteger i = 0; i < array.count; i++) {
                                               
                                               NSMutableDictionary *dic =  array[i];
                                               
                                               if ([DataCheck isValidString:result.data[dic[@"backgroundField"]]]) {
                                                   [dic setObject:result.data[dic[@"backgroundField"]] forKey:@"content"];
                                               }
                                               
                                               [resultArray addObject:[JDHomePageProductDetailsProductIntroductionTextModel mj_objectWithKeyValues:dic]];

                                           }
                                           
                                           
                                           [resultArray addObject:[JDHomePageProductDetailsProductIntroductionContactModel mj_objectWithKeyValues:result.data]];
                                           DLog(@"%@", resultArray);
                                           [self productIntroductionNetworkResult:resultArray];
                                       }else{
                                           [self zt_networkRequestFailed:result];
                                       }
                                   }];
}

@end

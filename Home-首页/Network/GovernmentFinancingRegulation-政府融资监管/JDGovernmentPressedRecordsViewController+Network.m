//
//  JDGovernmentPressedRecordsViewController+Network.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDGovernmentPressedRecordsViewController+Network.h"
#import "JDNetworkManager+JDNetworkInterface.h"
#import "JDEnterpriseServiceaListModel.h"
#import "JDGovernmentPressedRecordsModel.h"

@implementation JDGovernmentPressedRecordsViewController (Network)

/** 政府催办列表 */
- (void)allPressMessageListNetwork{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:4];
    
    [param setObject:[NSString stringWithFormat:@"%ld", self.pageNumber]
              forKey:@"pageIndex"];
    [param setObject:@"10"
              forKey:@"pageSize"];
    [param setObject:self.model.ID
              forKey:@"financing_project_id"];
    [param setObject:self.model.organization_id
              forKey:@"org_id"];
    [fb_NetworkManager zt_allPressMessageListNetwork:param
                                   completionHandler:^(JDNetWorkResult * _Nullable result) {
                                       
                                       [self jd_endFresh:result];
                                       
                                       if (result.isSuccess) {
                                           [self allPressMessageListNetworkSuccess:[JDGovernmentPressedRecordsModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]]];
                                       }else{
                                           [self zt_networkRequestFailed:result];
                                       }
                                   }];
}

/** 催办次数列表 */
- (void)listofCuiBanCount{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:3];
    
    [param setObject:[NSString stringWithFormat:@"%ld", self.pageNumber]
              forKey:@"pageIndex"];
    [param setObject:@"10"
              forKey:@"pageSize"];
    [param setObject:self.model.ID
              forKey:@"financing_project_id"];
    
    [fb_NetworkManager zt_governAndOrganizationCuiBanListNetwork:param completionHandler:^(JDNetWorkResult * _Nullable result) {
        DLog(@"催办次数列表%@",result.responseInfo);
        [self jd_endFresh:result];
        
        if (result.isSuccess) {
            [self allPressMessageListNetworkSuccess:[JDGovernmentPressedRecordsModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]]];
        }else{
            [self zt_networkRequestFailed:result];
        }
    }];
}

@end

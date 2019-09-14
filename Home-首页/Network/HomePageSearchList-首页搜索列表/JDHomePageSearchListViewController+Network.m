//
//  JDHomePageSearchListViewController+Network.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageSearchListViewController+Network.h"
#import "JDNetworkManager+JDNetworkInterface.h"

@implementation JDHomePageSearchListViewController (Network)
/** 搜索列表 */
- (void)homePageSearchListNetwork:(NSString *)searchContent{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    
    if ([DataCheck isValidString:searchContent]) {
        [param setObject:searchContent forKey:@"title"];
    }else{
        [param setObject:@"" forKey:@"title"];
    }
    
    
    [fb_NetworkManager zt_homeSearchDataListNetwork:param
                                  completionHandler:^(JDNetWorkResult * _Nullable result) {
                                      DLog(@"%@", result.data);
                                      
                                      if (result.isSuccess) {
                                          [self homePageSearchListNetworData:result.data];
                                      }else{
                                          [self zt_networkRequestFailed:result];
                                      }
                                  }];
}

@end

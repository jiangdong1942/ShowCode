//
//  JDHomePageProductDetailsViewController+Network.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsViewController+Network.h"
#import "JDNetworkManager+JDNetworkInterface.h"
#import "JDHomePageFinancialProductsModel.h"

@implementation JDHomePageProductDetailsViewController (Network)
/** 企业用户收藏产品 */
- (void)collectionFinancialProductsEnterprises:(NSMutableDictionary *)param{
    
    if ([DataCheck isValidString:self.productListModel.ID]) {
        [param setObject:self.productListModel.ID
                  forKey:@"business_id"];
    }
    
    [param setObject:@"1"
              forKey:@"collection_type"];
    [fb_NetworkManager zt_addCollectionNetwork:param
                             completionHandler:^(JDNetWorkResult * _Nullable result) {
                                 if (result.isSuccess) {
                                     if ([[NSString  stringWithFormat:@"%@", result.data[@"result"]] isEqualToString:@"1"]) {
                                         [self collectionFinancialProductsEnterprisesSuccess];
                                     }else{
                                         if (!self.topNavigationView.rightButton.selected) {
                                             [MBProgressHUD showMessage:@"收藏失败"];
                                         }else{
                                             [MBProgressHUD showMessage:@"取消收藏失败"];
                                         }
                                         
                                     }
                                 }else{
                                     [self zt_networkRequestFailed:result];
                                 }
                             }];
}

@end

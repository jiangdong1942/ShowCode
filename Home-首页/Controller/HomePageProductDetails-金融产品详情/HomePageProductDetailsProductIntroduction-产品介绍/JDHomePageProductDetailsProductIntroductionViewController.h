//
//  JDHomePageProductDetailsProductIntroductionViewController.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDTableViewBaseViewController.h"
@class JDHomePageFinancialProductsModel;
NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageProductDetailsProductIntroductionViewController : JDTableViewBaseViewController
/** 金融产品的ID */
@property(nonatomic, strong)NSString *ID;
/** 网络请求的数据回调 */
- (void)productIntroductionNetworkResult:(NSArray *)dataArray;

/** 机构产品列表进入 */
@property(nonatomic, strong)JDHomePageFinancialProductsModel *selectModel;

@end

NS_ASSUME_NONNULL_END

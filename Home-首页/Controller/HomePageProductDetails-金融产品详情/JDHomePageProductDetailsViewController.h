//
//  JDHomePageProductDetailsViewController.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDBaseSuperTableWithScrollViewController.h"
@class JDHomePageFinancialProductsModel;
@class ZDDemanCommitModel;
NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageProductDetailsViewController : JDBaseSuperTableWithScrollViewController

@property(nonatomic, strong)JDHomePageFinancialProductsModel *productListModel;

/** 创建需求的数量 */
@property(nonatomic, strong)ZDDemanCommitModel *projectModel;
/** 这个按钮是否隐藏按钮，如果不传值默认显示，传yes就是隐藏掉 */
@property(nonatomic, assign)BOOL isHideButton;
/** 收藏成功的回调 */
- (void)collectionFinancialProductsEnterprisesSuccess;

@end

NS_ASSUME_NONNULL_END

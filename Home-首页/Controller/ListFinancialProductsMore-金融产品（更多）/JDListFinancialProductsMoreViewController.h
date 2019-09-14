//
//  JDListFinancialProductsMoreViewController.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDTableViewBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDListFinancialProductsMoreViewController : JDTableViewBaseViewController
/** 金融产品列表（更多金融产品）网络请求数据 */
- (void)interfaceRequestReturnData:(NSArray *)array;

/** 企业项目id */
@property(nonatomic, strong)NSString *projectId;
/** 产品类型id */
@property(nonatomic, strong)NSString *product_type;
/** 搜索内容 */
@property(nonatomic, strong)NSString *proName;
///** 当前用户创建的项目 */
//@property(nonatomic, assign)NSInteger haveProjectCount;

@end

NS_ASSUME_NONNULL_END

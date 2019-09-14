//
//  JDHomePageFinancialProductsModel.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageFinancialProductsModel : NSObject

/** 参考利率至 */
@property(nonatomic, strong)NSString *reference_rate_end;
/** 贷款类型*/
@property(nonatomic, strong)NSString *loan_type_name;
@property(nonatomic, strong)NSString *loan_type;
/** 贷款期限起 */
@property(nonatomic, strong)NSString *loan_period_begin;
/** 机构名称 */
@property(nonatomic, strong)NSString *organization_name;
/** 参考利率起 */
@property(nonatomic, strong)NSString *reference_rate_begin;
/** 产品名称 */
@property(nonatomic, strong)NSString *product_name;
/** 贷款期限至 */
@property(nonatomic, strong)NSString *loan_period_end;
/** 是否被收藏 1：是 0/-1：否 */
@property(nonatomic, strong)NSString *iscollect;
/** 产品类型 */
@property(nonatomic, strong)NSString *product_type_name;

@property(nonatomic, strong)NSString *product_type;
/** 机构id */
@property(nonatomic, strong)NSString *org_id;
/** 是否被融资申请 1：是 0/-1 */
@property(nonatomic, strong)NSString *isfinancing;
/** 贷款额度起 */
@property(nonatomic, strong)NSString *loan_limit_begin;
/** 产品id */
@property(nonatomic, strong)NSString *ID;
/** 贷款额度至 */
@property(nonatomic, strong)NSString *loan_limit_end;
/** 机构头像 */
@property(nonatomic, strong)NSString *head_portrait;
///** 产品简介 */
//@property(nonatomic, strong)NSString *product_introduce;
///** 产品特点 */
//@property(nonatomic, strong)NSString *product_trait;
///** 申请条件 */
//@property(nonatomic, strong)NSString *application_condition;
///** 所需材料 */
//@property(nonatomic, strong)NSString *required_materials;
@end

NS_ASSUME_NONNULL_END

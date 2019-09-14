//
//  JDHomePageProductDetailsProductIntroductionModel.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageProductDetailsProductIntroductionModel : NSObject

/** 创建时间 */
@property(nonatomic, strong)NSString *createtime;
/** 参考利率至 */
@property(nonatomic, strong)NSString *reference_rate_end;
/** 申请条件 */
@property(nonatomic, strong)NSString *application_condition;
/** 贷款期限起 */
@property(nonatomic, strong)NSString *loan_period_begin;
/** 参考利率起 */
@property(nonatomic, strong)NSString *reference_rate_begin;
/** 贷款类型id */
@property(nonatomic, strong)NSString *loan_type;
/** 产品名称 */
@property(nonatomic, strong)NSString *product_name;
/** 贷款期限至 */
@property(nonatomic, strong)NSString *loan_period_end;
/** 是否被删除 0：否 */
@property(nonatomic, strong)NSString *is_delete;
/** 所需材料 */
@property(nonatomic, strong)NSString *required_materials;
/** 产品类型id */
@property(nonatomic, strong)NSString *product_type;
/** 产品介绍 */
@property(nonatomic, strong)NSString *product_introduce;
/** 产品特点 */
@property(nonatomic, strong)NSString *product_trait;
/** 产品联系人电话 */
@property(nonatomic, strong)NSString *product_contact_phone;
/** 机构id */
@property(nonatomic, strong)NSString *organization_id;
/** 贷款额度起 */
@property(nonatomic, strong)NSString *loan_limit_begin;
/** 产品id */
@property(nonatomic, strong)NSString *ID;
/** 贷款额度至 */
@property(nonatomic, strong)NSString *loan_limit_end;
/** 产品联系人 */
@property(nonatomic, strong)NSString *product_contact;
/** 产品状态 1：待审核 2：审核未通过 3：审核通过 4：草稿 */
@property(nonatomic, strong)NSString *status;
/** 贷款类型名称 */
@property(nonatomic, strong)NSString *loan_type_name;
/** 机构名称 */
@property(nonatomic, strong)NSString *organization_name;
/** 产品类型名称 */
@property(nonatomic, strong)NSString *product_type_name;
/** 文件访问前缀 */
@property(nonatomic, strong)NSString *filehttp;


@end

NS_ASSUME_NONNULL_END

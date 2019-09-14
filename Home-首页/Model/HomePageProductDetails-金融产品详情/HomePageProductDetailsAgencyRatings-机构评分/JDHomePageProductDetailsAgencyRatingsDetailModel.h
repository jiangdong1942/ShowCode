//
//  JDHomePageProductDetailsAgencyRatingsDetailModel.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageProductDetailsAgencyRatingsDetailModel : NSObject
/** 评价时间 */
@property(nonatomic, strong)NSString *create_time;
/** 评价者名称(企业/机构名称) */
@property(nonatomic, strong)NSString *creator;
/** 评价内容 */
@property(nonatomic, strong)NSString *jd_description;
/** 企业项目名称 */
@property(nonatomic, strong)NSString *project_name;
/** 评分 */
@property(nonatomic, strong)NSString *score;

@end

NS_ASSUME_NONNULL_END

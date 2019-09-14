//
//  JDHomePageFinancialPolicyModel.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageFinancialPolicyModel : NSObject
/** 列表展示的图片列表 */
@property(nonatomic, strong)NSArray *newsImage;
/** 发布时间 */
@property(nonatomic, strong)NSString *releasetime;
/** 跳转至详情页的地址 */
@property(nonatomic, strong)NSString *staticpageurl;
/** 后台冗余的字段，请忽视 */
@property(nonatomic, strong)NSString *rownumber;
/** 内容id */
@property(nonatomic, strong)NSString *ID;
/** 标题 */
@property(nonatomic, strong)NSString *title;
/** 来源 */
@property(nonatomic, strong)NSString *vicetitle;
@end

NS_ASSUME_NONNULL_END

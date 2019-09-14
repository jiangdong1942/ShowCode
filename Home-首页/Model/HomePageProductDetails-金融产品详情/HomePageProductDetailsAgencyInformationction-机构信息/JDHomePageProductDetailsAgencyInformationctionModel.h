//
//  JDHomePageProductDetailsAgencyInformationctionModel.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageProductDetailsAgencyInformationctionModel : NSObject
/** 标题 */
@property(nonatomic, strong)NSString *name;
/** 内容 */
@property(nonatomic, strong)NSString *content;
/** 对应的后台数据 */
@property(nonatomic, strong)NSString *backgroundFiled;

@end

NS_ASSUME_NONNULL_END

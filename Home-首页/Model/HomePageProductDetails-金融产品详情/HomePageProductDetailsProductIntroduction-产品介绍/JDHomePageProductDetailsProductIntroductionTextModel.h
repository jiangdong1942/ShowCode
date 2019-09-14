//
//  JDHomePageProductDetailsProductIntroductionTextModel.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageProductDetailsProductIntroductionTextModel : NSObject
/** 标题 */
@property(nonatomic, strong)NSString *title;
/** 内容 */
@property(nonatomic, strong)NSString *content;
/** 对应后台的字段 */
@property(nonatomic, strong)NSString *backgroundField;

@end

NS_ASSUME_NONNULL_END

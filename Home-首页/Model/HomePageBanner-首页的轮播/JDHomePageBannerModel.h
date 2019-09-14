//
//  JDHomePageBannerModel.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDHomePageBannerModel : NSObject
/** banner图片地址 */
@property(nonatomic, strong)NSString *titleimg;
/** banner跳转地址 */
@property(nonatomic, strong)NSString *staticpageurl;
/** id */
@property(nonatomic, strong)NSString *ID;
/** 标题 */
@property(nonatomic, strong)NSString *title;
@end

NS_ASSUME_NONNULL_END

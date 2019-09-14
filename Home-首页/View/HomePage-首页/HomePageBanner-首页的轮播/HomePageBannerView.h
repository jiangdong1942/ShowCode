//
//  HomePageBannerView.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageBannerView : UIView

@property(nonatomic, strong)NSMutableArray *iconArray;
/** 是否隐藏标签 */
@property(nonatomic, assign)BOOL isHide;

@end

NS_ASSUME_NONNULL_END

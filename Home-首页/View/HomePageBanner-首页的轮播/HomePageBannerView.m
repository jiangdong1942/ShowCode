//
//  HomePageBannerView.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HomePageBannerView.h"
#import "JDHomePageBannerItem.h"
#import "JDHomeHeadTop.h"
#import "JDHomePageBannerModel.h"
#import "UIView+JDCore.h"
@interface HomePageBannerView ()
/** 需求的item */
@property(nonatomic, strong)JDHomePageBannerItem *itemView;
/** 轮播图 */
@property(nonatomic, strong)JDHomeHeadTop *bannerView;

@end

@implementation HomePageBannerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
//        轮播图
        [self addSubview:self.bannerView];
        [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(kScaleW * 233);
        }];
        
//       按钮
        [self addSubview:self.itemView];
        [self.itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-15);
            make.height.mas_equalTo(190);
        }];

    }
    return self;
}

- (void)setIconArray:(NSMutableArray *)iconArray{
    _iconArray = iconArray;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:iconArray.count];
    
    for (NSInteger i = 0; i < iconArray.count; i++) {
        JDHomePageBannerModel *model = iconArray[i];
        
        [array addObject:model.titleimg];
    }
    
    self.bannerView.dataArray = array;
}

#pragma mark - 懒加载
- (JDHomePageBannerItem *)itemView{
    
    if (!_itemView) {
        _itemView = [[JDHomePageBannerItem alloc] init];
        
        [UIView JD_roundedCornersShaded:_itemView
                             andRounded:10.0f
                 andViewBackgroundColor:UIColor.whiteColor
                                andRect:CGRectMake(0, 0, KScreenWidth - 30, 190)
                         andShadowColor:UIColor.zt_shadowColor];
    }
    return _itemView;
}

- (JDHomeHeadTop *)bannerView{
    
    if (!_bannerView) {
        _bannerView = [[JDHomeHeadTop alloc] initWithBaranerView:CGRectMake(0, 0, KScreenWidth, kScaleW * 233)];
    }
    return _bannerView;
}

@end

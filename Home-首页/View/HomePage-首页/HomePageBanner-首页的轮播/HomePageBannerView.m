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

- (void)setIsHide:(BOOL)isHide{
    _isHide = isHide;
//    这里是反过来的，因为不传是NO，但是这里需要判断
    
    [self.itemView removeFromSuperview];
    _itemView = nil;
    
    if (isHide) {
        [self.itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-15);
            make.height.mas_equalTo(190);
        }];
        
        
    }
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
        
        //       按钮
        [self addSubview:_itemView];
        
        
        if ([[UserModel sharedSingleton].type isEqualToString:@"1"]) {
            //            企业
            _itemView.dataArray = @[
                                        @{
                                            @"icon":@"HomePageItemFirst",
                                            @"title":@"融资概览",
                                            @"detail":@"融资申请动态",
                                            @"nextController":@"1"
                                            },
                                        @{
                                            @"icon":@"HomePageItemSecond",
                                            @"title":@"我的需求",
                                            @"detail":@"我发布的需求",
                                            @"nextController":@"ZDMyselfDemandViewController"
                                            },
                                        @{
                                            @"icon":@"HomePageItemThree",
                                            @"title":@"金融超市",
                                            @"detail":@"各机构金融产品",
                                            @"nextController":@"JDListFinancialProductsMoreViewController"
                                            },
                                        @{
                                            @"icon":@"HomePageItemFour",
                                            @"title":@"我的收藏",
                                            @"detail":@"收藏的金融产品",
                                            @"nextController":@"ZDMyselfCollectionViewController"
                                            }
                                        ].mutableCopy;
        }else if([[UserModel sharedSingleton].type isEqualToString:@"2"]){
            //            机构
            _itemView.dataArray = @[
                                        @{
                                            @"icon":@"HomePageItemFirst",
                                            @"title":@"我的催办",
                                            @"detail":@"超时的融资需求",
                                            @"nextController":@"ZDMyCuiBanListViewController"
                                            },
                                        @{
                                            @"icon":@"HomePageItemSecond",
                                            @"title":@"我的待办",
                                            @"detail":@"待办的融资需求",
                                            @"nextController":@"1"
                                            },
                                        @{
                                            @"icon":@"HomePageItemThree",
                                            @"title":@"我的金融产品",
                                            @"detail":@"我发布的金融产品",
                                            @"nextController":@"ZDSuperFinanceProductVController"
                                            },
                                        @{
                                            @"icon":@"HomePageItemFour",
                                            @"title":@"需求中心",
                                            @"detail":@"企业的融资需求",
                                            @"nextController":@"ZDDemandForCenterViewController"
                                            }
                                        ].mutableCopy;
        }else if([[UserModel sharedSingleton].type isEqualToString:@"3"]){
            //            政府
            _itemView.dataArray = @[
                                        @{
                                            @"icon":@"HomePageItemFirst",
                                            @"title":@"融资统计",
                                            @"detail":@"可视化融资数据",
                                            @"nextController":@"1"
                                            },
                                        @{
                                            @"icon":@"HomePageItemSecond",
                                            @"title":@"融资监管",
                                            @"detail":@"总览融资新动态",
                                            @"nextController":@"JDGovernmentFinancingRegulationViewController"
                                            },
                                        @{
                                            @"icon":@"HomePageItemThree",
                                            @"title":@"金融超市",
                                            @"detail":@"各机构金融超市",
                                            @"nextController":@"JDListFinancialProductsMoreViewController"
                                            },
                                        @{
                                            @"icon":@"HomePageItemFour",
                                            @"title":@"需求中心",
                                            @"detail":@"企业的融资需求",
                                            @"nextController":@"ZDDemandForCenterViewController"
                                            }
                                        ].mutableCopy;
        }
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

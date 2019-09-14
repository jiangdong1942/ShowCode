//
//  JDHomePageBannerItem.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageBannerItem.h"

@interface JDHomePageBannerItem ()

@end

@implementation JDHomePageBannerItem

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self loadDataShowButton];
    
}
#pragma mark - 加载数据并显示
- (void)loadDataShowButton{
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
//        生成按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = 10000 + i;
        
        [button addTarget:self
                   action:@selector(buttonClick:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15 + i % 2 * ((KScreenWidth - 70)/2 + 10));
            make.top.mas_equalTo(25 + i/2 * 80);
            make.height.mas_equalTo(55);
            make.width.mas_equalTo((KScreenWidth - 70)/2);
        }];
//        数组里取出字典并加载到页面上显示
        NSDictionary *showDic = self.dataArray[i];
//        图片的视图
        UIImageView *icon = [[UIImageView alloc] init];
        
        icon.image = [UIImage imageNamed:showDic[@"icon"]];
        
        [button addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.mas_equalTo(0);
            make.height.mas_equalTo(54);
            make.width.mas_equalTo(60);
        }];
//        item标题
        UILabel *titleLabel = [UILabel new];
        
        titleLabel.text = showDic[@"title"];
        titleLabel.font = UIFont.zt_font15;
        titleLabel.textColor = UIColor.zt_fontGray;
        
        [button addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(icon.mas_right).mas_equalTo(5);
            make.top.mas_equalTo(5);
//            make.right.mas_equalTo(0);
        }];
//        item描述
        UILabel *detailLabel = [UILabel new];
        
        detailLabel.text = showDic[@"detail"];
        detailLabel.textColor = UIColor.zt_fontGray999;
        detailLabel.font = UIFont.zt_font12;
        
        [button addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_left);
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(8);
//            make.right.mas_equalTo(0);
        }];
    }
}


- (void)buttonClick:(UIButton *)button{
    
    NSNotification *notice = [NSNotification notificationWithName:JDHomePageHohhotHeaderClick
                                                           object:self.dataArray[button.tag - 10000]];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}
#pragma mark - 传入数据
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
}


@end

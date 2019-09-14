//
//  JDHomeTableView.m
//  UrbanCredit
//
//  Created by apple on 2019/6/5.
//  Copyright © 2019年 ZD. All rights reserved.
//

#import "JDHomeTableView.h"

@implementation JDHomeTableView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    [super touchesShouldCancelInContentView:view];
    //NO UIScrollView不可以滚动, YES UIScrollView可以滚动
    return YES;
}


@end

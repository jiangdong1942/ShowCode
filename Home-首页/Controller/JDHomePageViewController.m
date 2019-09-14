//
//  JDHomePageViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageViewController.h"
#import "HomePageBannerView.h"
#import "JDHomePageComprehensiveTableViewCell.h"
#import "JDHomePageViewController+JDNetwork.h"
#import "JDHomePageComprehensiveModel.h"
#import "JDHomePageFinancialProductsTableViewCell.h"
#import "JDHomeTableView.h"
#import "JDHomePageFinancialPolicyTableViewCell.h"

@interface JDHomePageViewController ()
/** 搜索的输入框按钮 */
@property(nonatomic, strong)UIButton *seachButton;
/** 轮播图的视图 */
@property(nonatomic, strong)HomePageBannerView *bannerView;
/** 轮播图的数据 */
@property(nonatomic, strong)NSArray *bannerArray;
/** 列表的数据 */
@property(nonatomic, strong)NSMutableArray *listArray;

@end

@implementation JDHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.topNavigationView.backgroundColor = UIColor.clearColor;
    self.topNavigationView.leftButton.hidden = YES;
    [self.topNavigationView addSubview:self.seachButton];
    
    [self subClassInitializeiTableView];
    
    [self jd_homePageNetwork:@{}];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        
//    NSArray *familyNames = [UIFont familyNames];
//    for( NSString *familyName in familyNames ){
//        printf( "Family: %s \n", [familyName UTF8String] );
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for( NSString *fontName in fontNames ){
//            printf( "\tFont: %s \n", [fontName UTF8String] );
//        }
//    }

}

- (void)viewWillLayoutSubviews{
    [self.seachButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(33);
        make.centerY.mas_equalTo(self.topNavigationView.titleLabel.mas_centerY);
    }];
}

#pragma mark - 网络回调
- (void)homeNetworkRequestCallbackBannerArray:(NSArray *)bannerArray
                    andComprehensiveDataModel:(JDHomePageComprehensiveModel *)comprehensiveDataModel
                    andFinancialProductsArray:(NSArray *)financialProductsArray
                      andFinancialPolicyArray:(NSArray *)financialPolicyArray{
    self.bannerArray = bannerArray;
    [self.listArray addObject:comprehensiveDataModel];
    [self.listArray addObject:financialProductsArray];
    [self.listArray addObject:financialPolicyArray];
    
    [self.tableView reloadData];
}

#pragma mark - tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
//            综合的cell
        case 0:
        {
            JDHomePageComprehensiveTableViewCell *cell = [JDHomePageComprehensiveTableViewCell cellWithNibTableView:tableView];
            cell.model = self.listArray[indexPath.section];
            return cell;
        }
            break;
//            金融产品cell
        case 1:
        {
            JDHomePageFinancialProductsTableViewCell *cell = [JDHomePageFinancialProductsTableViewCell cellWithNibTableView:tableView];
            NSArray *productsArray = self.listArray[indexPath.section];
            cell.model = productsArray[indexPath.row];
            
            if (indexPath.row == productsArray.count - 1) {
                cell.isShowBottom = YES;
            }else{
                cell.isShowBottom = NO;
            }
            
            return cell;
        }
            break;
//            金融政策
            case 2:
        {
            JDHomePageFinancialPolicyTableViewCell *cell = [JDHomePageFinancialPolicyTableViewCell cellWithNibTableView:tableView];
            
            NSArray *productsArray = self.listArray[indexPath.section];
            
            cell.model = productsArray[indexPath.row];
            
            if (indexPath.row == productsArray.count - 1) {
                cell.isShowBottom = YES;
            }else{
                cell.isShowBottom = NO;
            }
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qqq"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"qqq"];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (![DataCheck isValidArray:self.listArray]) {
        return 0;
    }
    switch (section) {
//            综合的选项
        case 0:
        {
            return 1;
            
        }
            break;
//            金融产品
        case 1:
        {
            NSArray *array = self.listArray[section];
            return array.count;
        }
            break;
//            金融政策
        case 2:
        {
            NSArray *array = self.listArray[section];
            return array.count;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

/** 列表分组的底视图 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [UIView new];
    
    footView.backgroundColor = UIColor.zt_backgroundView;
    
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
/** 列表分组的头视图 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [UIView new];
    
    headerView.backgroundColor = UIColor.whiteColor;
//    头部的标题
    UILabel *titleLabel = [UILabel new];
    
    titleLabel.font = UIFont.zt_font17Semibold;
//    头部更多的按钮
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    moreButton.titleLabel.font = UIFont.zt_font12withMedium;
    
    [moreButton setTitle:@"更多"
                forState:UIControlStateNormal];
    [moreButton setTitleColor:UIColor.zt_redButton
                     forState:UIControlStateNormal];
    
//    分割线
    UIView *buttomView = [UIView new];
    
    buttomView.backgroundColor = UIColor.zt_bottomViewColore1e1e1;
    
    switch (section) {
        case 1:
        {
            titleLabel.text = @"金融产品";
            [headerView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.centerY.mas_equalTo(0);
            }];
            
        
            [headerView addSubview:moreButton];
            [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-15);
                make.centerY.mas_equalTo(0);
            }];
            
            [headerView addSubview:buttomView];
            [buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.mas_equalTo(0);
                make.height.mas_equalTo(1);
            }];
            [moreButton addTarget:self
                           action:@selector(financialProductsClick:)
                 forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;
        case 2:
        {
            titleLabel.text = @"金融政策";
            [headerView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.centerY.mas_equalTo(0);
            }];
            
            [headerView addSubview:moreButton];
            [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-15);
                make.centerY.mas_equalTo(0);
            }];
            
            [headerView addSubview:buttomView];
            [buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.mas_equalTo(0);
                make.height.mas_equalTo(1);
            }];
            
            [moreButton addTarget:self
                           action:@selector(financialPolicyClick:)
                 forControlEvents:UIControlEventTouchUpInside];
        }
            
        default:
            break;
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section) {
        return 50;
    }
    return 0.0001;
}

#pragma mark - 搜索的点击点击事件
- (void)seachButtonClick{
    DLog(@"首页搜索点击");
}
#pragma mark - 金融产品的点击事件
- (void)financialProductsClick:(UIButton *)button{
    
}

#pragma mark - 金融政策的点击
- (void)financialPolicyClick:(UIButton *)button{
    
}
#pragma mark - 监听tableView滚动位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f", scrollView.contentOffset.y);
    
    
    if (scrollView.contentOffset.y > StatusBarAndNavigationBarHeight) {
        self.topNavigationView.backgroundColor = UIColor.zt_shadowColor;
    }else{
        self.topNavigationView.backgroundColor = UIColor.clearColor;
    }
}


#pragma mark - 初始化tableview
- (void)subClassInitializeiTableView{
    self.tableView = [[JDHomeTableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - TabbarHeight)
                                                  style:UITableViewStylePlain];
    
    [self initializeTableView];
    self.tableView.tableHeaderView = self.bannerView;
    self.tableView.backgroundColor = UIColor.zt_backgroundView;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - 懒加载
- (UIButton *)seachButton{
    
    if (!_seachButton) {
        _seachButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _seachButton.layer.masksToBounds = YES;
        _seachButton.layer.cornerRadius = 16.5f;
        _seachButton.titleLabel.font = UIFont.zt_font14;
        _seachButton.backgroundColor = UIColor.zt_whiteAndTransparent;
        
        [_seachButton setTitle:@"输入搜索关键词"
                      forState:UIControlStateNormal];
        [_seachButton addTarget:self
                         action:@selector(seachButtonClick)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _seachButton;
}

- (HomePageBannerView *)bannerView{
    
    if (!_bannerView) {
        _bannerView = [[HomePageBannerView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kScaleW * 233 + 149)];
    }
    return _bannerView;
}

- (NSMutableArray *)listArray{
    
    if (!_listArray) {
        _listArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _listArray;
}

@end

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
#import "JDHomePageFinancialPolicyModel.h"
#import "JDHomePageFinancialPolicyThreeTableViewCell.h"
#import "JDHomePageProductDetailsViewController.h"
#import "JDHomePageFinancialProductsModel.h"
#import "ZDLogInToViewController.h"
#import "JDHomePageSearchListViewController.h"
#import "JDListFinancialProductsMoreViewController.h"
#import "JDHomePageFinancialPolicyDetailViewController.h"
//#import "JDHomePageFinancialPolicyListViewController.h"
#import "ZDMyselfDemandViewController.h"
#import "ZDcreateDemandTabVController.h"
#import "ZDDemandForCenterViewController.h"

@interface JDHomePageViewController ()
/** 搜索的输入框按钮 */
@property(nonatomic, strong)UIButton *seachButton;
/** 轮播图的视图 */
@property(nonatomic, strong)HomePageBannerView *bannerView;
/** 轮播图的数据 */
@property(nonatomic, strong)NSArray *bannerArray;
/** 列表的数据 */
@property(nonatomic, strong)NSMutableArray *listArray;
///** 发布项目的数量 */
//@property(nonatomic, strong)NSString *publishProjectNumber;

@end

@implementation JDHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.topNavigationView.backgroundColor = UIColor.clearColor;
    self.topNavigationView.leftButton.hidden = YES;
    [self.topNavigationView addSubview:self.seachButton];
    
    [self subClassInitializeiTableView];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

//    [self.tableView reloadData];
    [self jd_homePageNetwork:@{}];
    
    [UserModel sharedSingleton].isHome = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clickItemDictionary:)
                                                 name:JDHomePageHohhotHeaderClick
     
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:JDHomePageHohhotHeaderClick object:nil];
    
}

- (void)viewWillLayoutSubviews{
    [self.seachButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(33);
        make.centerY.mas_equalTo(self.topNavigationView.titleLabel.mas_centerY);
    }];
    
    if ([DataCheck isValidString:[UserModel sharedSingleton].app_token]) {
        self.bannerView.frame = CGRectMake(0, 0, KScreenWidth, kScaleW * 233 + 149);
        self.bannerView.isHide = YES;
    }else{
        self.bannerView.frame = CGRectMake(0, 0, KScreenWidth, kScaleW * 233);
        self.bannerView.isHide = NO;
    }
    self.tableView.tableHeaderView = self.bannerView;
}

#pragma mark - 重写父类方法
- (void)jdNetworkConnectionInform{
    [self jd_homePageNetwork:@{}];
}

#pragma mark - 网络回调
- (void)homeNetworkRequestCallbackBannerArray:(NSArray *)bannerArray
                    andComprehensiveDataModel:(JDHomePageComprehensiveModel *)comprehensiveDataModel
                    andFinancialProductsArray:(NSArray *)financialProductsArray
                      andFinancialPolicyArray:(NSArray *)financialPolicyArray{
    self.bannerView.iconArray = bannerArray.mutableCopy;
    
    if ([DataCheck isValidArray:self.listArray]) {
        [self.listArray removeAllObjects];
    }
    [self.listArray addObject:comprehensiveDataModel];
    [self.listArray addObject:financialProductsArray];
    [self.listArray addObject:financialPolicyArray];
    
//    self.publishProjectNumber = comprehensiveDataModel.haveProjectCount;
    [UserModel sharedSingleton].haveProjectCount = comprehensiveDataModel.haveProjectCount;
    [UserModel sharedSingleton].haveProjectCount2 = comprehensiveDataModel.haveProjectCount2;
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
            ZDWeakSelf;
            
            cell.applyFundingSelectModel = ^(JDHomePageFinancialProductsModel * _Nonnull selectModel) {
                [weakSelf applyFundingClick:selectModel];
            };
            
            return cell;
        }
            break;
//            金融政策
            case 2:
        {
            
            NSArray *productsArray = self.listArray[indexPath.section];
            
            JDHomePageFinancialPolicyModel *policyModel = productsArray[indexPath.row];

            if (policyModel.newsImage.count >= 3) {
                JDHomePageFinancialPolicyThreeTableViewCell *cell = [JDHomePageFinancialPolicyThreeTableViewCell cellWithNibTableView:tableView];
                
                cell.model = policyModel;
                
                if (indexPath.row == productsArray.count - 1) {
                    cell.isShowBottom = YES;
                }else{
                    cell.isShowBottom = NO;
                }

                return cell;
            }else{
                JDHomePageFinancialPolicyTableViewCell *cell = [JDHomePageFinancialPolicyTableViewCell cellWithNibTableView:tableView];

                cell.model = policyModel;
                
                if (indexPath.row == productsArray.count - 1) {
                    cell.isShowBottom = YES;
                }else{
                    cell.isShowBottom = NO;
                }
                
                return cell;

            }

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

#pragma mark - cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 1:
        {            
            JDHomePageProductDetailsViewController *productDetails = [JDHomePageProductDetailsViewController new];
            
            JDHomePageFinancialProductsModel *model = self.listArray[indexPath.section][indexPath.row];
            productDetails.productListModel = model;
//            productDetails.publishProjectNumber = self.publishProjectNumber;
            
            [[AppDelegate sharedAppDelegate] pushViewController:productDetails
                                                  withBackTitle:@""];
        }
            break;
        case 2:
        {
            JDHomePageFinancialPolicyDetailViewController *policyDetail = [JDHomePageFinancialPolicyDetailViewController new];
            
            NSArray *productsArray = self.listArray[indexPath.section];
            
            JDHomePageFinancialPolicyModel *policyModel = productsArray[indexPath.row];
            
            policyDetail.policyModel = policyModel;
            
            [[AppDelegate sharedAppDelegate] pushViewController:policyDetail
                                                  withBackTitle:@""];
        }
            break;
        default:
            break;
    }
    
    
}

#pragma mark - 搜索的点击点击事件
- (void)seachButtonClick{
    DLog(@"首页搜索点击");
    
    [[AppDelegate sharedAppDelegate] pushViewController:[JDHomePageSearchListViewController new]
                                          withBackTitle:@""];
}
#pragma mark - 金融产品的更多点击事件跳转到金融产品列表
- (void)financialProductsClick:(UIButton *)button{
    NSLog(@"%ld", button.tag);

    JDListFinancialProductsMoreViewController *financia = [JDListFinancialProductsMoreViewController new];
    
    [[AppDelegate sharedAppDelegate] pushViewController:financia
                                          withBackTitle:@""];
}

#pragma mark - 金融产品点击融资申请
- (void)applyFundingClick:(JDHomePageFinancialProductsModel *)selectModel{
    DLog(@"%@", selectModel);
    
//    判断是否登录
    if (![DataCheck isValidString:[[UserModel sharedSingleton] app_token]]) {
        
        [self.navigationController presentViewController:[ZDLogInToViewController new]
                                                animated:YES
                                              completion:nil];
        return;
    }
//    ///企业状态1=申请认证,2=申请通过,3=申请驳回,0=未认证
    switch ([[UserModel sharedSingleton].status integerValue]) {
        case 0:
        {
            [MBProgressHUD showMessage:@"未进行企业认证"];
        }
            break;
        case 1:
        {
            [MBProgressHUD showMessage:@"企业认证正在审核中"];
        }
            break;
        case 2:
        {
            // 3.GCD
            dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
                //    这里判断是不是有发布的项目
                if ([[NSString stringWithFormat:@"%@", [UserModel sharedSingleton].haveProjectCount] integerValue] == 0) {
//                  没有发不过项目
                    if ([[NSString stringWithFormat:@"%@", [UserModel sharedSingleton].haveProjectCount2] integerValue] == 0) {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                                       message:@"您未创建需求，无法进行投递，请先创建项目。"
                                                                                preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *createProject = [UIAlertAction actionWithTitle:@"创建项目"
                                                                                style:UIAlertActionStyleDefault
                                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                                  [[AppDelegate sharedAppDelegate] pushViewController:[ZDcreateDemandTabVController new]
                                                                                                                        withBackTitle:@""];
                                                                              }];
                        
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                                         style:UIAlertActionStyleCancel
                                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                                           
                                                                       }];
                        
                        [alert addAction:createProject];
                        [alert addAction:cancel];
                        
                        [self presentViewController:alert
                                           animated:YES
                                         completion:nil];
                    }else{
//                        发布过项目，但是没有审核通过
                        [MBProgressHUD showMessage:@"需求未发布，发布后可投递"];
                    }
                    
                }else{
                    //跳转到需求中心
                    ZDMyselfDemandViewController *demand = [ZDMyselfDemandViewController new];
                    demand.type = @"1";
                    demand.productModel = selectModel;
                    [[AppDelegate sharedAppDelegate] pushViewController:demand withBackTitle:@""];
                }
            });
        }
            break;
        case 3:
        {
            [MBProgressHUD showMessage:@"企业认证被驳回，请重新认证"];
        }
            break;
            
        default:
            break;
    }

    
}

#pragma mark - 金融政策的更多点击
- (void)financialPolicyClick:(UIButton *)button{
    [[AppDelegate sharedAppDelegate] pushViewController:[NSClassFromString(@"JDHomePageFinancialPolicyListViewController") new]
                                          withBackTitle:@""];
}


#pragma mark -
- (void)clickItemDictionary:(NSNotification *)notic{
    
    NSDictionary *dic = notic.object;
    
    if ([dic[@"nextController"] isEqualToString:@"1"]) {
        self.tabBarController.selectedIndex = 1;
    }else{
        id vc = [[NSClassFromString(dic[@"nextController"]) alloc] init];
        [[AppDelegate sharedAppDelegate] pushViewController:vc
                                              withBackTitle:@""];
    }
    
    DLog(@"首页标签点击----%@", dic);
}

#pragma mark - 监听tableView滚动位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > StatusBarAndNavigationBarHeight) {
        self.topNavigationView.backgroundColor = UIColor.zt_shadowColor;
    }else{
        self.topNavigationView.backgroundColor = UIColor.clearColor;
    }
}


#pragma mark - 初始化tableview
- (void)subClassInitializeiTableView{
    self.tableView = [[JDHomeTableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - TabbarHeight)
                                                  style:UITableViewStyleGrouped];
    
    [self initializeTableView];
    
    self.tableView.backgroundColor = UIColor.zt_backgroundView;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.bounces = NO;
    
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

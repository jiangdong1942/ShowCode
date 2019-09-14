//
//  JDHomePageSearchListViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageSearchListViewController.h"
#import "JDHomePageSearchListViewController+Network.h"
#import "JDHomePageFinancialProductsTableViewCell.h"
#import "JDHomePageFinancialPolicyThreeTableViewCell.h"
#import "JDHomePageFinancialPolicyModel.h"
#import "JDHomePageFinancialPolicyTableViewCell.h"
#import "JDHomePageFinancialProductsModel.h"
#import "JDHomePageSearchInputBox.h"
#import "ZDLogInToViewController.h"
#import "JDHomePageProductDetailsViewController.h"
#import "JDListFinancialProductsMoreViewController.h"
#import "JDHomePageFinancialPolicyListViewController.h"
#import "JDHomePageFinancialPolicyDetailViewController.h"
#import "ZDMyselfDemandViewController.h"
#import "ZDcreateDemandTabVController.h"

@interface JDHomePageSearchListViewController ()
/**  返回所有数据 */
@property(nonatomic, strong)NSDictionary *dataDic;
/** 列表数据 */
@property(nonatomic, strong)NSMutableArray *dataArray;
/** 搜索的view */
@property(nonatomic, strong)JDHomePageSearchInputBox *searchView;
/** 搜索内容，输入返回来的字段与当前的字段进行判断，如果相同不进行网络的请求 */
@property(nonatomic, strong)NSString *searchString;

@end

@implementation JDHomePageSearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStyleGrouped];
    
    [self initializeTableView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0f;
    
    [self.view addSubview:self.tableView];
    
//    [self homePageSearchListNetwork:@""];
    
    [self.topNavigationView addSubview:self.searchView];
    
}

- (void)viewWillLayoutSubviews{
    self.tableView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + 1, KScreenWidth, KScreenHeight - StatusBarAndNavigationBarHeight - 1 - TabbarSafeBottomMargin);
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.topNavigationView.leftButton.mas_right);
    }];
}

#pragma mark - 搜索网络请求的回调
/** 搜索网络请求的回调 */
- (void)homePageSearchListNetworData:(NSDictionary *)dataDic{
    self.dataDic = dataDic;
    
    [self.dataArray removeAllObjects];
//    金融产品放到数组里
    [self.dataArray addObject:[JDHomePageFinancialProductsModel mj_objectArrayWithKeyValuesArray:dataDic[@"productList"]]];
//    金融政策数据发放入数组
    [self.dataArray addObject:[JDHomePageFinancialPolicyModel mj_objectArrayWithKeyValuesArray:dataDic[@"policyList"]]];
    
    [self.tableView reloadData];
}

#pragma mark - 金融产品更多的点击
- (void)financialProductsClick:(UIButton *)button{
    JDListFinancialProductsMoreViewController *financia = [JDListFinancialProductsMoreViewController new];
    
    financia.proName = self.searchString;
        
    [[AppDelegate sharedAppDelegate] pushViewController:financia
                                          withBackTitle:@""];
}

#pragma mark - 金融政策更多产品的点击
- (void)financialPolicyClick:(UIButton *)button{
    JDHomePageFinancialPolicyListViewController *financia = [JDHomePageFinancialPolicyListViewController new];
    
    financia.titleString = self.searchString;
    
    [[AppDelegate sharedAppDelegate] pushViewController:financia
                                          withBackTitle:@""];
}

#pragma mark - cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            JDHomePageProductDetailsViewController *productDetails = [JDHomePageProductDetailsViewController new];
            
            productDetails.productListModel = self.dataArray[indexPath.section][indexPath.row];
            
            [[AppDelegate sharedAppDelegate] pushViewController:productDetails
                                                  withBackTitle:@""];
        }
            break;
            case 1:
        {
            JDHomePageFinancialPolicyDetailViewController *policyDetail = [JDHomePageFinancialPolicyDetailViewController new];
            
            policyDetail.policyModel = self.dataArray[indexPath.section][indexPath.row];
            
            [[AppDelegate sharedAppDelegate] pushViewController:policyDetail
                                                  withBackTitle:@""];
        }
            break;
            
        default:
            break;
    }
    
    
}

#pragma mark - tableview代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
//            金融产品
        case 0:
        {
            JDHomePageFinancialProductsTableViewCell *cell = [JDHomePageFinancialProductsTableViewCell cellWithNibTableView:tableView];
            NSArray *productsArray = self.dataArray[indexPath.section];
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
            
        default:
        {
//            金融政策
            NSArray *productsArray = self.dataArray[indexPath.section];
            
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
    }
    
    
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
        case 0:
        {
            titleLabel.text = @"金融产品";
            [headerView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.centerY.mas_equalTo(0);
            }];
            
            
            if ([[NSString stringWithFormat:@"%@", self.dataDic[@"productCount"]] integerValue] > 5) {
                [headerView addSubview:moreButton];
                [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-15);
                    make.centerY.mas_equalTo(0);
                }];
            }
            
            
            
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
        case 1:
        {
            titleLabel.text = @"金融政策";
            [headerView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.centerY.mas_equalTo(0);
            }];
            
            if ([[NSString stringWithFormat:@"%@", self.dataDic[@"policyCount"]] integerValue] > 5) {
                [headerView addSubview:moreButton];
                [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-15);
                    make.centerY.mas_equalTo(0);
                }];
            }
            
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
    
//    金融政策数量
    if ([[NSString stringWithFormat:@"%@", self.dataDic[@"productCount"]] integerValue]&&section == 0) {
        return 50;
    }
    
    
//    金融政策数量
    if ( [[NSString stringWithFormat:@"%@", self.dataDic[@"policyCount"]] integerValue]&&section == 1) {
        return 50;
    }
    return 0;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    
    return array.count;
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


#pragma mark - 懒加载
- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _dataArray;
}

- (JDHomePageSearchInputBox *)searchView{
    
    if (!_searchView) {
        _searchView = [JDHomePageSearchInputBox new];
        _searchView.isBecomeFirstResponder = YES;
        
        ZDWeakSelf;
        _searchView.finshBlock = ^(NSString * _Nonnull finshString) {
            DLog(@"搜索输入----%@", finshString);
            
            if (![weakSelf.searchString isEqualToString:finshString]&&[DataCheck isValidString:finshString]) {
                weakSelf.searchString = finshString;
                
                [weakSelf homePageSearchListNetwork:weakSelf.searchString];
            }
        };
    }
    return _searchView;
}
@end

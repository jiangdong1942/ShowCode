//
//  JDListFinancialProductsMoreViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDListFinancialProductsMoreViewController.h"
#import "JDListFinancialProductsMoreViewController+Network.h"
#import "JDHomePageFinancialProductsTableViewCell.h"
#import "JDHomePageProductDetailsViewController.h"
#import "JDScreeningControllerViewController.h"
#import "JDScreeningItemModel.h"
#import "JDHomePageSearchInputBox.h"
#import "ZDLogInToViewController.h"
#import "ZDcreateDemandTabVController.h"
#import "ZDMyselfDemandViewController.h"

@interface JDListFinancialProductsMoreViewController ()
/** 显示数据 */
@property(nonatomic, strong)NSMutableArray *dataArray;

/** 搜索的view */
@property(nonatomic, strong)JDHomePageSearchInputBox *searchView;


@end

@implementation JDListFinancialProductsMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self ListFinancialProductsMoreNetwork];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    [self initializeTableView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    [self.view addSubview:self.tableView];
    
    [self.topNavigationView.rightButton setTitle:@"筛选"
                                        forState:UIControlStateNormal];
    
    [self.topNavigationView addSubview:self.searchView];
    
    [self jd_startFresh];
    
    if ([DataCheck isValidString:self.proName]) {
        self.searchView.textfield.text = self.proName;
    }
    
}

- (void)viewWillLayoutSubviews{
    self.tableView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + 1, KScreenWidth, KScreenHeight - StatusBarAndNavigationBarHeight - 1 - TabbarSafeBottomMargin);
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.topNavigationView.leftButton.mas_right);
        make.right.mas_equalTo(self.topNavigationView.rightButton.mas_left);
    }];
}
#pragma mark - 筛选按钮点击
- (void)rightButtonClick{
    
    ZDWeakSelf;
    
    JDScreeningControllerViewController *screening = [JDScreeningControllerViewController new];
    
    screening.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    screening.selectBlock = ^(id _Nonnull selectModel) {
        NSLog(@"%@", selectModel);
        
        
        JDScreeningItemModel *model = (JDScreeningItemModel *)selectModel;
        
        weakSelf.product_type = model.ID;
        weakSelf.pageNumber = 1;
        
        [weakSelf ListFinancialProductsMoreNetwork];
    
    };
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:screening
                                                                                 animated:NO
                                                                               completion:nil];
    
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


/** 金融产品列表（更多金融产品）网络请求数据 */
- (void)interfaceRequestReturnData:(NSArray *)array{
    if (self.pageNumber == 1) {
        [self.dataArray removeAllObjects];
    }
    
    [self.dataArray addObjectsFromArray:array];
    
    [self.tableView reloadData];
}

/** 结束上下拉刷新 */
- (void)jd_endFresh:(id)request{
    
    JDNetWorkResult *netWork = (JDNetWorkResult *)request;
    
    
    if ([DataCheck isValidDictionary:netWork.responseInfo]) {

        self.isLastPage = [[NSString stringWithFormat:@"%@", netWork.responseInfo[@"data"][@"productCount"]] integerValue] > self.pageNumber * 10 ? NO : YES;
     
    }
    
    [self endHeaderRefresh];
    [self endFooterRefresh];
}

- (void)jd_footerRereshing{
    [self ListFinancialProductsMoreNetwork];
}

- (void)jd_headerRereshing{
    [self ListFinancialProductsMoreNetwork];
}


#pragma mark - tableview代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JDHomePageFinancialProductsTableViewCell *cell = [JDHomePageFinancialProductsTableViewCell cellWithNibTableView:tableView];

    cell.model = self.dataArray[indexPath.row];
    
    if (indexPath.row == self.dataArray.count - 1) {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

#pragma mark - cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JDHomePageProductDetailsViewController *productDetails = [JDHomePageProductDetailsViewController new];
    
    productDetails.productListModel = self.dataArray[indexPath.row];
    
    [[AppDelegate sharedAppDelegate] pushViewController:productDetails
                                          withBackTitle:@""];
    
    
}


#pragma mark - 懒加载
- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

- (JDHomePageSearchInputBox *)searchView{
    
    if (!_searchView) {
        _searchView = [JDHomePageSearchInputBox new];
        ZDWeakSelf;
        _searchView.finshBlock = ^(NSString * _Nonnull finshString) {
            DLog(@"搜索输入----%@", finshString);
            
            if (![weakSelf.proName isEqualToString:finshString]) {
                weakSelf.proName = finshString;
                weakSelf.pageNumber = 1;
                [weakSelf ListFinancialProductsMoreNetwork];
            }
        };
    }
    return _searchView;
}


@end

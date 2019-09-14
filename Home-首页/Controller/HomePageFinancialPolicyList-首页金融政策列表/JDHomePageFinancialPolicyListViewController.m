//
//  JDHomePageFinancialPolicyListViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageFinancialPolicyListViewController.h"
#import "JDHomePageFinancialPolicyListViewController+Network.h"
#import "JDHomePageFinancialPolicyModel.h"
#import "JDHomePageFinancialPolicyThreeTableViewCell.h"
#import "JDHomePageFinancialPolicyTableViewCell.h"
#import "JDHomePageFinancialPolicyDetailViewController.h"
#import "JDHomePageSearchInputBox.h"

@interface JDHomePageFinancialPolicyListViewController ()
/** 列表数据 */
@property(nonatomic, strong)NSMutableArray<JDHomePageFinancialPolicyModel *> *dataArray;

/** 搜索的view */
@property(nonatomic, strong)JDHomePageSearchInputBox *searchView;

@end

@implementation JDHomePageFinancialPolicyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    self.topNavigationView.titleLabel.text = @"金融政策";
    
    [self JDHomePageFinancialPolicyListNetwork];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    [self initializeTableView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    [self.view addSubview:self.tableView];
    
    [self.topNavigationView addSubview:self.searchView];
    
    [self jd_startFresh];
    
    if ([DataCheck isValidString:self.titleString]) {
        self.searchView.textfield.text = self.titleString;
    }
}

- (void)viewWillLayoutSubviews{
    self.tableView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + 1, KScreenWidth, KScreenHeight - StatusBarAndNavigationBarHeight  - 1 - TabbarSafeBottomMargin);
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.left.mas_equalTo(self.topNavigationView.leftButton.mas_right);
        }];
    }];
}

/** 结束上下拉刷新 */
- (void)jd_endFresh:(id)request{
    
    JDNetWorkResult *netWork = (JDNetWorkResult *)request;
    
    
    if ([DataCheck isValidDictionary:netWork.responseInfo]) {
        
        self.isLastPage = [[NSString stringWithFormat:@"%@", netWork.responseInfo[@"data"][@"policyCount"]] integerValue] > self.pageNumber * 10 ? NO : YES;
        
    }
    
    [self endHeaderRefresh];
    [self endFooterRefresh];
}

- (void)jd_footerRereshing{
    [self JDHomePageFinancialPolicyListNetwork];
}

- (void)jd_headerRereshing{
    [self JDHomePageFinancialPolicyListNetwork];
}



/** 接口返回数据 */
- (void)interfaceRequestReturnData:(NSArray *)array{
    
    if (self.pageNumber == 1) {
        [self.dataArray removeAllObjects];
    }
    
    [self.dataArray addObjectsFromArray:[JDHomePageFinancialPolicyModel mj_objectArrayWithKeyValuesArray:array]];
    [self.tableView reloadData];
}

#pragma mark - cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JDHomePageFinancialPolicyDetailViewController *policyDetail = [JDHomePageFinancialPolicyDetailViewController new];
    
    policyDetail.policyModel = self.dataArray[indexPath.row];
    
    [[AppDelegate sharedAppDelegate] pushViewController:policyDetail
                                          withBackTitle:@""];
    
    
}


#pragma mark - tableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JDHomePageFinancialPolicyModel *policyModel = self.dataArray[indexPath.row];
    
    if (policyModel.newsImage.count >= 3) {
        JDHomePageFinancialPolicyThreeTableViewCell *cell = [JDHomePageFinancialPolicyThreeTableViewCell cellWithNibTableView:tableView];
        
        cell.model = policyModel;
        
        if (indexPath.row == self.dataArray.count - 1) {
            cell.isShowBottom = YES;
        }else{
            cell.isShowBottom = NO;
        }
        
        return cell;
    }else{
        JDHomePageFinancialPolicyTableViewCell *cell = [JDHomePageFinancialPolicyTableViewCell cellWithNibTableView:tableView];
        
        cell.model = policyModel;
        
        if (indexPath.row == self.dataArray.count - 1) {
            cell.isShowBottom = YES;
        }else{
            cell.isShowBottom = NO;
        }
        
        return cell;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
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
            
            if (![weakSelf.title isEqualToString:finshString]) {
                weakSelf.titleString = finshString;
                weakSelf.pageNumber = 1;
                [weakSelf JDHomePageFinancialPolicyListNetwork];
            }
        };
    }
    return _searchView;
}


@end

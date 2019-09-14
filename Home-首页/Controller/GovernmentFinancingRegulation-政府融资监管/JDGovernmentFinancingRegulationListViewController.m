//
//  JDGovernmentFinancingRegulationListViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDGovernmentFinancingRegulationListViewController.h"
#import "JDGovernmentFinancingRegulationListViewController+Network.h"
#import "JDEnterpriseServiceaListTableViewCell.h"
#import "JDEnterpriseServiceDetailViewController.h"
#import "JDAgencyServiceAuditViewController.h"

@interface JDGovernmentFinancingRegulationListViewController ()<JDEnterpriseServiceaListTableViewCellClickDelegate>

@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation JDGovernmentFinancingRegulationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.topNavigationView.hidden = YES;
    
    [self govFinancingSupervisionListNetwork];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    [self initializeTableView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    [self.view addSubview:self.tableView];
    
    [self jd_startFresh];
    
    //    筛选之后如果已经创建的控制器就会接受到通知，就会刷新，如果没有创建就回根据筛选的条件去进行加载
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataArrayModel)
                                                 name:JDHomePageFinanceRegulation
                                               object:nil];
}

- (void)viewWillLayoutSubviews{
    self.tableView.frame = self.view.bounds;
}

- (void)jd_footerRereshing{
    [self govFinancingSupervisionListNetwork];
}

/** 政府融资监管列表 */
- (void)govFinancingSupervisionListNetworkSuccess:(NSArray *)array{
    if (self.pageNumber == 1) {
        [self.dataArray removeAllObjects];
    }
    
    [self.dataArray addObjectsFromArray:array];
    
    [self.tableView reloadData];
}

/** 接收到通知刷新接口 */
- (void)dataArrayModel{
    self.pageNumber = 1;
    [self govFinancingSupervisionListNetwork];
}

#pragma mark - tableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JDEnterpriseServiceaListTableViewCell *cell = [JDEnterpriseServiceaListTableViewCell cellWithNibTableView:tableView];
    
    cell.governmentRegulationModel = self.dataArray[indexPath.row];
    cell.delegate = self;
    
    if (indexPath.row == self.dataArray.count - 1) {
        cell.isShowBottom = YES;
    }else{
        cell.isShowBottom = NO;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JDEnterpriseServiceDetailViewController *detail = [JDEnterpriseServiceDetailViewController new];
    
    detail.selectModel = self.dataArray[indexPath.row];
    [[AppDelegate sharedAppDelegate] pushViewController:detail
                                          withBackTitle:@""];
}

#pragma mark - 催办按钮点击
///政府催促办理
- (void)JDgovernmentUrgesActionTableViewCellSupplementaryMaterialClick:(JDEnterpriseServiceaListModel *)model{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"确认催办？"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       
                                                   }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                     JDAgencyServiceAuditViewController *agency = [JDAgencyServiceAuditViewController new];
                                                     
                                                     agency.type = @"5";
                                                     agency.dataModel = model;
                                                     
                                                     [[AppDelegate sharedAppDelegate] pushViewController:agency
                                                                                           withBackTitle:@""];
                                                 }];
    
    [alert addAction:cancel];
    [alert addAction:sure];
    
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

- (void)JDEnterpriseServiceaListTableViewCellBusinessValuationClick:(nonnull JDEnterpriseServiceaListModel *)model {
    
}


- (void)JDEnterpriseServiceaListTableViewCellSupplementaryMaterialClick:(nonnull JDEnterpriseServiceaListModel *)model {
    
}


#pragma mark - 懒加载
- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

- (void)setType:(NSString *)type{
    _type = type;
}


@end

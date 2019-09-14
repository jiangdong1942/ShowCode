//
//  JDHomePageProductDetailsAgencyProductViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsAgencyProductViewController.h"
#import "JDHomePageProductDetailsAgencyProductViewController+Network.h"
#import "JDHomePageFinancialProductsTableViewCell.h"
#import "JDHomePageProductDetailsProductIntroductionViewController.h"

@interface JDHomePageProductDetailsAgencyProductViewController ()
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation JDHomePageProductDetailsAgencyProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.topNavigationView.hidden = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, KScreenWidth, KScreenHeight - StatusBarAndNavigationBarHeight - 49)
                                                  style:UITableViewStylePlain];
    
    [self initializeTableView];
    
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    [self.view addSubview:self.tableView];
    [self agencyProductList];
}

#pragma mark - tableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JDHomePageFinancialProductsTableViewCell *cell = [JDHomePageFinancialProductsTableViewCell cellWithNibTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    
    if (indexPath.row == self.dataArray.count - 1) {
        cell.isShowBottom = YES;
    }else{
        cell.isShowBottom = NO;
    }
    
    cell.isHideButton = YES;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JDHomePageProductDetailsProductIntroductionViewController *productIntroduction = [JDHomePageProductDetailsProductIntroductionViewController new];
    
    productIntroduction.selectModel = self.dataArray[indexPath.row];
    
    [[AppDelegate sharedAppDelegate]pushViewController:productIntroduction
                                         withBackTitle:@""];
    
}

- (void)setIsHideButton:(BOOL)isHideButton{
    _isHideButton = isHideButton;
}


#pragma mark - 网络请求的回调
- (void)callbacksNetworkRequests:(NSArray *)array{
    
    if (self.pageNumber == 1) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:array];
    
    [self.tableView reloadData];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

@end

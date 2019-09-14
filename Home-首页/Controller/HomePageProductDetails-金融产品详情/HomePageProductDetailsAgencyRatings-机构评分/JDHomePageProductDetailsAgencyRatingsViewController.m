//
//  JDHomePageProductDetailsAgencyRatingsViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsAgencyRatingsViewController.h"
#import "JDHomePageProductDetailsAgencyRatingsTableViewCell.h"
#import "JDHomePageProductDetailsAgencyRatingsViewController+Network.h"
#import "JDHomePageProductDetailsAgencyRatingsModel.h"
#import "JDHomePageProductDetailsAgencyRatingsHeaderView.h"

@interface JDHomePageProductDetailsAgencyRatingsViewController ()

/** 显示的数据 */
@property(nonatomic, strong)JDHomePageProductDetailsAgencyRatingsModel *showModel;
/** 头部的数据 */
@property(nonatomic, strong)JDHomePageProductDetailsAgencyRatingsHeaderView *headerView;

@end

@implementation JDHomePageProductDetailsAgencyRatingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topNavigationView.hidden = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, KScreenWidth, KScreenHeight - StatusBarAndNavigationBarHeight - 49) style:UITableViewStyleGrouped];
    
    [self initializeTableView];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:self.tableView];
    
    [self agencyRatingsRequest];
}


- (void)viewWillLayoutSubviews{
    self.tableView.frame = CGRectMake(0, 1, self.view.bounds.size.width, self.view.bounds.size.height - 1);
}
#pragma mark - 网络请求的回调
- (void)callbacksNetworkRequests:(JDHomePageProductDetailsAgencyRatingsModel *)showModel{
    self.showModel = showModel;
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JDHomePageProductDetailsAgencyRatingsTableViewCell *cell = [JDHomePageProductDetailsAgencyRatingsTableViewCell cellWithNibTableView:tableView];
    cell.model = self.showModel.list[indexPath.row];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showModel.list.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    self.headerView.model = self.showModel;
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 59;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([DataCheck isValidArray:self.showModel.list]) {
        return 1;
    }
    return 0;
}
#pragma mark - 懒加载
- (JDHomePageProductDetailsAgencyRatingsHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [[JDHomePageProductDetailsAgencyRatingsHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 59)];
        _headerView.backgroundColor = UIColor.whiteColor;
    }
    return _headerView;
}
@end

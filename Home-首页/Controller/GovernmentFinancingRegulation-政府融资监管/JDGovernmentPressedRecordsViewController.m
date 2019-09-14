//
//  JDGovernmentPressedRecordsViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDGovernmentPressedRecordsViewController.h"
#import "JDGovernmentPressedRecordsTableViewCell.h"
#import "JDEnterpriseServiceaListModel.h"
#import "JDGovernmentPressedRecordsViewController+Network.h"

@interface JDGovernmentPressedRecordsViewController ()

@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation JDGovernmentPressedRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topNavigationView.titleLabel.text = @"催办记录";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
    
    [self initializeTableView];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    [self.view addSubview:self.tableView];
    if ([self.typeString isEqualToString:@"1"]) {
        [self listofCuiBanCount];
    }else{
        [self allPressMessageListNetwork];
    }
    
    [self jd_startFresh];
}

- (void)viewWillLayoutSubviews{
    self.tableView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + 10, KScreenWidth, KScreenHeight - StatusBarAndNavigationBarHeight - 10 - TabbarSafeBottomMargin);
}

- (void)jd_headerRereshing{
    [self allPressMessageListNetwork];
}

#pragma mark - tableview代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JDGovernmentPressedRecordsTableViewCell *cell = [JDGovernmentPressedRecordsTableViewCell cellWithNibTableView:tableView];
    
    cell.model = self.dataArray[indexPath.row];
    
    if (indexPath.row == self.dataArray.count - 1) {
        cell.isShowLine = YES;
    }else{
        cell.isShowLine = NO;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

#pragma mark - 网络回调
/** 政府催办列表 */
- (void)allPressMessageListNetworkSuccess:(NSArray *)array{
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

- (void)setModel:(JDEnterpriseServiceaListModel *)model{
    _model = model;
}

@end

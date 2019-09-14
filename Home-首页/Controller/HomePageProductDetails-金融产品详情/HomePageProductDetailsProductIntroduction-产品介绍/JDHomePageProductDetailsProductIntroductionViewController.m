//
//  JDHomePageProductDetailsProductIntroductionViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsProductIntroductionViewController.h"
#import "JDHomePageProductDetailsProductIntroductionViewController+Network.h"
#import "JDHomePageProductDetailsProductIntroductionRateTableViewCell.h"
#import "JDHomePageProductDetailsProductIntroductionApplicationProcessTableViewCell.h"
#import "JDHomePageProductDetailsTextDetailTableViewCell.h"
#import "JDHomePageProductDetailsProductContactPersonTableViewCell.h"
#import "JDHomePageFinancialProductsModel.h"

@interface JDHomePageProductDetailsProductIntroductionViewController ()

@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation JDHomePageProductDetailsProductIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([DataCheck isValidString:self.ID]) {
        self.topNavigationView.hidden = YES;
        
        [self productIntroductionNetwork];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, KScreenWidth, KScreenHeight - StatusBarAndNavigationBarHeight - 49)
                                                      style:UITableViewStyleGrouped];
        [self initializeTableView];
        self.tableView.estimatedRowHeight = 100;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        [self.view addSubview:self.tableView];
    }
    
    if (self.selectModel) {
        self.topNavigationView.hidden = NO;
        
        self.topNavigationView.titleLabel.text = @"产品介绍";
        
        self.ID = self.selectModel.ID;
        
        [self productIntroductionNetwork];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + 1, KScreenWidth, KScreenHeight - StatusBarAndNavigationBarHeight - 1)
                                                      style:UITableViewStyleGrouped];
        [self initializeTableView];
        self.tableView.estimatedRowHeight = 100;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        [self.view addSubview:self.tableView];
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillLayoutSubviews{
    if ([DataCheck isValidString:self.ID]&&!self.selectModel) {
        self.tableView.frame = CGRectMake(0, 1, KScreenWidth, self.view.bounds.size.height);
    }
}

#pragma mark - 网络请求的回调
- (void)productIntroductionNetworkResult:(NSArray *)dataArray{
    self.dataArray = dataArray;
    [self.tableView reloadData];
}

#pragma mark - tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            JDHomePageProductDetailsProductIntroductionRateTableViewCell *cell = [JDHomePageProductDetailsProductIntroductionRateTableViewCell cellWithNibTableView:tableView];
            
            cell.model = self.dataArray[indexPath.row];
            
            return cell;
        }
            break;
        case 1:
        {
            JDHomePageProductDetailsProductIntroductionApplicationProcessTableViewCell *cell = [JDHomePageProductDetailsProductIntroductionApplicationProcessTableViewCell cellWithNibTableView:tableView];
            return cell;
        }
            break;
        case 6:
        {
            JDHomePageProductDetailsProductContactPersonTableViewCell *cell = [JDHomePageProductDetailsProductContactPersonTableViewCell cellWithNibTableView:tableView];
            cell.model = self.dataArray[indexPath.row];
            return cell;
        }
            break;
            
            
        default:
        {
            JDHomePageProductDetailsTextDetailTableViewCell *cell = [JDHomePageProductDetailsTextDetailTableViewCell cellWithNibTableView:tableView];
            cell.model = self.dataArray[indexPath.row];
            return cell;
        }
            break;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

#pragma mark - 从机构产品进入查看详情
- (void)setSelectModel:(JDHomePageFinancialProductsModel *)selectModel{
    _selectModel = selectModel;
}

@end

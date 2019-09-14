//
//  JDHomePageProductDetailsAgencyInformationctionViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsAgencyInformationctionViewController.h"
#import "JDHomePageProductDetailsAgencyInformationctionTableViewCell.h"
#import "JDHomePageProductDetailsAgencyInformationctionViewController+Network.h"
#import "JDBusinessValuationCFCTableViewCell.h"
#import "JDBusinessValuationDescribeTableViewCell.h"

@interface JDHomePageProductDetailsAgencyInformationctionViewController ()

@property(nonatomic, strong)NSArray *dataArray;

@property(nonatomic, strong)UIButton *evaluationButton;
/** 评价分数 */
@property(nonatomic, assign)CGFloat score;
/** 输入评价的内容 */
@property(nonatomic, strong)NSString *content;


@end

@implementation JDHomePageProductDetailsAgencyInformationctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.isEvaluation) {
        self.topNavigationView.hidden = YES;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, KScreenWidth, KScreenHeight - StatusBarAndNavigationBarHeight - 49)
                                                      style:UITableViewStylePlain];
        [self agencyInformationctionNetwork];
    }else{
        self.topNavigationView.hidden = NO;
        self.topNavigationView.titleLabel.text = @"进行评价";
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + 1, KScreenWidth, KScreenHeight - StatusBarAndNavigationBarHeight - 49 - TabbarSafeBottomMargin - 70)
                                                      style:UITableViewStylePlain];
        
        [self.view addSubview:self.evaluationButton];
        [self.evaluationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-10 - TabbarSafeBottomMargin);
            make.height.mas_equalTo(50);
        }];
        
        if ([[UserModel sharedSingleton].type isEqualToString:@"1"]) {
            [self agencyInformationctionNetwork];
        }else{
            [self getCompanyInfoByIdNetwork];
        }
    }
    
    
    
    [self initializeTableView];
    
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    
    
    
}

#pragma mark - tableView代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 1:
        {
            JDBusinessValuationCFCTableViewCell *cell = [JDBusinessValuationCFCTableViewCell cellWithNibTableView:tableView];
            
            cell.clickBlock = ^(float score) {
                DLog(@"%f", score);
                self.score = score;
            };
            
            return cell;
        }
            break;
            case 2:
        {
            JDBusinessValuationDescribeTableViewCell *cell = [JDBusinessValuationDescribeTableViewCell cellWithNibTableView:tableView];
            
            cell.textViewBlock = ^(NSString *textView) {
                self.content = textView;
            };
            
            return cell;
        }
            break;
            
        default:
        {
            JDHomePageProductDetailsAgencyInformationctionTableViewCell *cell = [JDHomePageProductDetailsAgencyInformationctionTableViewCell cellWithNibTableView:tableView];
            
            cell.model = self.dataArray[indexPath.row];
            
            return cell;
        }
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [UIView new];
    footView.backgroundColor = UIColor.whiteColor;
    
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (!section) {
        return 10;
    }
    return 0.00001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
            
        default:
        {
            return self.dataArray.count;
        }
            break;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    进行评价是两组
    if (self.isEvaluation) {
        return 3;
    }
//    机构信息是一组
    return 1;
}

#pragma mark - 评价的点击按钮
- (void)evaluationButtonClick{
    DLog(@"进行评价");
    
    if (self.score == 0) {
        self.score = 5;
    }
    
    if (![DataCheck isValidString:self.content]) {
        [MBProgressHUD showMessage:@"请填写评价内容"];
        
        return;
    }
    
    if ([[UserModel sharedSingleton].type isEqualToString:@"1"]) {
        [self enterprisesEvaluateInstitutionsParameter:@{
                                                         @"financingProjectId":self.financingProjectId,
                                                         @"score":[NSString stringWithFormat:@"%.2f", self.score],
                                                         @"description":self.content,
                                                         @"type":@"1"
                                                         }];
    }else{
        [self enterprisesEvaluateInstitutionsParameter:@{
                                                         @"financingProjectId":self.financingProjectId,
                                                         @"score":[NSString stringWithFormat:@"%.2f", self.score],
                                                         @"description":self.content,
                                                         @"type":@"2"
                                                         }];
    }
    
}

#pragma mark - 评价完成之后的回调
- (void)evaluationComplete{
    [MBProgressHUD showMessage:@"评价完成"];
    
    NSNotification *notice = [NSNotification notificationWithName:JDHomePageHohhotHeaderRequest
                                                           object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}


#pragma mark - 网络请求的回调
- (void)callbacksNetworkRequests:(NSArray *)array{
    self.dataArray = array;
    
    [self.tableView reloadData];
}

#pragma mark - 懒加载
- (void)setIsEvaluation:(BOOL)isEvaluation{
    _isEvaluation = isEvaluation;
}

- (UIButton *)evaluationButton{
    
    if (!_evaluationButton) {
        _evaluationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_evaluationButton setBackgroundColor:UIColor.zt_redButton];
        [_evaluationButton setTitle:@"评价"
                           forState:UIControlStateNormal];
        
        _evaluationButton.layer.masksToBounds = YES;
        _evaluationButton.layer.cornerRadius = 5.0f;
        
        [_evaluationButton addTarget:self
                              action:@selector(evaluationButtonClick)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaluationButton;
}


@end

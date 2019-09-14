//
//  JDGovernmentFinancingRegulationViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDGovernmentFinancingRegulationViewController.h"
#import "JDGovernmentFinancingRegulationListViewController.h"
#import "JDScreeningControllerViewController.h"
#import "JDGovernmentFinancingRegulationModel.h"

@interface JDGovernmentFinancingRegulationViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField *searchTextField;

@end

@implementation JDGovernmentFinancingRegulationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.TabberArray = @[@"全部", @"待受理", @"待审核", @"待放款", @"已放款", @"已驳回", @"待补充材料", @"已评价"];
    
    [self.categoryView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(StatusBarAndNavigationBarHeight + 1);
    }];
    
    [self.topNavigationView.rightButton setTitle:@"筛选"
                                        forState:UIControlStateNormal];
    
    [self.topNavigationView addSubview:self.searchTextField];
}

- (void)viewWillLayoutSubviews{
    
    self.scrollView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight + 50, KScreenWidth, KScreenHeight - StatusBarAndNavigationBarHeight - 50 - TabbarSafeBottomMargin);
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topNavigationView.leftButton.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(self.topNavigationView.leftButton.mas_centerY);
        make.right.mas_equalTo(self.topNavigationView.rightButton.mas_left).mas_equalTo(-10);
        make.height.mas_equalTo(35);
    }];
}

- (void)setupChildVcs{
    //    全部
    JDGovernmentFinancingRegulationListViewController *all = [JDGovernmentFinancingRegulationListViewController new];
    
    all.type = @"";
    [self addChildViewController:all];
    //    待受理
    JDGovernmentFinancingRegulationListViewController *accept = [JDGovernmentFinancingRegulationListViewController new];
    accept.type = @"1";
    [self addChildViewController:accept];
    //    待审核
    JDGovernmentFinancingRegulationListViewController *audit = [JDGovernmentFinancingRegulationListViewController new];
    audit.type = @"2";
    [self addChildViewController:audit];
    //    待放款
    JDGovernmentFinancingRegulationListViewController *lending = [JDGovernmentFinancingRegulationListViewController new];
    lending.type = @"5";
    [self addChildViewController:lending];
    //    已放款
    JDGovernmentFinancingRegulationListViewController *hasBeenLending = [JDGovernmentFinancingRegulationListViewController new];
    hasBeenLending.type = @"6";
    [self addChildViewController:hasBeenLending];
    //    已驳回
    JDGovernmentFinancingRegulationListViewController *rejected = [JDGovernmentFinancingRegulationListViewController new];
    rejected.type = @"4";
    [self addChildViewController:rejected];
    //     待补充材料
    JDGovernmentFinancingRegulationListViewController *supplemented = [JDGovernmentFinancingRegulationListViewController new];
    supplemented.type = @"3";
    [self addChildViewController:supplemented];
    //    已评价
    JDGovernmentFinancingRegulationListViewController *evaluation = [JDGovernmentFinancingRegulationListViewController new];
    evaluation.type = @"7";
    [self addChildViewController:evaluation];
}

#pragma mark - 筛选按钮点击
- (void)rightButtonClick{
    
    JDScreeningControllerViewController *screening = [JDScreeningControllerViewController new];
    
    screening.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    screening.selectBlock = ^(id _Nonnull selectModel) {
        NSLog(@"%@", selectModel);
        
        
        JDScreeningItemModel *model = (JDScreeningItemModel *)selectModel;
        
        [JDGovernmentFinancingRegulationModel sharedSingleton].selectModel = model;
        
        NSNotification *notice = [NSNotification notificationWithName:JDHomePageFinanceRegulation
                                                               object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotification:notice];
        
    };
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:screening
                                                                                 animated:NO
                                                                               completion:nil];
    
}

#pragma mark - textField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [JDGovernmentFinancingRegulationModel sharedSingleton].searchContent = textField.text;
    
    NSNotification *notice = [NSNotification notificationWithName:JDHomePageFinanceRegulation
                                                           object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    [self.view endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [JDGovernmentFinancingRegulationModel sharedSingleton].searchContent = textField.text;
    
    NSNotification *notice = [NSNotification notificationWithName:JDHomePageFinanceRegulation
                                                           object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    [self.view endEditing:YES];
}

#pragma mark - 懒加载
- (UITextField *)searchTextField{
    
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        
        _searchTextField.placeholder = @"请输入搜索内容";
        _searchTextField.backgroundColor = UIColor.zt_backgroundView;
        _searchTextField.textColor = UIColor.zt_fontGray;
        _searchTextField.font = UIFont.zt_font15;
        _searchTextField.textAlignment = NSTextAlignmentCenter;
        _searchTextField.returnKeyType = UIReturnKeySearch;//变为搜索按钮
        
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}

@end

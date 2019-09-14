//
//  JDHomePageProductDetailsViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageProductDetailsViewController.h"

#import "JDHomePageFinancialProductsModel.h"

#import "JDHomePageProductDetailsProductIntroductionViewController.h"
#import "JDHomePageProductDetailsAgencyInformationctionViewController.h"
#import "JDHomePageProductDetailsAgencyRatingsViewController.h"
#import "JDHomePageProductDetailsAgencyProductViewController.h"

#import "ZDMyselfDemandViewController.h"
#import "ZDcreateDemandTabVController.h"
#import "JDHomePageProductDetailsViewController+Network.h"
#import "ZDDemanCommitModel.h"
#import "ZDFillFinancingAmountTableVC.h"

@interface JDHomePageProductDetailsViewController ()

@property(nonatomic, strong)UIButton *applyFundingButton;

@end

@implementation JDHomePageProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topNavigationView.titleLabel.text = @"金融产品详情";
    self.TabberArray = @[@"产品介绍", @"机构信息", @"机构评分", @"机构产品"];

    [self.view addSubview:self.applyFundingButton];
    
    if ([[UserModel sharedSingleton].type isEqualToString:@"1"]) {
        [self.topNavigationView.rightButton setImage:[UIImage imageNamed:@"unselectedCollection"]
                                            forState:UIControlStateNormal];
        [self.topNavigationView.rightButton setImage:[UIImage imageNamed:@"selectedCollection"]
                                            forState:UIControlStateSelected];
        [self.topNavigationView.rightButton addTarget:self
                                               action:@selector(rightButtonClick:)
                                     forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.productListModel.iscollect isEqualToString:@"1"]) {
            self.topNavigationView.rightButton.selected = YES;
        }
    }
    
    
}

- (void)viewWillLayoutSubviews{
    
    if ([DataCheck isValidString:[UserModel sharedSingleton].app_token]&&[[UserModel sharedSingleton].type isEqualToString:@"1"]) {
        self.scrollView.frame =  CGRectMake(0, StatusBarAndNavigationBarHeight + 48, KScreenWidth, KScreenHeight - StatusBarAndNavigationBarHeight - 48 - 70 - TabbarSafeBottomMargin);
        
        [self.applyFundingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-10 - TabbarSafeBottomMargin);
            make.height.mas_equalTo(50);
        }];
    }
    
}

- (void)rightButtonClick:(UIButton *)button{
//    button.selected = !button.selected;
//    收藏类型(0=取消,1=添加)
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:3];
    if (button.selected) {
        [param setObject:@"0"
                  forKey:@"type"];
    }else{
        [param setObject:@"1"
                  forKey:@"type"];
    }
    
    [self collectionFinancialProductsEnterprises:param];
}

/** 收藏成功的回调 */
- (void)collectionFinancialProductsEnterprisesSuccess{
    self.topNavigationView.rightButton.selected = !self.topNavigationView.rightButton.selected;
    
    if (self.topNavigationView.rightButton.selected) {
        self.productListModel.iscollect = @"1";
    }else{
        self.productListModel.iscollect = @"0";
    }
}

/**
申请融资点击
 */
- (void)applyButtonClick{
//    //跳转到需求中心
//    ZDMyselfDemandViewController *demand = [ZDMyselfDemandViewController new];
//    demand.type = @"1";
//    [[AppDelegate sharedAppDelegate] pushViewController:demand withBackTitle:@""];
    
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
                    
                    if (!self.projectModel) {
                        //跳转到需求中心
                        ZDMyselfDemandViewController *demand = [ZDMyselfDemandViewController new];
                        demand.type = @"1";
                        demand.productModel = self.productListModel;
                        [[AppDelegate sharedAppDelegate] pushViewController:demand withBackTitle:@""];
                    }else{
                        ZDFillFinancingAmountTableVC *applyAmount = [[ZDFillFinancingAmountTableVC alloc] init];
                        applyAmount.productModel = self.productListModel;
                        applyAmount.projectModel = self.projectModel;
                        [[AppDelegate sharedAppDelegate] pushViewController:applyAmount withBackTitle:@""];
                    }
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
- (void)setupChildVcs
{
    JDHomePageProductDetailsProductIntroductionViewController *productIntroduction = [[JDHomePageProductDetailsProductIntroductionViewController alloc] init];
    productIntroduction.ID = self.productListModel.ID;
    [self addChildViewController:productIntroduction];
    
    JDHomePageProductDetailsAgencyInformationctionViewController *agencyInformationction = [[JDHomePageProductDetailsAgencyInformationctionViewController alloc] init];
    agencyInformationction.ID = self.productListModel.org_id;
    
    [self addChildViewController:agencyInformationction];

    JDHomePageProductDetailsAgencyRatingsViewController *agencyRatings = [[JDHomePageProductDetailsAgencyRatingsViewController alloc] init];
    agencyRatings.ID = self.productListModel.org_id;
    
    [self addChildViewController:agencyRatings];

    JDHomePageProductDetailsAgencyProductViewController *agencyProduct = [[JDHomePageProductDetailsAgencyProductViewController alloc] init];
    agencyProduct.orgId = self.productListModel.org_id;
    agencyProduct.productId = self.productListModel.ID;
    
    agencyProduct.isHideButton = self.isHideButton;
    
    [self addChildViewController:agencyProduct];
    
    
}

- (void)setIsHideButton:(BOOL)isHideButton{
    _isHideButton = isHideButton;
}

- (void)setProductListModel:(JDHomePageFinancialProductsModel *)productListModel{
    _productListModel = productListModel;
}

#pragma mark - 懒加载
- (UIButton *)applyFundingButton{
    
    if (!_applyFundingButton) {
        _applyFundingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_applyFundingButton setBackgroundColor:UIColor.zt_redButton];
        if ([self.productListModel.isfinancing isEqualToString:@"1"]) {
            [_applyFundingButton setTitle:@"已投递"
                                 forState:UIControlStateNormal];
        }else{
            [_applyFundingButton setTitle:@"申请融资"
                                 forState:UIControlStateNormal];
            [_applyFundingButton addTarget:self action:@selector(applyButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        _applyFundingButton.layer.masksToBounds = YES;
        _applyFundingButton.layer.cornerRadius = 5.0f;
        
    }
    return _applyFundingButton;
}

@end

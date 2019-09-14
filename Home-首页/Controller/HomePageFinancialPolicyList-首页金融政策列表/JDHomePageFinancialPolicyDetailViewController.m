//
//  JDHomePageFinancialPolicyDetailViewController.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageFinancialPolicyDetailViewController.h"
#import "JDHomePageFinancialPolicyModel.h"
@interface JDHomePageFinancialPolicyDetailViewController ()

@end

@implementation JDHomePageFinancialPolicyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.topNavigationView.titleLabel.text = @"金融政策详情";
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.policyModel.staticpageurl]]];
}

- (void)setPolicyModel:(JDHomePageFinancialPolicyModel *)policyModel{
    _policyModel = policyModel;
}

@end

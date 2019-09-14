//
//  JDHomePageProductDetailsAgencyInformationctionViewController.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/7/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDTableViewBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface JDHomePageProductDetailsAgencyInformationctionViewController : JDTableViewBaseViewController

/** 金融产品的ID */
@property(nonatomic, strong)NSString *ID;
/** 融资项目id,在评价时候使用 */
@property(nonatomic, strong)NSString *financingProjectId;
/** 是不是评价界面 */
@property(nonatomic, assign)BOOL isEvaluation;

#pragma mark - 网络请求的回调
- (void)callbacksNetworkRequests:(NSArray *)array;
#pragma mark - 评价完成之后的回调
- (void)evaluationComplete;

@end

NS_ASSUME_NONNULL_END

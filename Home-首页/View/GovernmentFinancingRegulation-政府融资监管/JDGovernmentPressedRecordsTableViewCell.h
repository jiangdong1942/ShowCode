//
//  JDGovernmentPressedRecordsTableViewCell.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDBaseTableViewCell.h"
@class JDGovernmentPressedRecordsModel;
NS_ASSUME_NONNULL_BEGIN

@interface JDGovernmentPressedRecordsTableViewCell : JDBaseTableViewCell

@property(nonatomic, strong)JDGovernmentPressedRecordsModel *model;

@property(nonatomic, assign)BOOL isShowLine;

@end

NS_ASSUME_NONNULL_END

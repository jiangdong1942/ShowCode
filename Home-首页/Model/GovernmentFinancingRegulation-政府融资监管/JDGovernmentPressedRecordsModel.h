//
//  JDGovernmentPressedRecordsModel.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDGovernmentPressedRecordsModel : NSObject
/** 催办方名称 */
@property(nonatomic, strong)NSString *government_name;
/** 催办内容 */
@property(nonatomic, strong)NSString *press_content;
/** 催办时间 */
@property(nonatomic, strong)NSString *press_time;
/** 催办状态 1=待受理，2=待审核，3=需要补充材料，4=驳回，5=审核通过，待放款，6=已放款，7=已评价 */
@property(nonatomic, strong)NSString *status;
/** 催办id */
@property(nonatomic, strong)NSString *ID;
@end

NS_ASSUME_NONNULL_END

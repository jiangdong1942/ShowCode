//
//  JDHomePageSearchInputBox.h
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^JDHomePageSearchInputBoxfinsh)(NSString *finshString);

@interface JDHomePageSearchInputBox : UIView

@property(nonatomic, copy)JDHomePageSearchInputBoxfinsh finshBlock;

@property(nonatomic, assign)BOOL isBecomeFirstResponder;

@property(nonatomic, strong)UITextField *textfield;

@end

NS_ASSUME_NONNULL_END

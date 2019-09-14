//
//  JDHomePageSearchInputBox.m
//  MobilePhoneFinancing
//
//  Created by apple on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JDHomePageSearchInputBox.h"

@interface JDHomePageSearchInputBox ()<UITextFieldDelegate>

@property(nonatomic, strong)UIView *background;


@end

@implementation JDHomePageSearchInputBox


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.background];
        [self.background addSubview:self.textfield];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-7);
        make.height.mas_equalTo(30);
    }];
    
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark - textfield代理
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.finshBlock) {
        self.finshBlock(textField.text);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self endEditing:YES];
    return YES;
}

- (void)setIsBecomeFirstResponder:(BOOL)isBecomeFirstResponder{
    if (isBecomeFirstResponder) {
        [self.textfield becomeFirstResponder];
    }
}
#pragma mark - 懒加载
- (UITextField *)textfield{
    
    if (!_textfield) {
        _textfield = [[UITextField alloc] init];
        
        _textfield.backgroundColor = UIColor.zt_backgroundView;
        _textfield.font = UIFont.zt_font14;
        _textfield.textColor = UIColor.zt_fontBlack;
        _textfield.delegate = self;
        _textfield.placeholder = @"请输入搜索内容";
        _textfield.returnKeyType = UIReturnKeySearch;
    }
    return _textfield;
}

- (UIView *)background{
    
    if (!_background) {
        _background = [UIView new];
        _background.backgroundColor = UIColor.zt_backgroundView;
        _background.layer.masksToBounds = YES;
        _background.layer.cornerRadius = 5.0f;
    }
    return _background;
}
@end

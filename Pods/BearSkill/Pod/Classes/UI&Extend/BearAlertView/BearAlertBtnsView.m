//
//  BearAlertBtnsView.m
//  GOSHOPPING
//
//  Created by Bear on 16/6/26.
//  Copyright © 2016年 cjl. All rights reserved.
//

#import "BearAlertBtnsView.h"
#import "UIView+BearSet.h"

@interface BearAlertBtnsView ()
{
    NSString *_confirmBtnTitle;
    NSString *_cancelBtnTitle;
}

@end

@implementation BearAlertBtnsView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        //  取消按钮
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_cancelBtn];
        
        //  确定按钮
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_confirmBtn];
        
        //  分割线
        _btns_horizontalSepLineV = [[UIView alloc] init];
        _btns_horizontalSepLineV.backgroundColor = [UIColor blackColor];
        [self addSubview:_btns_horizontalSepLineV];
        
        _btns_verticalSepLineV = [[UIView alloc] init];
        _btns_verticalSepLineV.backgroundColor = [UIColor blackColor];
        [self addSubview:_btns_verticalSepLineV];
    }
    
    return self;
}

- (void)setNormal_CancelBtnTitle:(NSString *)cancelBtnTitle ConfirmBtnTitle:(NSString *)confirmBtnTitle
{
    _cancelBtnTitle = cancelBtnTitle;
    _confirmBtnTitle = confirmBtnTitle;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    BOOL res_haveConfirmBtn = [_confirmBtnTitle length] > 0;
    BOOL res_haveCancelBtn = [_cancelBtnTitle length] > 0;
    
    CGFloat btn_width = self.width;
    CGFloat btn_height = self.height;
    
    if (res_haveCancelBtn && res_haveConfirmBtn) {
        
        btn_width = self.width / 2.0;
        
        _cancelBtn.frame = CGRectMake(0, 0, btn_width, btn_height);
        [_cancelBtn setTitle:_cancelBtnTitle forState:UIControlStateNormal];
        
        _confirmBtn.frame = CGRectMake(btn_width, 0, btn_width, btn_height);
        [_confirmBtn setTitle:_confirmBtnTitle forState:UIControlStateNormal];
        
        _btns_verticalSepLineV.frame = CGRectMake(0, 0, 0.5, self.height);
        [_btns_verticalSepLineV BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    }
    else if (res_haveConfirmBtn || res_haveCancelBtn){
        
        btn_width = self.width;
        
        if (res_haveConfirmBtn) {
            
            _confirmBtn.frame = CGRectMake(0, 0, btn_width, btn_height);
            [_confirmBtn setTitle:_confirmBtnTitle forState:UIControlStateNormal];
        }else if (res_haveCancelBtn){
            
            _cancelBtn.frame = CGRectMake(0, 0, btn_width, btn_height);
            [_cancelBtn setTitle:_cancelBtnTitle forState:UIControlStateNormal];
        }
    }
    
    _btns_horizontalSepLineV.frame = CGRectMake(0, 0, self.width, 0.5);

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

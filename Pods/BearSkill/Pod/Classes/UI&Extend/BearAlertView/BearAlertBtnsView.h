//
//  BearAlertBtnsView.h
//  GOSHOPPING
//
//  Created by Bear on 16/6/26.
//  Copyright © 2016年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BearAlertBtnsView : UIView

@property (strong, nonatomic) UIView        *btns_horizontalSepLineV;
@property (strong, nonatomic) UIView        *btns_verticalSepLineV;
@property (strong, nonatomic) UIButton      *cancelBtn;
@property (strong, nonatomic) UIButton      *confirmBtn;

- (void)setNormal_CancelBtnTitle:(NSString *)cancelBtnTitle ConfirmBtnTitle:(NSString *)confirmBtnTitle;

@end

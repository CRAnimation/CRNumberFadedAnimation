//
//  CRFadedView.h
//  CRNumberFaded
//
//  Created by Bear on 17/3/22.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRFadedView : UIView

@property (strong, nonatomic) UILabel  *label;
@property (strong, nonatomic) NSNumber *needLabel;                  //Default @YES
@property (strong, nonatomic) NSNumber *fadeInRatio;                //淡入缩小比例
@property (strong, nonatomic) NSNumber *fadeOutRatio;               //淡出放大比例
@property (strong, nonatomic) NSNumber *animationDuration;          //动画时间
@property (strong, nonatomic) NSValue  *fadeOutOffSetPointValue;    //淡出Point偏移
@property (strong, nonatomic) NSValue  *fadeInOffSetPointValue;     //淡入Point偏移

- (void)loadParameterAndCreateUI;
- (void)fadeIn;
- (void)fadeOut;

- (void)relayUI;

@end

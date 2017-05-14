//
//  CRSliderIndicator.h
//  CRNumberFaded
//
//  Created by Bear on 2017/5/13.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRSliderIndicator : UIView

@property (assign, nonatomic) CGFloat   circleCenterX;              //Slider按钮的CenterX
@property (assign, nonatomic) CGFloat   r;                          //Slider按钮的半径
@property (assign, nonatomic) CGFloat   toCircleCenterYDistance;    //Slider按钮的垂直距离
@property (strong, nonatomic) NSArray   *gradientColors;            //背景渐变色数组
@property (assign, nonatomic) CGFloat   chipOffX;

- (instancetype)initWithFrame:(CGRect)frame withStrings:(NSArray *)strings;

@end

//
//  CRSliderIndicator.h
//  CRNumberFaded
//
//  Created by Bear on 2017/5/13.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRSliderIndicator : UIView

@property (assign, nonatomic) CGFloat   circleCenterX;
@property (assign, nonatomic) CGFloat   r;
@property (assign, nonatomic) CGFloat   toCircleCenterYDistance;
@property (strong, nonatomic) NSArray   *gradientColors;
@property (assign, nonatomic) CGFloat   chipOffX;

- (instancetype)initWithFrame:(CGRect)frame withStrings:(NSArray *)strings;

@end

//
//  CRSlider.h
//  CRNumberFaded
//
//  Created by Bear on 2017/5/12.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRSlider : UIView

@property(nonatomic) float value;                                 // default 0.0. this value will be pinned to min/max
@property(nonatomic) float minimumValue;                          // default 0.0. the current value may change if outside new min value
@property(nonatomic) float maximumValue;                          // default 1.0. the current value may change if outside new max value

@property(nonatomic) float poleImageVOffX;
@property (strong, nonatomic) UIImageView *poleImageV;
@property (strong, nonatomic) UIImageView *thumbImageV;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

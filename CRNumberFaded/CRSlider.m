//
//  CRSlider.m
//  CRNumberFaded
//
//  Created by Bear on 2017/5/12.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRSlider.h"

@interface CRSlider ()
{
    CGFloat _thumbImageVWidth;
}

@end

@implementation CRSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initPara];
        [self createUI];
    }
    
    return self;
}

- (void)initPara
{
    self.value = 0.0;
    self.minimumValue = 0.0;
    self.maximumValue = 0.0;
    self.poleImageVOffX = self.width * 0.1;
    _thumbImageVWidth = self.height < self.width ? self.height : self.width;
}

- (void)createUI
{
    _poleImageV = [[UIImageView alloc] initWithFrame:CGRectMake(_poleImageVOffX, 0, self.width - 2 * _poleImageVOffX, 1)];
    _poleImageV.backgroundColor = [UIColor grayColor];
    [self addSubview:_poleImageV];
    [_poleImageV BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    
    _thumbImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _thumbImageVWidth, _thumbImageVWidth)];
    _thumbImageV.layer.cornerRadius = _thumbImageVWidth / 2.0;
    _thumbImageV.layer.backgroundColor = [UIColor orangeColor].CGColor;
    [self addSubview:_thumbImageV];
    [_thumbImageV BearSetCenterToView:_poleImageV withAxis:kAXIS_Y];
    
    [self relayUI];
}

- (void)relayUI
{
    CGFloat ratio = 0;
    if (self.value == 0) {
        ratio = 0;
    }else{
        ratio = 1.0 * self.value / (self.maximumValue - self.minimumValue);
    }
    CGFloat thumbImageCenterX = ratio * _poleImageV.width;
    [_thumbImageV setCenterX:_poleImageV.x + thumbImageCenterX];
}

#pragma mark - Setter & Getter
- (void)setValue:(float)value
{
    _value = value;
}

@end

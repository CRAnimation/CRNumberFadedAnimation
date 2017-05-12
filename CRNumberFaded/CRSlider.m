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
    CGFloat _animationTotalDuring;
    CGFloat _animationMinDuring;
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
    self.maximumValue = 1.0;
    self.poleImageVOffX = self.width * 0.1;
    _thumbImageVWidth = self.height < self.width ? self.height : self.width;
    _animationTotalDuring = 1.0;
    _animationMinDuring = 0.2;
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
    
    _thumbImageV.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGREvent:)];
    [_thumbImageV addGestureRecognizer:panGR];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGREvent:)];
    [self addGestureRecognizer:tapGR];
    
    [self relayThumbImagV];
}

- (void)relayThumbImagV
{
    CGFloat thumbImageCenterX = [self caculateThumbImageVCenterXWithValue:self.value];
    [_thumbImageV setCenterX:thumbImageCenterX];
}

- (CGFloat)caculateRatioWithValue:(CGFloat)value
{
    CGFloat ratio = 0;
    if (value == 0) {
        ratio = 0;
    }else{
        ratio = 1.0 * value / (self.maximumValue - self.minimumValue);
    }
    
    return ratio;
}

- (CGFloat)caculateThumbImageVCenterXWithValue:(CGFloat)value
{
    CGFloat ratio = [self caculateRatioWithValue:value];
    CGFloat thumbImageCenterX = _poleImageV.x + ratio * _poleImageV.width;
    
    return thumbImageCenterX;
}

#pragma mark - Event
- (void)panGREvent:(UIPanGestureRecognizer *)GR
{
    CGPoint point = [GR locationInView:_poleImageV];
    [self caculateWithPoint:point];
    [self relayThumbImagV];
}

- (void)tapGREvent:(UITapGestureRecognizer *)GR
{
    __weak typeof(self) weakSelf = self;
    
    CGPoint point = [GR locationInView:_poleImageV];
    CGFloat oldValue = self.value;
    [self caculateWithPoint:point];
    
    CGFloat absDeltaValue = 0;
    if (self.value > oldValue) {
        absDeltaValue = self.value - oldValue;
    }else{
        absDeltaValue = oldValue - self.value;
    }
    CGFloat timeRatio = 1.0 * absDeltaValue / (self.maximumValue - self.minimumValue);
    CGFloat during = _animationTotalDuring * timeRatio;
    [UIView animateWithDuration:during < _animationMinDuring ? _animationMinDuring : during
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [weakSelf relayThumbImagV];
                     } completion:^(BOOL finished) {
                         nil;
                     }];
}

- (void)caculateWithPoint:(CGPoint)point
{
    if (point.x < 0) {
        point.x = 0;
    }
    if (point.x > _poleImageV.width) {
        point.x = _poleImageV.width;
    }
    
    if (point.x <= 0) {
        self.value = 0;
    }else{
        self.value = 1.0 * point.x / _poleImageV.width;
    }
    
    NSLog(@"point:%@", NSStringFromCGPoint(point));
}

#pragma mark - Setter & Getter
- (void)setValue:(float)value
{
    _value = value;
//    [self relayUI];
}

@end

//
//  CRSliderIndicator.m
//  CRNumberFaded
//
//  Created by Bear on 2017/5/13.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRSliderIndicator.h"
#import "CRSliderIndicatorChip.h"

@interface CRSliderIndicator ()
{
    UIBezierPath *_path;
    CAShapeLayer *_maskLayer;
    CAShapeLayer *_bgLayer;
    CAGradientLayer *_gradientLayer;
    CGPoint _circleCenter;
    CGFloat _y0;
    CRSliderIndicatorChip *lastNearestChipView;
    NSArray *_strings;
    
    NSMutableArray <CRSliderIndicatorChip *> *_chipViews;
}

@property (strong, nonatomic) CABasicAnimation *gradientAnimation;

@end

@implementation CRSliderIndicator

- (instancetype)initWithFrame:(CGRect)frame withStrings:(NSArray *)strings
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _strings = strings;
        [self initPara];
        [self createUI];
        self.circleCenterX = 0;
    }
    
    return self;
}

- (void)initPara
{
    _r = 20;
    _toCircleCenterYDistance = 0;
    _circleCenter = CGPointMake(_circleCenterX, self.height + _toCircleCenterYDistance);
    _y0 = _circleCenter.y - _toCircleCenterYDistance;
    
    [self generateChips];
}

- (void)generateChips
{
    _chipViews = [NSMutableArray new];
    
    for (int i = 0; i < [_strings count]; i++) {
        CRSliderIndicatorChip *chipView = [[CRSliderIndicatorChip alloc] initWithCommonFrame];
        chipView.string = [NSString stringWithFormat:@"%@", _strings[i]];
        [self addSubview:chipView];
        [_chipViews addObject:chipView];
    }
    
    self.chipOffX = _chipOffX;
}

- (void)createUI
{
    _path = [self generatePath];
    
    _bgLayer = [CAShapeLayer layer];
    _bgLayer.frame = self.bounds;
    _bgLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.layer insertSublayer:_bgLayer atIndex:0];
    
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.frame = self.bounds;
    _maskLayer.path = _path.CGPath;
    _maskLayer.fillColor = [UIColor blueColor].CGColor;
    _maskLayer.masksToBounds = YES;
    [self.layer insertSublayer:_maskLayer atIndex:1];
    
    self.backgroundColor = [UIColor clearColor];
    
    [self createGradientLayer];
}

- (void)createGradientLayer
{
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.colors = @[(__bridge id)UIColorFromHEX(0xFF873E).CGColor,
                              (__bridge id)UIColorFromHEX(0xFF734D).CGColor,
                              (__bridge id)UIColorFromHEX(0xFF6461).CGColor
                             ];
    _gradientLayer.startPoint = CGPointMake(1, 0);
    _gradientLayer.endPoint = CGPointMake(0, 1);
    _gradientLayer.frame = _bgLayer.bounds;
    [_bgLayer addSublayer:_gradientLayer];
}

#pragma mark - generatePath

#define ratioValueX(value) (value * ratioX)
#define ratioValueY(value) (value * ratioY)

- (UIBezierPath *)generatePath
{
    CGPoint leftUp = CGPointMake(0, 0);
    CGPoint leftDown = CGPointMake(0, self.height);
    CGPoint rightDown = CGPointMake(self.width, self.height);
    CGPoint rightUp = CGPointMake(self.width, 0);
    
    CGFloat ratioX = 1.0 * _r / 20;
    CGFloat ratioY = 1.0;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:leftDown];
    
    {
        //curve
        CGPoint p1 = CGPointMake(_circleCenter.x - ratioValueX(48), self.height);
        
        CGPoint p2 = CGPointMake(_circleCenter.x - ratioValueX(33), _y0 - ratioValueY(5));
        CGPoint p2CL = CGPointMake(_circleCenter.x - ratioValueX(40), _y0);
        CGPoint p2CR = CGPointMake(_circleCenter.x - ratioValueX(25), _y0 - ratioValueY(10));
        
        CGPoint p3 = CGPointMake(_circleCenter.x, _y0 - ratioValueY(23));
        CGPoint p3CL = CGPointMake(_circleCenter.x - ratioValueX(14), _y0 - ratioValueY(23));
        CGPoint p3CR = CGPointMake(_circleCenter.x + ratioValueX(14), _y0 - ratioValueY(23));
        
        CGPoint p4 = CGPointMake(_circleCenter.x + ratioValueX(33), _y0 - ratioValueY(5));
        CGPoint p4CL = CGPointMake(_circleCenter.x + ratioValueX(25), _y0 - ratioValueY(10));
        CGPoint p4CR = CGPointMake(_circleCenter.x + ratioValueX(40), _y0);
        
        CGPoint p5 = CGPointMake(_circleCenter.x + ratioValueX(48), self.height);
        
        [path addLineToPoint:p1];
        [path addCurveToPoint:p2 controlPoint1:p1 controlPoint2:p2CL];
        [path addCurveToPoint:p3 controlPoint1:p2CR controlPoint2:p3CL];
        [path addCurveToPoint:p4 controlPoint1:p3CR controlPoint2:p4CL];
        [path addCurveToPoint:p5 controlPoint1:p4CR controlPoint2:p5];
        
//        [self clean];
//        [self drawTestPoint:p1];
//
//        [self drawTestPoint:p2];
//        [self drawTestPoint:p2CL];
//        [self drawTestPoint:p2CR];
//
//        [self drawTestPoint:p3];
//        [self drawTestPoint:p3CL];
//        [self drawTestPoint:p3CR];
//
//        [self drawTestPoint:p4];
//        [self drawTestPoint:p4CL];
//        [self drawTestPoint:p4CR];
//
//        [self drawTestPoint:p5];
    }
    
    [path addLineToPoint:rightDown];
    [path addLineToPoint:rightUp];
    [path addLineToPoint:leftUp];
    [path closePath];
    
    return path;
}

#pragma mark - Test Point
- (void)clean
{
    for (UIView *point in self.subviews) {
        [point removeFromSuperview];
    }
}
- (void)drawTestPoint:(CGPoint)point
{
    UIView *pointV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 7)];
    pointV.layer.cornerRadius = pointV.width / 2.0;
    pointV.backgroundColor = [UIColor redColor];
    pointV.center = point;
    [self addSubview:pointV];
}

#pragma mark - RelayUI
- (void)relayUI
{
    _path = [self generatePath];
    _maskLayer.path = _path.CGPath;
    [self findNearstChipViewAndScale];
}

#pragma mark - Get Nearest Chip View
- (void)findNearstChipViewAndScale
{
    CRSliderIndicatorChip *nearestChipView = [self getChipViewWithCircleCenterX:_circleCenter.x];
    if (lastNearestChipView && lastNearestChipView == nearestChipView) {
        nil;
    }else{
        for (CRSliderIndicatorChip *chipView in _chipViews) {
            if (chipView == nearestChipView) {
                chipView.status = CRSliderIndicatorChipStatusScale;
            }else{
                chipView.status = CRSliderIndicatorChipStatusNormal;
            }
        }
        lastNearestChipView = nearestChipView;
    }
}

- (CRSliderIndicatorChip *)getChipViewWithCircleCenterX:(CGFloat)centerX
{
    NSNumber *minValue;
    CRSliderIndicatorChip *nearestChipView;
    for (CRSliderIndicatorChip *chipView in _chipViews) {
        CGFloat resultValue = [self absValue1:chipView.centerX value2:centerX];
        if (!minValue) {
            minValue = [NSNumber numberWithFloat:resultValue];
        }
        
        if (!nearestChipView) {
            nearestChipView = chipView;
        }
        
        if (resultValue < [minValue floatValue]) {
            minValue = [NSNumber numberWithFloat:resultValue];
            nearestChipView = chipView;
        }
    }
    
    return nearestChipView;
}

- (CGFloat)absValue1:(CGFloat)value1 value2:(CGFloat)value2
{
    CGFloat resultValue = 0;
    if (value1 > value2) {
        resultValue = value1 - value2;
    }else{
        resultValue = value2 - value1;
    }
    
    return resultValue;
}

#pragma mark - Setter & Getter
- (void)setCircleCenterX:(CGFloat)circleCenterX
{
    _circleCenterX = circleCenterX;
    
    _circleCenter.x = _circleCenterX;
    [self relayUI];
    _bgLayer.mask = _maskLayer;
}

- (void)setGradientColors:(NSArray *)gradientColors
{
    if (!gradientColors) {
        return;
    }
    
    _gradientColors = gradientColors;
    
    id fromValue = self.gradientAnimation.toValue;
    CAGradientLayer *presentGradientLayer = _gradientLayer.presentationLayer;
    if (presentGradientLayer) {
        fromValue = presentGradientLayer.colors;
    }
    
    self.gradientAnimation.fromValue = fromValue;
    self.gradientAnimation.toValue = _gradientColors;
    [_gradientLayer addAnimation:self.gradientAnimation forKey:self.gradientAnimation.keyPath];
}

- (void)setChipOffX:(CGFloat)chipOffX
{
    _chipOffX = chipOffX;
    
    if ([_chipViews count] > 0) {
        CRSliderIndicatorChip *chipView = _chipViews[0];
        CGFloat offX = _chipOffX - chipView.width / 2.0;
        [UIView BearV2AutoLayViewArray:_chipViews layoutAxis:kLAYOUT_AXIS_X alignmentType:kSetAlignmentType_End alignmentOffDis:0 offStart:offX offEnd:offX];
    }
}

- (CABasicAnimation *)gradientAnimation
{
    if (!_gradientAnimation) {
        _gradientAnimation = [CABasicAnimation animationWithKeyPath:@"colors"];
        _gradientAnimation.removedOnCompletion = NO;
        _gradientAnimation.fillMode = kCAFillModeForwards;
        _gradientAnimation.duration = 0.7;
    }
    
    return _gradientAnimation;
}

@end

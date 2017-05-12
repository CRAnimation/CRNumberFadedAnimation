//
//  CRSliderIndicator.m
//  CRNumberFaded
//
//  Created by Bear on 2017/5/13.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRSliderIndicator.h"

@interface CRSliderIndicator ()
{
    UIBezierPath *_path;
    CAShapeLayer *_bgLayer;
}

@end

@implementation CRSliderIndicator

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    CGPoint leftUp = CGPointMake(0, 0);
    CGPoint leftDown = CGPointMake(0, self.height);
    CGPoint rightDown = CGPointMake(self.width, self.height);
    CGPoint rightUp = CGPointMake(self.width, 0);
    
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:leftDown];
//    [_path ]
    [_path addLineToPoint:rightDown];
    [_path addLineToPoint:rightUp];
    [_path addLineToPoint:leftUp];
    [_path closePath];
    
    _bgLayer = [CAShapeLayer layer];
    _bgLayer.path = _path.CGPath;
    _bgLayer.fillColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:_bgLayer];
}

- (void)testPath
{
    //// Path Drawing
    UIBezierPath* pathPath = UIBezierPath.bezierPath;
    [pathPath moveToPoint: CGPointMake(0.36, 113.38)];
    [pathPath addLineToPoint: CGPointMake(107.52, 113.64)];
    [pathPath addCurveToPoint: CGPointMake(129.43, 108.4) controlPoint1: CGPointMake(107.52, 113.64) controlPoint2: CGPointMake(117.52, 115.76)];
    [pathPath addCurveToPoint: CGPointMake(221.58, 40.71) controlPoint1: CGPointMake(141.34, 101.03) controlPoint2: CGPointMake(161.97, 40.71)];
    [pathPath addCurveToPoint: CGPointMake(310.15, 105.52) controlPoint1: CGPointMake(281.19, 40.71) controlPoint2: CGPointMake(300.25, 95.99)];
    [pathPath addCurveToPoint: CGPointMake(327.98, 113.64) controlPoint1: CGPointMake(320.04, 115.04) controlPoint2: CGPointMake(327.98, 113.64)];
    [pathPath addLineToPoint: CGPointMake(448.01, 113.39)];
}

@end

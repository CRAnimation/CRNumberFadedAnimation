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
    CGFloat _toCircleCenterYDistance;
    CGPoint _circleCenter;
    CGFloat _y0;
    CGFloat _r;
}

@end

@implementation CRSliderIndicator

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initPara];
        [self createUI];
        
//        [self testBezierPath];
    }
    
    return self;
}

- (void)initPara
{
#warning DAD Test
    _circleCenterX = 200;
    
    _r = 134 / 2.0;
    _toCircleCenterYDistance = 18;
    _circleCenter = CGPointMake(_circleCenterX, self.height + _toCircleCenterYDistance);
    _y0 = _circleCenter.y - _toCircleCenterYDistance;
}

- (void)createUI
{
    _path = [self generatePath];
    
    _bgLayer = [CAShapeLayer layer];
    _bgLayer.path = _path.CGPath;
    _bgLayer.fillColor = [UIColor blueColor].CGColor;
    [self.layer insertSublayer:_bgLayer atIndex:0];
    
    self.backgroundColor = [UIColor brownColor];
}

- (void)testBezierPath
{
    CGPoint leftUp = CGPointMake(0, 0);
    CGPoint leftDown = CGPointMake(0, self.height);
    CGPoint rightDown = CGPointMake(self.width, self.height);
    CGPoint rightUp = CGPointMake(self.width, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:leftDown];
    
    {
        //curve
        CGPoint p1 = CGPointMake(_circleCenter.x - (_r+45), _y0);
        
        CGPoint p2 = CGPointMake(_circleCenter.x - (_r+17), _y0 - 8);
        CGPoint p2CL = CGPointMake(_circleCenter.x - (_r+30), _y0);
        CGPoint p2CR = CGPointMake(_circleCenter.x - (_r+2), _y0 - 18);
        
        CGPoint p3 = CGPointMake(_circleCenter.x, _y0 - 56);
        CGPoint p3CL = CGPointMake(_circleCenter.x - 48, _y0 - 56);
        CGPoint p3CR = CGPointMake(_circleCenter.x + 48, _y0 - 56);
        
        CGPoint p4 = CGPointMake(_circleCenter.x + (_r+17), _y0 - 8);
        CGPoint p4CL = CGPointMake(_circleCenter.x + (_r+2), _y0 - 18);
        CGPoint p4CR = CGPointMake(_circleCenter.x + (_r+30), _y0);
        
        CGPoint p5 = CGPointMake(_circleCenter.x + (_r+45), _y0);
        
        [path addLineToPoint:p1];
        [path addCurveToPoint:p2 controlPoint1:p1 controlPoint2:p2CL];
        [path addCurveToPoint:p3 controlPoint1:p2CR controlPoint2:p3CL];
        [path addCurveToPoint:p4 controlPoint1:p3CR controlPoint2:p4CL];
        [path addCurveToPoint:p5 controlPoint1:p4CR controlPoint2:p5];
        
//        [self clean];
//        [self drawTestPoint:p1];
//        
//        [self drawTestPoint:p2];
//        [self drawTestPoint:p2C1];
//        [self drawTestPoint:p2C2];
//        
//        [self drawTestPoint:p3];
//        [self drawTestPoint:p3C1];
//        [self drawTestPoint:p3C2];
//        
//        [self drawTestPoint:p4];
//        [self drawTestPoint:p4C1];
//        [self drawTestPoint:p4C2];
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.borderColor = [UIColor blackColor].CGColor;
    layer.borderWidth = 2.0;
    layer.strokeColor = [UIColor greenColor].CGColor;
    [self.layer insertSublayer:layer atIndex:0];

    
    //        [self drawTestPoint:p5];
    
    
//    [path addLineToPoint:rightDown];
//    [path addLineToPoint:rightUp];
//    [path addLineToPoint:leftUp];
//    [path closePath];
    
//    return path;
}

- (UIBezierPath *)generatePath
{
    CGPoint leftUp = CGPointMake(0, 0);
    CGPoint leftDown = CGPointMake(0, self.height);
    CGPoint rightDown = CGPointMake(self.width, self.height);
    CGPoint rightUp = CGPointMake(self.width, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:leftDown];
    
    {
        //curve
        CGPoint p1 = CGPointMake(_circleCenter.x - (_r+45), _y0);
        
        CGPoint p2 = CGPointMake(_circleCenter.x - (_r+17), _y0 - 8);
        CGPoint p2CL = CGPointMake(_circleCenter.x - (_r+30), _y0);
        CGPoint p2CR = CGPointMake(_circleCenter.x - (_r+2), _y0 - 18);
        
        CGPoint p3 = CGPointMake(_circleCenter.x, _y0 - 56);
        CGPoint p3CL = CGPointMake(_circleCenter.x - 48, _y0 - 56);
        CGPoint p3CR = CGPointMake(_circleCenter.x + 48, _y0 - 56);
        
        CGPoint p4 = CGPointMake(_circleCenter.x + (_r+17), _y0 - 8);
        CGPoint p4CL = CGPointMake(_circleCenter.x + (_r+2), _y0 - 18);
        CGPoint p4CR = CGPointMake(_circleCenter.x + (_r+30), _y0);
        
        CGPoint p5 = CGPointMake(_circleCenter.x + (_r+45), _y0);
        
        [path addLineToPoint:p1];
        [path addCurveToPoint:p2 controlPoint1:p1 controlPoint2:p2CL];
        [path addCurveToPoint:p3 controlPoint1:p2CR controlPoint2:p3CL];
        [path addCurveToPoint:p4 controlPoint1:p3CR controlPoint2:p4CL];
        [path addCurveToPoint:p5 controlPoint1:p4CR controlPoint2:p5];
        
//        [self clean];
//        [self drawTestPoint:p1];
//        
//        [self drawTestPoint:p2];
//        [self drawTestPoint:p2C1];
//        [self drawTestPoint:p2C2];
//        
//        [self drawTestPoint:p3];
//        [self drawTestPoint:p3C1];
//        [self drawTestPoint:p3C2];
//        
//        [self drawTestPoint:p4];
//        [self drawTestPoint:p4C1];
//        [self drawTestPoint:p4C2];
//        
//        [self drawTestPoint:p5];
    }
    
    [path addLineToPoint:rightDown];
    [path addLineToPoint:rightUp];
    [path addLineToPoint:leftUp];
    [path closePath];
    
    return path;
}

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

- (void)relayUI
{
    _path = [self generatePath];
    _bgLayer.path = _path.CGPath;
}

#pragma mark - Setter & Getter
- (void)setCircleCenterX:(CGFloat)circleCenterX
{
    _circleCenterX = circleCenterX;
    
    _circleCenter.x = _circleCenterX;
    [self relayUI];
}

@end

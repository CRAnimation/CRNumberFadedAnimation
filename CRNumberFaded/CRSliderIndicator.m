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
    CGPoint _circleCenter;
    CGFloat _y0;
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
    
    CGFloat ratio = 1.0 * _r / 67;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:leftDown];
    
    {
        //curve
        CGPoint p1 = CGPointMake(_circleCenter.x - (_r+45)*ratio, _y0);
        
        CGPoint p2 = CGPointMake(_circleCenter.x - (_r+17)*ratio, _y0 - 8*ratio);
        CGPoint p2CL = CGPointMake(_circleCenter.x - (_r+30)*ratio, _y0);
        CGPoint p2CR = CGPointMake(_circleCenter.x - (_r+2)*ratio, _y0 - 18*ratio);
        
        CGPoint p3 = CGPointMake(_circleCenter.x*ratio, _y0 - 56*ratio);
        CGPoint p3CL = CGPointMake(_circleCenter.x - 48*ratio, _y0 - 56*ratio);
        CGPoint p3CR = CGPointMake(_circleCenter.x + 48*ratio, _y0 - 56*ratio);
        
        CGPoint p4 = CGPointMake(_circleCenter.x + (_r+17)*ratio, _y0 - 8*ratio);
        CGPoint p4CL = CGPointMake(_circleCenter.x + (_r+2)*ratio, _y0 - 18*ratio);
        CGPoint p4CR = CGPointMake(_circleCenter.x + (_r+30)*ratio, _y0);
        
        CGPoint p5 = CGPointMake(_circleCenter.x + (_r+45)*ratio, _y0*ratio);
        
        [path addLineToPoint:p1];
        [path addCurveToPoint:p2 controlPoint1:p1 controlPoint2:p2CL];
        [path addCurveToPoint:p3 controlPoint1:p2CR controlPoint2:p3CL];
        [path addCurveToPoint:p4 controlPoint1:p3CR controlPoint2:p4CL];
        [path addCurveToPoint:p5 controlPoint1:p4CR controlPoint2:p5];
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.borderColor = [UIColor blackColor].CGColor;
    layer.borderWidth = 2.0;
    layer.strokeColor = [UIColor greenColor].CGColor;
    [self.layer insertSublayer:layer atIndex:0];
}

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

- (UIBezierPath *)generatePathOld
{
    CGPoint leftUp = CGPointMake(0, 0);
    CGPoint leftDown = CGPointMake(0, self.height);
    CGPoint rightDown = CGPointMake(self.width, self.height);
    CGPoint rightUp = CGPointMake(self.width, 0);
    
    CGFloat ratioX = 1.0 * _r / 67;
    CGFloat ratioY = 1.0 * (_r - _toCircleCenterYDistance) / 49;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:leftDown];
    
    {
        //curve
        CGPoint p1 = CGPointMake(_circleCenter.x - (_r+ratioValueX(45)), self.height);
        
        CGPoint p2 = CGPointMake(_circleCenter.x - (_r+ratioValueX(17)), _y0 - ratioValueY(8));
        CGPoint p2CL = CGPointMake(_circleCenter.x - (_r+ratioValueX(30)), _y0);
        CGPoint p2CR = CGPointMake(_circleCenter.x - (_r+ratioValueX(2)), _y0 - ratioValueY(18));
        
        CGPoint p3 = CGPointMake(_circleCenter.x, _y0 - ratioValueY(56));
        CGPoint p3CL = CGPointMake(_circleCenter.x - ratioValueX(48), _y0 - ratioValueY(56));
        CGPoint p3CR = CGPointMake(_circleCenter.x + ratioValueX(48), _y0 - ratioValueY(56));
        
        CGPoint p4 = CGPointMake(_circleCenter.x + (_r+ratioValueX(17)), _y0 - ratioValueY(8));
        CGPoint p4CL = CGPointMake(_circleCenter.x + (_r+ratioValueX(2)), _y0 - ratioValueY(18));
        CGPoint p4CR = CGPointMake(_circleCenter.x + (_r+ratioValueX(30)), _y0);
        
        CGPoint p5 = CGPointMake(_circleCenter.x + (_r+ratioValueX(45)), self.height);
        
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

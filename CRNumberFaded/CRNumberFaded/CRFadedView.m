//
//  CRFadedView.m
//  CRNumberFaded
//
//  Created by Bear on 17/3/22.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRFadedView.h"

@interface CRFadedView () <CAAnimationDelegate>

@property (strong, nonatomic) CABasicAnimation *scaleAnimation;     //考虑删除
@property (strong, nonatomic) CABasicAnimation *positionAnimation;  //考虑删除
@property (strong, nonatomic) CABasicAnimation *opacityAnimation;   //考虑删除

@property (strong, nonatomic) CAAnimationGroup *animationGroup;

@property (strong, nonatomic)CAKeyframeAnimation *opacityKeyFrameAnimation;
@property (strong, nonatomic)CAKeyframeAnimation *scaleKeyFrameAnimation;
@property (strong, nonatomic)CAKeyframeAnimation *positionKeyFrameAnimation;

@end

@implementation CRFadedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initDefaultParameter];
        [self loadParameterAndCreateUI];
    }
    
    return self;
}

- (void)initDefaultParameter
{
    self.needLabel = @YES;
    self.fadeInRatio = @0.3;
    self.fadeOutRatio = @2;
    self.animationDuration = @0.3;
    self.fadeOutOffSetPointValue = [NSValue valueWithCGPoint:CGPointMake(self.centerX - 100, self.centerY)];
    self.fadeInOffSetPointValue = [NSValue valueWithCGPoint:CGPointMake(self.centerX + 100, self.centerY)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}



#pragma mark - CreateUI
- (void)loadParameterAndCreateUI
{
    [self createUI];
    [self relayUI];
}

- (void)createUI
{
    if ([self.needLabel boolValue]) {
        [self addSubview:self.label];
    }else{
        [self.label removeFromSuperview];
    }
}

- (void)relayUI
{
    [_label sizeToFit];
    [_label BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
}

#pragma mark - Method
- (void)fadedViewAnimationWithType:(CRFadedViewAnimationType)animationType
{
    switch (animationType) {
        case CRFadedViewAnimationType_SmallToNormal:
        {
            self.scaleAnimation.fromValue = self.fadeInRatio;
            self.scaleAnimation.toValue = @1.0;
            
            self.positionAnimation.fromValue = self.fadeInOffSetPointValue;
            self.positionAnimation.toValue = [NSValue valueWithCGPoint:self.center];
            
            self.opacityAnimation.fromValue = @0;
            self.opacityAnimation.toValue = @1;
        }
            break;
            
        case CRFadedViewAnimationType_NormalToSmall:
        {
            self.scaleAnimation.fromValue = @1.0;
            self.scaleAnimation.toValue = self.fadeInRatio;
            
            self.positionAnimation.fromValue = [NSValue valueWithCGPoint:self.center];
            self.positionAnimation.toValue = self.fadeInOffSetPointValue;
            
            self.opacityAnimation.fromValue = @1;
            self.opacityAnimation.toValue = @0;
        }
            break;
            
        case CRFadedViewAnimationType_BigToNormal:
        {
            self.scaleAnimation.fromValue = self.fadeOutRatio;
            self.scaleAnimation.toValue = @1.0;
         
            self.positionAnimation.fromValue = self.fadeOutOffSetPointValue;
            self.positionAnimation.toValue = [NSValue valueWithCGPoint:self.center];
            
            self.opacityAnimation.fromValue = @0;
            self.opacityAnimation.toValue = @1;
        }
            break;
            
        case CRFadedViewAnimationType_NormalToBig:
        {
            self.scaleAnimation.fromValue = @1.0;
            self.scaleAnimation.toValue = self.fadeOutRatio;
            
            self.positionAnimation.fromValue = [NSValue valueWithCGPoint:self.center];
            self.positionAnimation.toValue = self.fadeOutOffSetPointValue;
            
            self.opacityAnimation.fromValue = @1;
            self.opacityAnimation.toValue = @0;
        }
            break;
            
        default:
            break;
    }
    
    CAAnimationGroup *_animationGroup1 = [CAAnimationGroup animation];
    _animationGroup1.fillMode = kCAFillModeForwards;
    _animationGroup1.removedOnCompletion = NO;
    _animationGroup1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    _animationGroup1.delegate = self;
    
    _animationGroup1.animations = @[self.scaleAnimation, self.positionAnimation, self.opacityAnimation];
    for (CABasicAnimation *basicAniamtion in _animationGroup1.animations) {
        basicAniamtion.duration = [self.animationDuration floatValue];
    }
    _animationGroup1.duration = [self.animationDuration floatValue];
    [self.layer addAnimation:_animationGroup1 forKey:nil];
}

- (void)testFadeLinear
{
    //  scaleKeyFrameAnimation
    self.scaleKeyFrameAnimation.values = @[self.fadeInRatio,
                                           @1.0,
                                           self.fadeOutRatio
                                           ];
    self.scaleKeyFrameAnimation.timingFunctions = @[
                                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                                    ];
    
    //  positionKeyFrameAnimation
    self.positionKeyFrameAnimation.values = @[self.fadeInOffSetPointValue,
                                              [NSValue valueWithCGPoint:self.center],
                                              self.fadeOutOffSetPointValue,
                                              ];
    self.positionKeyFrameAnimation.timingFunctions = @[
                                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                                       ];
    
    //  opacityKeyFrameAnimation
    self.opacityKeyFrameAnimation.values = @[@0, @1, @0];
    self.opacityKeyFrameAnimation.timingFunctions = @[
                                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                                      ];
    
    //  animationGroup
    self.animationGroup.animations = @[
                                       self.scaleKeyFrameAnimation,
                                       self.positionKeyFrameAnimation,
                                       self.opacityKeyFrameAnimation,
                                       ];
    self.animationGroup.duration = [self.animationDuration floatValue];
    [self.layer addAnimation:self.animationGroup forKey:nil];
    
    
}

#pragma mark - Setter & Getter
- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
        _label.font = SystemFont(20);
    }
    
    return _label;
}

- (CABasicAnimation *)scaleAnimation
{
    if (!_scaleAnimation) {
        _scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        _scaleAnimation.fromValue = @1.0;
        _scaleAnimation.toValue = @1.0;
        _scaleAnimation.fillMode = kCAFillModeForwards;
        _scaleAnimation.removedOnCompletion = NO;
        _scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    }
    
    return _scaleAnimation;
}

- (CABasicAnimation *)positionAnimation
{
    if (!_positionAnimation) {
        _positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        _positionAnimation.fillMode = kCAFillModeForwards;
        _positionAnimation.removedOnCompletion = NO;
        _positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    }
    
    return _positionAnimation;
}

- (CABasicAnimation *)opacityAnimation
{
    if (!_opacityAnimation) {
        _opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _opacityAnimation.fillMode = kCAFillModeForwards;
        _opacityAnimation.removedOnCompletion = NO;
        _opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    }
    
    return _opacityAnimation;
}

- (CAAnimationGroup *)animationGroup
{
    if (!_animationGroup) {
        _animationGroup = [CAAnimationGroup animation];
        _animationGroup.fillMode = kCAFillModeForwards;
        _animationGroup.removedOnCompletion = NO;
        _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        _animationGroup.delegate = self;
    }
    
    return _animationGroup;
}

- (CAKeyframeAnimation *)opacityKeyFrameAnimation
{
    if (!_opacityKeyFrameAnimation) {
        _opacityKeyFrameAnimation = [CAKeyframeAnimation animation];
        _opacityKeyFrameAnimation.keyPath = @"opacity";
        _opacityKeyFrameAnimation.fillMode = kCAFillModeForwards;
        _opacityKeyFrameAnimation.removedOnCompletion = NO;
    }
    
    return _opacityKeyFrameAnimation;
}

- (CAKeyframeAnimation *)scaleKeyFrameAnimation
{
    if (!_scaleKeyFrameAnimation) {
        _scaleKeyFrameAnimation = [CAKeyframeAnimation animation];
        _scaleKeyFrameAnimation.keyPath = @"transform.scale";
        _scaleKeyFrameAnimation.fillMode = kCAFillModeForwards;
        _scaleKeyFrameAnimation.removedOnCompletion = NO;
    }
    
    return _scaleKeyFrameAnimation;
}

- (CAKeyframeAnimation *)positionKeyFrameAnimation
{
    if (!_positionKeyFrameAnimation) {
        _positionKeyFrameAnimation = [CAKeyframeAnimation animation];
        _positionKeyFrameAnimation.keyPath = @"position";
        _positionKeyFrameAnimation.fillMode = kCAFillModeForwards;
        _positionKeyFrameAnimation.removedOnCompletion = NO;
    }
    
    return _positionKeyFrameAnimation;
}

- (NSValue *)fadeOutOffSetPointValue
{
    if (!_fadeOutOffSetPointValue) {
        _fadeOutOffSetPointValue = [NSValue valueWithCGPoint:CGPointMake(self.centerX - 20, self.centerY)];
    }
    
    return _fadeOutOffSetPointValue;
}

- (NSValue *)fadeInOffSetPointValue
{
    if (!_fadeInOffSetPointValue) {
        _fadeInOffSetPointValue = [NSValue valueWithCGPoint:CGPointMake(self.centerX + 20, self.centerY)];
    }
    
    return _fadeInOffSetPointValue;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([_delegate respondsToSelector:@selector(animationDidFinishedInFadedView:)]) {
        [_delegate animationDidFinishedInFadedView:self];
    }
}

@end

//
//  CRSliderIndicatorChip.m
//  CRNumberFaded
//
//  Created by Bear on 2017/5/13.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRSliderIndicatorChip.h"

@interface CRSliderIndicatorChip ()
{
    UILabel *_label;
    UIView *_lineV;
    CGFloat _duration;
}

@property (strong, nonatomic) CABasicAnimation *scaleAnimation;

@end

@implementation CRSliderIndicatorChip

- (instancetype)initWithCommonFrame
{
    self = [super initWithFrame:CGRectMake(0, 0, 40, 80)];
    
    if (self) {
        _duration = 0.25;
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    _label = [UILabel new];
    _label.textColor = [UIColor whiteColor];
    [self addSubview:_label];
    
    _lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 8)];
    _lineV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_lineV];
}

#pragma mark - RelayUI
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self relayUI];
}

- (void)relayUI
{
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_label sizeToFit];
        
        switch (_status) {
            case CRSliderIndicatorChipStatusIdle:
            {
                [_lineV BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:nil parentRelation:YES distance:20 center:YES];
                [_label BearSetRelativeLayoutWithDirection:kDIR_UP destinationView:_lineV parentRelation:NO distance:25 center:YES];
            }
                break;
                
            case CRSliderIndicatorChipStatusNormal:
            {
                [UIView animateWithDuration:_duration animations:^{
                    [_lineV BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:nil parentRelation:YES distance:20 center:YES];
                    [_label BearSetRelativeLayoutWithDirection:kDIR_UP destinationView:_lineV parentRelation:NO distance:25 center:YES];
                    
                    weakSelf.scaleAnimation.toValue = @1.0;
                    [_label.layer addAnimation:weakSelf.scaleAnimation forKey:_scaleAnimation.keyPath];
                }];
            }
                break;
                
            case CRSliderIndicatorChipStatusScale:
            {
                [UIView animateWithDuration:_duration animations:^{
                    [_lineV BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:nil parentRelation:YES distance:35 center:YES];
                    [_label BearSetRelativeLayoutWithDirection:kDIR_UP destinationView:_lineV parentRelation:NO distance:20 center:YES];
                    
                    weakSelf.scaleAnimation.toValue = @1.5;
                    [_label.layer addAnimation:weakSelf.scaleAnimation forKey:_scaleAnimation.keyPath];
                }];
            }
                break;
                
            default:
                break;
        }
    });
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

#pragma mark - Setter & Getter
- (void)setStatus:(CRSliderIndicatorChipStatus)status
{
    if (status == _status) {
        return;
    }
    
    _status = status;
    
    [self relayUI];
}

- (void)setString:(NSString *)string
{
    _string = string;
    
    _label.text = string;
}

@end

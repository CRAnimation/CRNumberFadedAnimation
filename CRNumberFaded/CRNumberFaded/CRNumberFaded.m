//
//  CRNumberFaded.m
//  CRNumberFaded
//
//  Created by Bear on 17/3/22.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRNumberFaded.h"
#import "CRFadedView.h"

typedef NS_ENUM(NSUInteger, CRFadeViewIndexType) {
    CRFadeViewIndexType_Last,
    CRFadeViewIndexType_Now,
    CRFadeViewIndexType_Next,
};

typedef NS_ENUM(NSUInteger, CRFadeViewDirType) {
    CRFadeViewDirType_Null,
    CRFadeViewDirType_Last,
    CRFadeViewDirType_Next,
};

struct CurrentLoopPara {
    int start;
    int end;
    int count;
};

@interface CRNumberFaded () <CRFadedViewDelegate>
{
    NSMutableArray  *_fadedViews;
    int             _toIndex;
    NSMutableArray  *_duringArray;
    
    NSNumber *_startUnSkipCount;  //开头几个不允许跳过
    NSNumber *_endUnSkipCount;    //末尾几个不允许跳过
    NSNumber *_middleShowAllCount;//中间跳过后允许显示的总数量
    NSMutableArray  *_unSkipArray;
    BOOL _animating;//是否正在执行动画
    
    struct CurrentLoopPara  _currentLoopPara;
    int                     _easyInEasyOutFadeCount;
}

@property (assign, nonatomic) int currentIndex;

@end

@implementation CRNumberFaded

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initSetPara];
        [self createUI];
        [self generateDuringArray];
    }
    
    return self;
}

- (void)initSetPara
{
    _currentIndex = 0;
    self.allowCircle = YES;
    
    _startUnSkipCount = @5;
    _endUnSkipCount = @5;
    _middleShowAllCount = @10;
    _unSkipArray = [NSMutableArray new];
    _easyInEasyOutFadeCount = 2;
    _animating = NO;
    _font = [UIFont systemFontOfSize:17];
    _textColor = [UIColor blackColor];
}

- (void)createUI
{
    
}

- (void)generateFadedViews
{
    if (_fadedViews) {
        for (CRFadedView *fadedView in _fadedViews) {
            [fadedView removeFromSuperview];
        }
    }else{
        _fadedViews = [NSMutableArray new];
    }
    
    int actualDafedViewsTotal = 3;
    for (int i = 0; i < actualDafedViewsTotal; i++) {
        CRFadedView *fadedView = [[CRFadedView alloc] initWithFrame:self.bounds];
        [self addSubview:fadedView];
        [_fadedViews addObject:fadedView];
    }
    
    CRFadedView *fadedViewLast  = [self getFadedViewWithIndexType:CRFadeViewIndexType_Last];
    CRFadedView *fadedViewNow   = [self getFadedViewWithIndexType:CRFadeViewIndexType_Now];
    CRFadedView *fadedViewNext  = [self getFadedViewWithIndexType:CRFadeViewIndexType_Next];
    
    fadedViewLast.layer.opacity = 0;
    fadedViewLast.label.text = _strings[[self caculateIndex:_currentIndex - 1]];
    fadedViewLast.label.font = _font;
    fadedViewLast.label.textColor = _textColor;
    [fadedViewLast relayUI];
    
    fadedViewNow.layer.opacity = 1;
    fadedViewNow.label.text = _strings[[self caculateIndex:_currentIndex]];
    fadedViewNow.label.font = _font;
    fadedViewNow.label.textColor = _textColor;
    [fadedViewNow relayUI];
    
    fadedViewNext.layer.opacity = 0;
    fadedViewNext.label.text = _strings[[self caculateIndex:_currentIndex + 1]];
    fadedViewNext.label.font = _font;
    fadedViewNext.label.textColor = _textColor;
    [fadedViewNext relayUI];
}

- (void)showNextView
{
    [self showNextViewWithDuratin:nil];
}

- (void)showNextViewWithDuratin:(NSNumber *)duration
{
    if (!duration) {
        duration = @0.6;
    }
    
    CRFadedView *fadedViewLast  = [self getFadedViewWithIndexType:CRFadeViewIndexType_Last];
    CRFadedView *fadedViewNow   = [self getFadedViewWithIndexType:CRFadeViewIndexType_Now];
    CRFadedView *fadedViewNext  = [self getFadedViewWithIndexType:CRFadeViewIndexType_Next];
    
    fadedViewLast.animationDuration = duration;
    fadedViewLast.layer.opacity = 0;
    
    fadedViewNow.animationDuration = duration;
    fadedViewNow.layer.opacity = 0;
    
    fadedViewNext.animationDuration = duration;
    fadedViewNext.layer.opacity = 0;
    
    fadedViewLast.label.text = _strings[[self caculateIndex:self.currentIndex - 1]];
    
    fadedViewNow.label.text = _strings[[self caculateIndex:self.currentIndex]];
    [fadedViewNow fadedViewAnimationWithType:CRFadedViewAnimationType_NormalToBig];
    
    fadedViewNext.label.text = _strings[[self caculateIndex:self.currentIndex + 1]];
    [fadedViewNext relayUI];
    [fadedViewNext fadedViewAnimationWithType:CRFadedViewAnimationType_SmallToNormal];
    
    [self insertSubview:fadedViewLast belowSubview:fadedViewNext];
    
    [self setDelegateOfFadedView:fadedViewNext];
    [_fadedViews removeAllObjects];
    [_fadedViews addObjectsFromArray:self.subviews];
//    [_fadedViews addObjectsFromArray:@[fadedViewLast, fadedViewNext, fadedViewNow]];
    
    self.currentIndex = self.currentIndex + 1;
}

- (void)showLastView
{
    [self showLastViewWithDuratin:nil];
}

- (void)showLastViewWithDuratin:(NSNumber *)duration
{
    if (!duration) {
        duration = @0.6;
    }
    
    CRFadedView *fadedViewLast  = [self getFadedViewWithIndexType:CRFadeViewIndexType_Last];
    CRFadedView *fadedViewNow   = [self getFadedViewWithIndexType:CRFadeViewIndexType_Now];
    CRFadedView *fadedViewNext  = [self getFadedViewWithIndexType:CRFadeViewIndexType_Next];
    
    fadedViewLast.animationDuration = duration;
    fadedViewLast.layer.opacity = 0;
    
    fadedViewNow.animationDuration = duration;
    fadedViewNow.layer.opacity = 0;
    
    fadedViewNext.animationDuration = duration;
    fadedViewNext.layer.opacity = 0;
    
    fadedViewLast.label.text = _strings[[self caculateIndex:self.currentIndex - 1]];
    [fadedViewLast relayUI];
    [fadedViewLast fadedViewAnimationWithType:CRFadedViewAnimationType_BigToNormal];
    
    fadedViewNow.label.text = _strings[[self caculateIndex:self.currentIndex]];
    [fadedViewNow fadedViewAnimationWithType:CRFadedViewAnimationType_NormalToSmall];
    
    fadedViewNext.label.text = _strings[[self caculateIndex:self.currentIndex + 1]];
    
    [self insertSubview:fadedViewNext aboveSubview:fadedViewLast];
    
    [self setDelegateOfFadedView:fadedViewLast];
    [_fadedViews removeAllObjects];
    [_fadedViews addObjectsFromArray:self.subviews];
//    [_fadedViews addObjectsFromArray:@[fadedViewNext, fadedViewLast, fadedViewNow]];
    
    self.currentIndex = self.currentIndex - 1;
}

- (void)showToIndex:(int)toIndex
{
    _toIndex = toIndex;
    
    if (_toIndex != _currentIndex) {
        
        int D_value = abs(_toIndex - _currentIndex);
        _currentLoopPara.start = _currentIndex;
        _currentLoopPara.end = _toIndex;
        _currentLoopPara.count = D_value;
        
        //  动画已停止，可以立即执行新的动画
        if (_animating == NO) {
            [self caculateSpeedAndScroll];
        }
    }
}

- (CGFloat)caculateDurationWithD_Value:(int)D_Value
{
    CGFloat maxDuration = 0.4;
    CGFloat minDuration = 0.1;
    
    CGFloat a = 0.045;
    CGFloat powValue = pow(D_Value, 2);
    CGFloat duration = 1.0/2*a*powValue;
    
    duration = maxDuration - duration;
    if (duration < minDuration) {
        duration = minDuration;
    }
    
    if (duration > maxDuration) {
        duration = maxDuration;
    }

    return duration;
}

- (void)generateDuringArray
{
    _duringArray = [NSMutableArray new];
    for (int D_value = 0; D_value < 20; D_value++) {
        CGFloat during = [self caculateDurationWithD_Value:D_value];
        [_duringArray addObject:[NSNumber numberWithFloat:during]];
    }
    
    NSLog(@"_duringArray:%@", _duringArray);
}

- (CGFloat)getDurationFromDuringArrayWithD_Value:(int)D_Value
{
    if (D_Value > [_duringArray count] - 1) {
        D_Value = (int)[_duringArray count] - 1;
    }
    CGFloat during = [_duringArray[D_Value] floatValue];
    
    return during;
}

- (void)caculateSpeedAndScroll
{
    CRFadeViewDirType direction = CRFadeViewDirType_Null;
    if (_toIndex > _currentIndex) {
        direction = CRFadeViewDirType_Next;
    }else if (_toIndex < _currentIndex){
        direction = CRFadeViewDirType_Last;
    }
    
    int D_value = abs(_toIndex - _currentIndex);
    
    if (_animating == NO) {
        _animating = YES;
        if ([_delegate respondsToSelector:@selector(willStartFirstAnimationWithString:index:)]) {
            int willShowIndex = [self getNextShowIndex];
            NSString *willShowString = _strings[willShowIndex];
            [_delegate willStartFirstAnimationWithString:willShowString index:willShowIndex];
        }
    }
    
    CGFloat duration = [self getDurationFromDuringArrayWithD_Value:D_value];
    if (direction == CRFadeViewDirType_Next) {
        [self showNextViewWithDuratin:[NSNumber numberWithFloat:duration]];
    }else if (direction == CRFadeViewDirType_Last){
        [self showLastViewWithDuratin:[NSNumber numberWithFloat:duration]];
    }
}

#pragma mark - SetDelegate
- (void)setDelegateOfFadedView:(CRFadedView *)fadedView
{
    for (CRFadedView *tempFadedView in _fadedViews) {
        tempFadedView.delegate = nil;
    }
    
    fadedView.delegate = self;
}

#pragma mark - CRFadedViewDelegate
- (void)animationDidFinishedInFadedView:(CRFadedView *)fadedView
{
    NSLog(@"current index:%d", _currentIndex);
    if (_currentIndex == _toIndex) {
        _animating = NO;
    }else{
        if ([self absValue1:_currentIndex value2:_toIndex] == 1) {
            if ([_delegate respondsToSelector:@selector(willShowLastOneFadeAnimationWithString:index:)]) {
                int willShowIndex = [self getNextShowIndex];
                NSString *willShowString = _strings[willShowIndex];
                [_delegate willShowLastOneFadeAnimationWithString:willShowString index:willShowIndex];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(fadingAnimationWithString:index:)]) {
                int willShowIndex = [self getNextShowIndex];
                NSString *willShowString = _strings[willShowIndex];
                [_delegate fadingAnimationWithString:willShowString index:willShowIndex];
            }
        }
        
        [self caculateSpeedAndScroll];
    }
}

- (int)absValue1:(int)value1 value2:(int)value2
{
    int value = 0;
    if (value1 > value2) {
        value = value1 - value2;
    }else{
        value = value2 - value1;
    }
    
    return value;
}

- (int)getNextShowIndex
{
    CRFadeViewDirType direction = CRFadeViewDirType_Null;
    if (_toIndex > _currentIndex) {
        direction = CRFadeViewDirType_Next;
    }else if (_toIndex < _currentIndex){
        direction = CRFadeViewDirType_Last;
    }
    
    int willShowIndex = 0;
    if (direction == CRFadeViewDirType_Next) {
        willShowIndex = [self caculateIndex:self.currentIndex + 1];
    }else if (direction == CRFadeViewDirType_Last){
        willShowIndex = [self caculateIndex:self.currentIndex - 1];
    }
    
    return willShowIndex;
}

#pragma mark - Setter & Getter
- (void)setStrings:(NSArray *)strings
{
    _strings = strings;
    [self generateFadedViews];
}

@synthesize currentIndex = _currentIndex;
- (void)setCurrentIndex:(int)currentIndex
{
    _currentIndex = [self caculateIndex:currentIndex];
}

- (int)caculateIndex:(int)index
{
    int stringsCount = (int)[_strings count];
    
    if (index < 0) {
        int deltaValue = - index;
        deltaValue = deltaValue % stringsCount;
        index = stringsCount - deltaValue;
    }else if (index >= stringsCount){
        int deltaValue = index - stringsCount;
        deltaValue = deltaValue % stringsCount;
        index = deltaValue;
    }
    
    return index;
}

- (CRFadedView *)getFadedViewWithIndexType:(CRFadeViewIndexType)indexType
{
    int index;
    switch (indexType) {
        case CRFadeViewIndexType_Last: index = 2; break;
        case CRFadeViewIndexType_Now: index = 1; break;
        case CRFadeViewIndexType_Next: index = 0; break;
            
        default:
            break;
    }
    CRFadedView *fadedView = _fadedViews[index];
    
    return fadedView;
}

@end

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

@interface CRNumberFaded ()
{
    NSMutableArray  *_fadedViews;
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
    }
    
    return self;
}

- (void)initSetPara
{
    _currentIndex = 0;
    self.allowCircle = YES;
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
    [fadedViewLast relayUI];
    
    fadedViewNow.layer.opacity = 1;
    fadedViewNow.label.text = _strings[[self caculateIndex:_currentIndex]];
    [fadedViewNow relayUI];
    
    fadedViewNext.layer.opacity = 0;
    fadedViewNext.label.text = _strings[[self caculateIndex:_currentIndex + 1]];
    [fadedViewNext relayUI];
}

- (void)showNextView
{
    CRFadedView *fadedViewLast  = [self getFadedViewWithIndexType:CRFadeViewIndexType_Last];
    CRFadedView *fadedViewNow   = [self getFadedViewWithIndexType:CRFadeViewIndexType_Now];
    CRFadedView *fadedViewNext  = [self getFadedViewWithIndexType:CRFadeViewIndexType_Next];
    
    fadedViewLast.layer.opacity = 0;
    fadedViewNow.layer.opacity = 0;
    fadedViewNext.layer.opacity = 0;
    
    fadedViewLast.label.text = _strings[[self caculateIndex:self.currentIndex - 1]];
    
    fadedViewNow.label.text = _strings[[self caculateIndex:self.currentIndex]];
    [fadedViewNow fadedViewAnimationWithType:CRFadedViewAnimationType_NormalToBig];
    
    fadedViewNext.label.text = _strings[[self caculateIndex:self.currentIndex + 1]];
    [fadedViewNext relayUI];
    [fadedViewNext fadedViewAnimationWithType:CRFadedViewAnimationType_SmallToNormal];
    
    [self insertSubview:fadedViewLast belowSubview:fadedViewNext];
    
    [_fadedViews removeAllObjects];
    [_fadedViews addObjectsFromArray:self.subviews];
//    [_fadedViews addObjectsFromArray:@[fadedViewLast, fadedViewNext, fadedViewNow]];
    
    self.currentIndex = self.currentIndex + 1;
}

- (void)showLastView
{
    CRFadedView *fadedViewLast  = [self getFadedViewWithIndexType:CRFadeViewIndexType_Last];
    CRFadedView *fadedViewNow   = [self getFadedViewWithIndexType:CRFadeViewIndexType_Now];
    CRFadedView *fadedViewNext  = [self getFadedViewWithIndexType:CRFadeViewIndexType_Next];
    
    fadedViewLast.layer.opacity = 0;
    fadedViewNow.layer.opacity = 0;
    fadedViewNext.layer.opacity = 0;
    
    fadedViewLast.label.text = _strings[[self caculateIndex:self.currentIndex - 1]];
    [fadedViewLast relayUI];
    [fadedViewLast fadedViewAnimationWithType:CRFadedViewAnimationType_BigToNormal];
    
    fadedViewNow.label.text = _strings[[self caculateIndex:self.currentIndex]];
    [fadedViewNow fadedViewAnimationWithType:CRFadedViewAnimationType_NormalToSmall];
    
    fadedViewNext.label.text = _strings[[self caculateIndex:self.currentIndex + 1]];
    
    [self insertSubview:fadedViewNext aboveSubview:fadedViewLast];
    
    [_fadedViews removeAllObjects];
    [_fadedViews addObjectsFromArray:self.subviews];
//    [_fadedViews addObjectsFromArray:@[fadedViewNext, fadedViewLast, fadedViewNow]];
    
    self.currentIndex = self.currentIndex - 1;
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

//
//  PerformanceVC.m
//  CRNumberFaded
//
//  Created by Bear on 2017/5/12.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "PerformanceVC.h"
#import "CRNumberFaded.h"
#import "CRSlider.h"
#import "CRSliderIndicator.h"

@interface PerformanceVC ()
{
    CRNumberFaded *_numberFadedView;
    CRSlider *_slider;
    CRSliderIndicator *_sliderIndicator;
}
@end

@implementation PerformanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)createUI
{
    [self createSliderIndicator];
    [self createNumberFadedView];
    [self createCRSlider];
}

- (void)createSliderIndicator
{
    _sliderIndicator = [[CRSliderIndicator alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 40, 300)];
    [self.view addSubview:_sliderIndicator];
    [_sliderIndicator BearSetRelativeLayoutWithDirection:kDIR_UP destinationView:nil parentRelation:YES distance:20 center:YES];
}

- (void)createNumberFadedView
{
    NSMutableArray *strings = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        NSString *numberString = [NSString stringWithFormat:@"%d", i];
        [strings addObject:numberString];
    }
    
    _numberFadedView = [[CRNumberFaded alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _numberFadedView.strings = strings;
    _numberFadedView.backgroundColor = [UIColor orangeColor];
    [_sliderIndicator addSubview:_numberFadedView];
    [_numberFadedView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    [_numberFadedView setY:_numberFadedView.y - 50];
}

- (void)createCRSlider
{
    _slider = [[CRSlider alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 40, 40)];
    _slider.minimumValue = 0;
    _slider.maximumValue = 20;
    _slider.backgroundColor = [UIColor blueColor];
    [_slider addTarget:self action:@selector(testSliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    [_slider BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:_sliderIndicator parentRelation:NO distance:20 center:YES];
}

#pragma mark - Event
- (void)testSliderChanged:(CRSlider *)slider
{
    int index = (int)ceil(slider.value);
    NSLog(@"--1 slider value:%d", index);
    [_numberFadedView showToIndex:index];
    
    CGPoint thumbImageVCenter = slider.thumbImageV.center;
    CGPoint tempCenter = [_sliderIndicator convertPoint:thumbImageVCenter fromView:slider];
    [_sliderIndicator setCircleCenterX:thumbImageVCenter.x];
    
    NSLog(@"thumbImageVCenter:%@ tempCenter:%@", NSStringFromCGPoint(thumbImageVCenter), NSStringFromCGPoint(tempCenter));
}

@end

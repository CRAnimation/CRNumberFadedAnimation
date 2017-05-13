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

@interface PerformanceVC () <CRSliderDelegate>
{
    UIView *_customNaviBarView;
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
    [self createCustomNavigationBarView];
    [self createSliderIndicator];
    [self createNumberFadedView];
    [self createCRSlider];
    
    _sliderIndicator.r = _slider.thumbImageV.width / 2.0;
    _sliderIndicator.toCircleCenterYDistance = _slider.y + _slider.height / 2.0 - _sliderIndicator.maxY;
}

- (void)createCustomNavigationBarView
{
    _customNaviBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    _customNaviBarView.backgroundColor =[ UIColor whiteColor];
    [self.view addSubview:_customNaviBarView];
    
    UILabel *titlLabel = [UILabel new];
    titlLabel.text = @"App Settings";
    titlLabel.textColor = UIColorFromHEX(0x919191);
    [_customNaviBarView addSubview:titlLabel];
    [titlLabel sizeToFit];
    [titlLabel BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
}

- (void)createSliderIndicator
{
    CGFloat sliderIndicatorHeight = 1.0 * (HEIGHT - _customNaviBarView.maxY) / 4 * 3;
    _sliderIndicator = [[CRSliderIndicator alloc] initWithFrame:CGRectMake(0, _customNaviBarView.maxY, WIDTH, sliderIndicatorHeight)];
    [self.view addSubview:_sliderIndicator];
    
    //  UI
    UIImage *fireImage = [[UIImage imageNamed:@"fireIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *fireImageV = [[UIImageView alloc] initWithImage:fireImage];
    fireImageV.frame = CGRectMake(0, 0, 35, 35);
    fireImageV.tintColor = [UIColor whiteColor];
    [_sliderIndicator addSubview:fireImageV];
    [fireImageV BearSetRelativeLayoutWithDirection:kDIR_UP destinationView:nil parentRelation:YES distance:30 center:YES];
    
    UILabel *noticeLabel = [UILabel new];
    noticeLabel.textColor = [UIColor whiteColor];
    noticeLabel.text = @"Get hottest discounts";
    [noticeLabel sizeToFit];
    [_sliderIndicator addSubview:noticeLabel];
    [noticeLabel BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:fireImageV parentRelation:NO distance:15 center:YES];
}

- (void)createNumberFadedView
{
    NSMutableArray *strings = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        NSString *numberString = [NSString stringWithFormat:@"%d", i];
        [strings addObject:numberString];
    }
    
    _numberFadedView = [[CRNumberFaded alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _numberFadedView.font = [UIFont fontWithName:@"Helvetica-Bold" size:150];
    _numberFadedView.textColor = [UIColor whiteColor];
    _numberFadedView.strings = strings;
    _numberFadedView.backgroundColor = [UIColor clearColor];
    [_sliderIndicator addSubview:_numberFadedView];
    [_numberFadedView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    [_numberFadedView setY:_numberFadedView.y - 50];
}

- (void)createCRSlider
{
    _slider = [[CRSlider alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    _slider.delegate = self;
    _slider.minimumValue = 0;
    _slider.maximumValue = 20;
    _slider.backgroundColor = [UIColor clearColor];
    [_slider.poleImageV setY:_slider.poleImageV.y + _slider.height / 6.0 * 1];
    [_slider addTarget:self action:@selector(testSliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    [_slider BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:_sliderIndicator parentRelation:NO distance:-20 center:YES];
}

#pragma mark - Event
- (void)testSliderChanged:(CRSlider *)slider
{
    int index = (int)ceil(slider.value);
    NSLog(@"--1 slider value:%d", index);
    [_numberFadedView showToIndex:index];
}

#pragma mark - CRSliderDelegate
- (void)thumbImageVDidSlided:(CRSlider *)slider
{
    CALayer *presentationLayer = slider.thumbImageV.layer.presentationLayer;
    CGPoint thumbImageVCenter = presentationLayer.position;
    CGPoint tempCenter = [_sliderIndicator convertPoint:thumbImageVCenter fromView:slider];
    [_sliderIndicator setCircleCenterX:thumbImageVCenter.x];
    
    NSLog(@"thumbImageVCenter:%@ tempCenter:%@", NSStringFromCGPoint(thumbImageVCenter), NSStringFromCGPoint(tempCenter));
}

@end

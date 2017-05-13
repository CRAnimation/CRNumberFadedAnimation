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

typedef NS_ENUM(NSInteger, LRLablesStatus) {
    LRLablesStatusIdle,
    LRLablesStatusSpread,
    LRLablesStatusDrawIn,
};

@interface PerformanceVC () <CRSliderDelegate, CRNumberFadedDelegate>
{
    UIView *_customNaviBarView;
    CRNumberFaded *_numberFadedView;
    CRSlider *_slider;
    CRSliderIndicator *_sliderIndicator;
    
    UILabel *_leftLabel;
    UILabel *_rightLabel;
}

@property (assign, nonatomic) LRLablesStatus lrLablesStatus;

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
    [self createLeftAndRightLabel];
    [self createCRSlider];
    
    [self thumbImageVDidSlided:_slider];
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
    [fireImageV BearSetRelativeLayoutWithDirection:kDIR_UP destinationView:nil parentRelation:YES distance:15 center:YES];
    
    UILabel *noticeLabel = [UILabel new];
    noticeLabel.textColor = [UIColor whiteColor];
    noticeLabel.text = @"Get hottest discounts";
    [noticeLabel sizeToFit];
    [_sliderIndicator addSubview:noticeLabel];
    [noticeLabel BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:fireImageV parentRelation:NO distance:12 center:YES];
    
    UIView *sepLineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH- 40, 0.5)];
    sepLineV.backgroundColor = [UIColor whiteColor];
    [_sliderIndicator addSubview:sepLineV];
    [sepLineV BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:noticeLabel parentRelation:nil distance:18 center:YES];
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
    _numberFadedView.delegate = self;
    _numberFadedView.backgroundColor = [UIColor clearColor];
    [_sliderIndicator addSubview:_numberFadedView];
    [_numberFadedView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    [_numberFadedView setY:_numberFadedView.y - 50];
}

- (void)createLeftAndRightLabel
{
    _leftLabel = [UILabel new];
    _leftLabel.text = @"Every";
    _leftLabel.font = [UIFont systemFontOfSize:16];
    _leftLabel.textColor = [UIColor whiteColor];
    [_leftLabel sizeToFit];
    [_sliderIndicator addSubview:_leftLabel];
    [_leftLabel BearSetRelativeLayoutWithDirection:kDIR_LEFT destinationView:_numberFadedView parentRelation:NO distance:0 center:YES];
    
    _rightLabel = [UILabel new];
    _rightLabel.text = @"hours";
    _rightLabel.font = [UIFont systemFontOfSize:16];
    _rightLabel.textColor = [UIColor whiteColor];
    [_rightLabel sizeToFit];
    [_sliderIndicator addSubview:_rightLabel];
    [_rightLabel BearSetRelativeLayoutWithDirection:kDIR_RIGHT destinationView:_numberFadedView parentRelation:NO distance:0 center:YES];
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

#pragma mark - LeftAndRightLabelAnimation
- (void)leftAndRightLabelAnimationWithStatus:(LRLablesStatus)status string:(NSString *)string
{
    CGFloat during = 0.7;
    CGFloat offX = 20;
    CGFloat gapX = 20;
    UIView *labelSuperView = _rightLabel.superview;
    CGFloat halfSuperViewWidth = labelSuperView.width / 2.0;
    if (status == LRLablesStatusSpread) {
        [UIView animateWithDuration:during delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [_leftLabel setX:offX];
            [_rightLabel setMaxX:labelSuperView.width - offX];
        } completion:^(BOOL finished) {
            nil;
        }];
    }else if (status == LRLablesStatusDrawIn) {
        UILabel *tempLabel = [UILabel new];
        tempLabel.text = string;
        tempLabel.font = _numberFadedView.font;
        [tempLabel sizeToFit];
        CGFloat halfLabelWidth = tempLabel.width / 2.0;
        [UIView animateWithDuration:during delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [_leftLabel setMaxX:halfSuperViewWidth - halfLabelWidth - gapX];
            [_rightLabel setX:halfSuperViewWidth + halfLabelWidth + gapX];
        } completion:^(BOOL finished) {
            nil;
        }];
    }
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
    if (!presentationLayer) {
        presentationLayer = slider.thumbImageV.layer;
    }
    CGPoint thumbImageVCenter = presentationLayer.position;
    CGPoint tempCenter = [_sliderIndicator convertPoint:thumbImageVCenter fromView:slider];
    [_sliderIndicator setCircleCenterX:thumbImageVCenter.x];
    
    NSLog(@"thumbImageVCenter:%@ tempCenter:%@", NSStringFromCGPoint(thumbImageVCenter), NSStringFromCGPoint(tempCenter));
}

#pragma mark - CRFadedViewDelegate
- (void)willShowLastOneFadeAnimationWithString:(NSString *)string
{
    NSLog(@"--string:%@", string);
    if (self.lrLablesStatus != LRLablesStatusDrawIn) {
        self.lrLablesStatus = LRLablesStatusDrawIn;
        [self leftAndRightLabelAnimationWithStatus:self.lrLablesStatus string:string];
    }
}

- (void)willStartFirstAnimationWithString:(NSString *)string
{
    NSLog(@"--start:%@", string);
    
    if (self.lrLablesStatus != LRLablesStatusSpread) {
        self.lrLablesStatus = LRLablesStatusSpread;
        [self leftAndRightLabelAnimationWithStatus:self.lrLablesStatus string:string];
    }
}

#pragma mark - Setter & Getter
- (void)setLrLablesStatus:(LRLablesStatus)lrLablesStatus
{
    _lrLablesStatus = lrLablesStatus;
}

@end

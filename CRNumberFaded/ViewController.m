//
//  ViewController.m
//  CRNumberFaded
//
//  Created by Bear on 17/3/22.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "ViewController.h"
#import "CRNumberFaded.h"

#import "CRFadedView.h"

@interface ViewController ()
{
    UISlider *_slider;
    CRFadedView *fadedView;
    CRNumberFaded *numberFadedView;
    
    UIButton    *_leftBtn;
    UIButton    *_rightBtn;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
//    [self testFadedView];
    [self addSlider];
    [self addBtn];
}

- (void)createUI
{
    numberFadedView = [[CRNumberFaded alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    numberFadedView.strings = @[@"1", @"2", @"3", @"4"];
    numberFadedView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:numberFadedView];
    [numberFadedView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
}

- (void)testFadedView
{
    fadedView = [[CRFadedView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    fadedView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:fadedView];
    [fadedView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    
    fadedView.label.text = @"123";
    [fadedView relayUI];
    
    fadedView.animationDuration = @1;
    [fadedView testFadeLinear];
    fadedView.layer.speed = 0;
}

- (void)addSlider
{
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 100, 30)];
    [_slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    [_slider BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:numberFadedView parentRelation:NO distance:80 center:YES];
}

- (void)addBtn
{
    _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _leftBtn.backgroundColor = [UIColor orangeColor];
    [_leftBtn setTitle:@"-" forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftBtn];
    
    _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _rightBtn.backgroundColor = [UIColor orangeColor];
    [_rightBtn setTitle:@"+" forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightBtn];
    
    [UIView BearV2AutoLayViewArray:(NSMutableArray *)@[_leftBtn, _rightBtn] layoutAxis:kLAYOUT_AXIS_X alignmentType:kSetAlignmentType_Start alignmentOffDis:_slider.maxY + 20];
}

- (void)btnEvent:(UIButton *)sender
{
    if ([sender isEqual:_leftBtn]) {
        [numberFadedView showLastView];
    }else if ([sender isEqual:_rightBtn]){
        [numberFadedView showNextView];
    }
}

- (void)valueChange:(UISlider *)slider
{
    fadedView.layer.timeOffset = slider.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

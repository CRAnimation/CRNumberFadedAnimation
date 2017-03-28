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
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self addSlider];
    [self testFadedView];
}

- (void)createUI
{
    CRNumberFaded *numberFadedView = [[CRNumberFaded alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
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
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 100, 200, 30)];
    [_slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
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

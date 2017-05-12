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
#import "CRSlider.h"

@interface ViewController ()
{
    UISlider *_slider;
    CRFadedView *fadedView;
    CRNumberFaded *numberFadedView;
    
    UIButton    *_leftBtn;
    UIButton    *_rightBtn;
    
    UITextField *_tf;
    UIButton    *_confirmBtn;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
//    [self testFadedView];
    [self addSlider];
    [self addBtn];
    [self createTfAndConfirmBtn];
    
    [self createCRSlider];
}

- (void)createUI
{
    NSMutableArray *strings = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        NSString *numberString = [NSString stringWithFormat:@"%d", i];
        [strings addObject:numberString];
    }
    
    numberFadedView = [[CRNumberFaded alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    numberFadedView.strings = strings;
    numberFadedView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:numberFadedView];
    [numberFadedView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
}

- (void)createCRSlider
{
    CRSlider *slider = [[CRSlider alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 40, 40)];
    slider.backgroundColor = [UIColor blueColor];
    [self.view addSubview:slider];
    [slider BearSetRelativeLayoutWithDirection:kDIR_UP destinationView:nil parentRelation:YES distance:20 center:YES];
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
    _slider.minimumValue = 0;
    _slider.maximumValue = 20;
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

- (void)createTfAndConfirmBtn
{
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _tf.backgroundColor = [UIColor orangeColor];
    _tf.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_tf];
    
    _confirmBtn = [[UIButton alloc] init];
    [_confirmBtn setTitle:@"confirm" forState:UIControlStateNormal];
    _confirmBtn.backgroundColor = [UIColor orangeColor];
    [_confirmBtn sizeToFit];
    [_confirmBtn addTarget:self action:@selector(confirmBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
    [UIView BearV2AutoLayViewArray:(NSMutableArray *)@[_tf, _confirmBtn] layoutAxis:kLAYOUT_AXIS_X alignmentType:kSetAlignmentType_Start alignmentOffDis:numberFadedView.y - 70 gapDistance:30];
}

#pragma mark - Event
- (void)valueChange:(UISlider *)slider
{
    int value = (int)slider.value;
    NSLog(@"--value:%d", value);
    [numberFadedView showToIndex:value];
    
//    fadedView.layer.timeOffset = slider.value;
}

- (void)confirmBtnEvent
{
    [self resignFirstResponder];
    
    if ([_tf.text length] > 0) {
        int toIndex = [_tf.text intValue];
        NSLog(@"--toIndex:%d", toIndex);
        [numberFadedView showToIndex:toIndex];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

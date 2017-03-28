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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
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
    CRFadedView *fadedView = [[CRFadedView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    fadedView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:fadedView];
    [fadedView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    
    fadedView.label.text = @"123";
    [fadedView relayUI];
    
    [BearConstants delayAfter:2.0 dealBlock:^{
        [fadedView testFade];
    }];
    
//    [BearConstants delayAfter:2.0 dealBlock:^{
//        [fadedView fadeIn];
//        [BearConstants delayAfter:2.0 dealBlock:^{
//            [fadedView fadeOut];
//        }];
//    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

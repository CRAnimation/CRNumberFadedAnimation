//
//  ViewController.m
//  CRNumberFaded
//
//  Created by Bear on 17/3/22.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "ViewController.h"
#import "CRNumberFaded.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI
{
    CRNumberFaded *numberFadedView = [[CRNumberFaded alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    numberFadedView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:numberFadedView];
    [numberFadedView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

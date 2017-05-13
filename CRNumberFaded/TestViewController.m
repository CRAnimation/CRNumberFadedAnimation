//
//  TestViewController.m
//  CRNumberFaded
//
//  Created by Bear on 2017/5/13.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
{
    UIView *_view1;
    UIView *_view2;
    UIDynamicAnimator       *_animator;
    UICollisionBehavior *collisionBehavior;
    UIGravityBehavior *gravityBehavior;
    
    UIView *contentView;
}

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _view1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_view1];
    
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _view2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_view2];
    
    [UIView BearV2AutoLayViewArray:(NSMutableArray *)@[_view1, _view2] layoutAxis:kLAYOUT_AXIS_Y alignmentType:kSetAlignmentType_Center alignmentOffDis:0];
    
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    
     [self addCollisionBehavior:_view1];
     [self addCollisionBehavior:_view2];
    
    [self addGravityBehavior:_view1];
    [self addGravityBehavior:_view2];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    [btn BearSetRelativeLayoutWithDirection:kDIR_UP destinationView:nil parentRelation:YES distance:100 center:YES];
    [btn addTarget:self action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnEvent
{
    [_view2 setY:_view2.y - 20];
}

#pragma mark  碰撞行为
- (UICollisionBehavior *)addCollisionBehavior:(id <UIDynamicItem>)item
{
    if (!collisionBehavior) {
        collisionBehavior = [[UICollisionBehavior alloc] init];
        [_animator addBehavior:collisionBehavior];
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.view.bounds];
        [collisionBehavior addBoundaryWithIdentifier:@"path" forPath:path];
        collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    }
    [collisionBehavior addItem:item];

    return collisionBehavior;
}

#pragma mark  重力行为
- (UIGravityBehavior *)addGravityBehavior:(id <UIDynamicItem>)item
{
    if (!gravityBehavior) {
        gravityBehavior = [[UIGravityBehavior alloc] init];
        [_animator addBehavior:gravityBehavior];
    }
    [gravityBehavior addItem:item];
    
    return gravityBehavior;
}

@end

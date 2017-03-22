//
//  BearAlertView.h
//  GOSHOPPING
//
//  Created by Bear on 16/6/26.
//  Copyright © 2016年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BearAlertBtnsView.h"
#import "BearAlertContentView.h"

//  动效方式
typedef NS_ENUM(NSUInteger, AlertViewAnimation) {
    kAlertViewAnimation_VerticalSpring,     //直线弹簧动效
    kAlertViewAnimation_CenterScale,        //中心缩放动效
};

//  动画执行状态
typedef NS_ENUM(NSUInteger, AlertViewAnimationState) {
    kAlertViewAnimationState_Null,          //无状态，
    kAlertViewAnimationState_Process,       //动画进行中
};

//  AlertView自定义样式
typedef NS_ENUM(NSUInteger, AlertViewCustomType) {
    kAlertViewCustomType_ContentAndBtns,    //BearAlertContentView+BearAlertBtnsView自定义
    kAlertViewCustomType_AllDiy,            //全部自定义
};


typedef void (^kAlertViewBlock)();
typedef void (^AnimationFinishBlock)();
typedef void (^AnimationClose_FinishBlock)();


@interface BearAlertView : UIView

@property (assign, nonatomic)   BOOL clickBtnCancel;         //点击按钮，消失Alert
@property (assign, nonatomic)   BOOL tapBgCancel;           //触摸背景，消失Alert
@property (strong, nonatomic)   UITapGestureRecognizer *tapGesture;
@property (copy, nonatomic)     AnimationClose_FinishBlock  animationClose_FinishBlock; //消退动画完成block
@property (strong, nonatomic)   BearAlertContentView    *normalAlertContentView;
@property (strong, nonatomic)   BearAlertBtnsView       *normalAlertBtnsView;
@property (assign, nonatomic)   AlertViewCustomType     alertViewCustomType;

@property (strong, nonatomic)   UIView                  *bgView;

- (instancetype)initWithAlertCustomType:(AlertViewCustomType)alertCustomType;

//  自定义模式下专用 kAlertViewCustomType_AllDiy
- (void)setAllDiyTypeContentView:(UIView *)contentView;

/**
 *  设置contentView
 */
- (void)setContentView:(UIView *)contentView;

/**
 *  设置btnsView
 */
- (void)setBtnsView:(UIView *)btnsView;

/**
 *  点击按钮block
 *
 *  @param confirmBlock 确认按钮block
 *  @param cancelBlock  取消按钮block
 *  @notice 只有BearAlertBtnsView类型的btnsView才可使用该方法
 */
- (void)alertView_ConfirmClickBlock:(kAlertViewBlock)confirmBlock CancelClickBlock:(kAlertViewBlock)cancelBlock;

/**
 *  点击按钮block
 *
 *  @param selectBtn 点击的按钮
 *  @param block     按钮block
 *  @notice 自定义，非BearAlertBtnsView类型需要单独给按钮调用该方法
 */
- (void)alertView_SelectBtn:(UIButton *)selectBtn block:(kAlertViewBlock)block;

/**
 *  添加按钮点击事件
 *  @notice 自定义，非BearAlertBtnsView类型需要单独给按钮调用该方法
 */
- (void)btnEvent:(UIButton *)sender;

/**
 *  Alertview显现动画
 */
- (void)animationShow_udAlertView;

/**
 *  AlertView消退动画
 */
- (void)animationClose_udAlertView;

@end


/**
 *  How to use?
 *
 *  brief Demo/简单demo
 *
 
 - (void)testNormal
 {
 __block BearAlertView *bearAlert = [[BearAlertView alloc] init];
 
 bearAlert.normalAlertContentView.titleLabel.text = @"温馨提示";
 bearAlert.normalAlertContentView.contentLabel.text = @"My name is Bear. Github ID is BearRan. \nThank you!";
 
 [bearAlert alertView_ConfirmClickBlock:^{
 NSLog(@"--confirm");
 } CancelClickBlock:^{
 NSLog(@"--cancel");
 }];
 bearAlert.animationClose_FinishBlock = ^(){
 NSLog(@"--closeAniamtion finish");
 bearAlert = nil;
 };
 
 AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
 [myDelegate.window addSubview:bearAlert];
 }
 
 */



/**
 *  How to use?
 *
 *  UserDefine Demo/自定义demo
 *
 
 - (void)testUserDefine
 {
 
 __block BearAlertView *bearAlert = [[BearAlertView alloc] init];
 
 //  自定义ContentView
 UIView *tempContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 50, 200)];
 tempContentView.backgroundColor = [UIColor orangeColor];
 [bearAlert setContentView:tempContentView];
 
 //  自定义BtnsView
 UIView *tempBtnsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tempContentView.width, 40)];
 CGFloat btn_width = floor(tempBtnsView.width / 3.0);
 CGFloat btn_height = tempBtnsView.height;
 for (int i = 0; i < 3; i++) {
 UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btn_width, btn_height)];
 btn.backgroundColor = [UIColor blueColor];
 [btn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
 [tempBtnsView addSubview:btn];
 [btn addTarget:bearAlert action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
 
 //  按钮点击回调
 [bearAlert alertView_SelectBtn:btn block:^{
 NSLog(@"--clickBtn:%d", i);
 }];
 }
 [UIView BearAutoLayViewArray:(NSMutableArray *)tempBtnsView.subviews layoutAxis:kLAYOUT_AXIS_X center:YES];
 [bearAlert setBtnsView:tempBtnsView];
 
 bearAlert.animationClose_FinishBlock = ^(){
 NSLog(@"--closeAniamtion finish");
 bearAlert = nil;
 };
 
 AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
 [myDelegate.window addSubview:bearAlert];
 }
 
 **/



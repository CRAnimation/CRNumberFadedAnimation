//
//  CRNumberFaded.h
//  CRNumberFaded
//
//  Created by Bear on 17/3/22.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CRNumberFadedDelegate <NSObject>

- (void)willShowLastOneFadeAnimationWithString:(NSString *)string index:(int)index;
- (void)willStartFirstAnimationWithString:(NSString *)string index:(int)index;
- (void)fadingAnimationWithString:(NSString *)string index:(int)index;

@end

@interface CRNumberFaded : UIView

@property (weak, nonatomic) id <CRNumberFadedDelegate> delegate;
@property (strong, nonatomic) NSArray   *strings;
@property (strong, nonatomic) UIFont    *font;
@property (strong, nonatomic) UIColor   *textColor;
@property (assign, nonatomic) BOOL      allowCircle;    //是否允许无限滚动

- (void)showNextView;
- (void)showLastView;
- (void)showToIndex:(int)toIndex;

@end

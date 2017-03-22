//
//  CRFadedView.h
//  CRNumberFaded
//
//  Created by Bear on 17/3/22.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRFadedView : UIView

@property (strong, nonatomic) UILabel  *label;
@property (strong, nonatomic) NSNumber *needLabel;      //Default @YES
@property (strong, nonatomic) NSNumber *fadeInRatio;
@property (strong, nonatomic) NSNumber *fadeOutRatio;
@property (strong, nonatomic) NSNumber *fadeDuration;

- (void)loadParameterAndCreateUI;
- (void)fadeIn;
- (void)fadeOut;
- (void)relayUI;

@end

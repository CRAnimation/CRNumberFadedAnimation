//
//  CRNumberFaded.h
//  CRNumberFaded
//
//  Created by Bear on 17/3/22.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRNumberFaded : UIView

@property (strong, nonatomic) NSArray   *strings;
@property (assign, nonatomic) BOOL      allowCircle;    //是否允许无限滚动

- (void)showNextView;
- (void)showLastView;

@end

//
//  CRSliderIndicatorChip.h
//  CRNumberFaded
//
//  Created by Bear on 2017/5/13.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CRSliderIndicatorChipStatus) {
    CRSliderIndicatorChipStatusIdle,
    CRSliderIndicatorChipStatusNormal,
    CRSliderIndicatorChipStatusScale,
};

@interface CRSliderIndicatorChip : UIView

@property (strong, nonatomic) NSString  *string;
@property (assign, nonatomic) CRSliderIndicatorChipStatus status;

- (instancetype)initWithCommonFrame;

@end

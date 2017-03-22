//
//  BearAlertContentView.m
//  GOSHOPPING
//
//  Created by Bear on 16/6/27.
//  Copyright © 2016年 cjl. All rights reserved.
//

#import "BearAlertContentView.h"
#import "BearConstants.h"
#import "UIView+BearSet.h"

@implementation BearAlertContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLabel];
        
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font  =[UIFont systemFontOfSize:14];
        [self addSubview:_contentLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat max_width = WIDTH - 2 * 30;
    
    [_titleLabel sizeToFit];
    [_contentLabel sizeToFit];
    
    if (_titleLabel.width > max_width) {
        [_titleLabel setWidth:max_width];
        [_titleLabel sizeToFit];
    }
    
    if (_contentLabel.width > max_width) {
        [_contentLabel setWidth:max_width];
        [_contentLabel sizeToFit];
    }
    
    [self setWidth:_titleLabel.width > _contentLabel.width ? _titleLabel.width + 30 : _contentLabel.width + 30];
    if (self.width < WIDTH / 2) {
        [self setWidth:WIDTH / 2];
    }
    
    [_titleLabel BearSetRelativeLayoutWithDirection:kDIR_UP destinationView:nil parentRelation:YES distance:15 center:YES];
    [_contentLabel BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:_titleLabel parentRelation:NO distance:20 center:YES];
    [self setHeight:_contentLabel.maxY + 20];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

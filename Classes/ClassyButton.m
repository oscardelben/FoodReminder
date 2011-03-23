//
//  ClassyButton.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/20/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "ClassyButton.h"


@implementation ClassyButton

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self setTitleColor:[UIColor colorWithRed:96/255.0 green:62/255.0 blue:44/255.0 alpha:1] forState:UIControlStateHighlighted];
    
    self.titleLabel.font = [UIFont fontWithName:@"BrushScriptStd" size:24];
    self.titleLabel.textColor = [UIColor colorWithRed:119/255.0 green:79/255.0 blue:56/255.0 alpha:1];
}


@end

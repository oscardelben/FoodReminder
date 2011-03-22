//
//  TitleButton.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/22/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "TitleButton.h"


@implementation TitleButton

- (void)drawRect:(CGRect)rect
{
    self.titleLabel.font = [UIFont fontWithName:@"BrushScriptStd" size:30];
    self.titleLabel.textColor = [UIColor colorWithRed:119/255.0 green:79/255.0 blue:56/255.0 alpha:1];
}


@end

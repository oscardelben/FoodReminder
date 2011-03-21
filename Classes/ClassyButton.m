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
//    self.layer.backgroundColor = [[UIColor colorWithRed:119/255.0 green:79/255.0 blue:56/255.0 alpha:1] CGColor];
//    self.layer.borderColor = [[UIColor blackColor] CGColor];
//    self.layer.borderWidth = 1;
//    self.layer.cornerRadius = 10;
    self.titleLabel.font = [UIFont fontWithName:@"BrushScriptStd" size:20];
    self.titleLabel.textColor = [UIColor colorWithRed:119/255.0 green:79/255.0 blue:56/255.0 alpha:1];
}


@end

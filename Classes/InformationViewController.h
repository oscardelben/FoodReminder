//
//  InformationViewController.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/30/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MailComposerViewController;

@interface InformationViewController : UIViewController {
    MailComposerViewController *mailComposerViewController;
}

- (IBAction)back:(id)sender;
- (IBAction)showInstructions:(id)sender;
- (IBAction)sendFeedback:(id)sender;

@end

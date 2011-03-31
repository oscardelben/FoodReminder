//
//  InformationViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/30/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "InformationViewController.h"
#import "InstructionsViewController.h"
#import "MailComposerViewController.h"

@implementation InformationViewController

- (void)viewDidLoad
{
    if (mailComposerViewController == nil) {
		mailComposerViewController = [[MailComposerViewController alloc] init];
		mailComposerViewController.delegate = self;
		mailComposerViewController.recipient = @"info@oscardelben.com";
        mailComposerViewController.subject = @"[Food Reminder] Feedback";
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait || 
    toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown;
}

- (IBAction)back:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInstructions:(id)sender
{
    InstructionsViewController *viewController = [[InstructionsViewController alloc] initWithNibName:@"InstructionsViewController" bundle:nil];
    [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:viewController animated:YES];
    [viewController release];
}

- (IBAction)sendFeedback:(id)sender
{
    [mailComposerViewController showPicker];
}

@end

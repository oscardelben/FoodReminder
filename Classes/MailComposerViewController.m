//
//  MailComposerViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/31/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "MailComposerViewController.h"


@implementation MailComposerViewController

@synthesize delegate, recipient, subject, content;

-(void)showPicker
{
	// Check if we can send emails. Thanks Apple.
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
}

#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:subject];
	
	if (recipient) 
    {
        NSArray *toRecipients = [NSArray arrayWithObject:recipient];
        
        [picker setToRecipients:toRecipients];
    }
    
	// Fill out the email body text
    if (content)
    {
        [picker setMessageBody:content isHTML:NO];
    }
	
	[delegate presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	[delegate dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = [NSString stringWithFormat:@"mailto:%@?subject=%@", recipient, subject];
	NSString *body = [NSString stringWithFormat:@"&body=%@", content];
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}

- (void)dealloc {
	[delegate release];
	[recipient release];
	[subject release];
	[content release];
    [super dealloc];
}

@end

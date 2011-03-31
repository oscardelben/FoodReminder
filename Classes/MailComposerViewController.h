//
//  MailComposerViewController.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/31/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MailComposerViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	id delegate;
	
	NSString *recipient;
	NSString *subject;
	NSString *content;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSString *recipient;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *content;

-(void)showPicker;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

@end
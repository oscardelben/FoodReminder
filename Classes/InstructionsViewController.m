//
//  InstructionsViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/30/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "InstructionsViewController.h"


@implementation InstructionsViewController

@synthesize webView;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait || 
    toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"instructions" ofType:@"html"]; 
    
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    webView.opaque = NO;
    webView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [[webView.subviews objectAtIndex:0] setScrollEnabled:NO]; // disable scrolling
    [webView loadHTMLString:text baseURL:nil];
}

- (void)dealloc
{
    [webView release];
    [super dealloc];
}

- (IBAction)back:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithBool:YES] forKey:@"instructions-shown"];
    [self dismissModalViewControllerAnimated:YES];
}

@end

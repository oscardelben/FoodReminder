//
//  NewCategoryViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/11/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "NewCategoryViewController.h"
#import "FoodReminderAppDelegate.h"
#import "NSString+DBExtensions.h"
#import "GradientButton.h"

@implementation NewCategoryViewController

@synthesize parentController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        managedObjectContext = 
		[(FoodReminderAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        
        category = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:managedObjectContext];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.title = @"New Category";
    
    [cancelButton release];
    
    // Save button
    
    UIView *buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    button1 = [[GradientButton alloc] initWithFrame:CGRectMake(20, 10, 120, 30)];
    [button1 useBlackStyle];
    button1.hidden = YES;
    [button1 setTitle:@"Save" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [buttonsView addSubview:button1];
    
    // Instantiate the table model
    tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
    tableModel.delegate = self;
    
    SCTableViewSection *section = [SCTableViewSection section];
    
    SCTextFieldCell *nameCell = [SCTextFieldCell cellWithText:@"Name" withBoundObject:category withPropertyName:@"name"];
    [section addCell:nameCell];
    section.footerView = buttonsView;
    
    [tableModel addSection:section];
}

- (void)dealloc
{
    [parentController release];
    [tableModel release];
    [super dealloc];
}

- (BOOL)valid
{
    NSString *name = [category valueForKey:@"name"];
    
    return (name && ![name blank]);
}

- (void)save
{
    if (![self valid])
        [managedObjectContext deleteObject:category];
    
    [parentController performSelector:@selector(dismissController)];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)cancel
{
    [managedObjectContext deleteObject:category];
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark SCTableViewModelDelegate methods

- (void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    button1.hidden = [self valid] ? NO : YES;
}

@end

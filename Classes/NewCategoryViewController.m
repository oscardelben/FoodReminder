//
//  NewCategoryViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/11/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "NewCategoryViewController.h"
#import "FoodReminderAppDelegate.h"

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // TODO: done button should be disabled when name is blank
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = doneButton;
    
    self.title = @"New Category";
    
    [cancelButton release];
    [doneButton release];
    
    // Instantiate the table model
    tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
    
    SCTableViewSection *section = [SCTableViewSection section];
    [tableModel addSection:section];
    
    SCTextFieldCell *nameCell = [SCTextFieldCell cellWithText:@"Name" withBoundObject:category withPropertyName:@"name"];
    [section addCell:nameCell];
}

- (void)dealloc
{
    [parentController release];
    [tableModel release];
    [super dealloc];
}

- (void)save
{
    [parentController performSelector:@selector(dismissController)];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)cancel
{
    [managedObjectContext deleteObject:category];
    [self dismissModalViewControllerAnimated:YES];
}

@end

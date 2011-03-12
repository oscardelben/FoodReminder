//
//  NewEntryViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/12/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "NewEntryViewController.h"
#import "FoodReminderAppDelegate.h"

@implementation NewEntryViewController

@synthesize parentController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        managedObjectContext = 
		[(FoodReminderAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        
        entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:managedObjectContext];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // TODO: done button should be disabled when name or category is blank
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = doneButton;
    
    self.title = @"New Entry";
    
    [cancelButton release];
    [doneButton release];
    
    tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
    
    SCTableViewSection *section = [SCTableViewSection section];
    [tableModel addSection:section];
    
    // Name
    SCTextFieldCell *nameCell = [SCTextFieldCell cellWithText:@"Name" withBoundObject:entry withPropertyName:@"name"];
    [section addCell:nameCell];
    
    // Category
    SCClassDefinition *categoryDef = [SCClassDefinition definitionWithEntityName:@"Category" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];

    SCSelectionCell *categoryCell = [SCObjectSelectionCell cellWithText:@"Category" withBoundObject:entry withPropertyName:@"category"];
    [categoryCell setAttributesTo:[SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:categoryDef withItemsTitlePropertyName:@"name" allowMultipleSelection:NO allowNoSelection:NO]];
    categoryCell.autoDismissDetailView = YES;
    
    [section addCell:categoryCell];
    
    // buttons
    // create custom view
    // use the blur? transition for save and create new
    
    UIView *buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    // TODO: use fancy buttons
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame = CGRectMake(20, 10, 150, 30);
    [button1 setTitle:@"Text 1" forState:UIControlStateNormal];
    [buttonsView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(170, 10, 150, 30);
    [button2 setTitle:@"Text 2" forState:UIControlStateNormal];
    [buttonsView addSubview:button2];
    
    section.footerView = buttonsView;
    [buttonsView release];
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
    [managedObjectContext deleteObject:entry];
    [self dismissModalViewControllerAnimated:YES];
}


@end

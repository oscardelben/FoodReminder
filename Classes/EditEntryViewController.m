//
//  EditEntryViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/14/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "EditEntryViewController.h"
#import "FoodReminderAppDelegate.h"
#import "GradientButton.h"
#import "NSString+DBExtensions.h"

@implementation EditEntryViewController

@synthesize entry;
@synthesize parentController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        managedObjectContext = 
		[(FoodReminderAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    }
    return self;
}

- (BOOL)valid
{
    NSString *name = [entry valueForKey:@"name"];
    
    return (name && ![name blank]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
    
    if (![self valid]) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    self.navigationItem.hidesBackButton = YES;
    
    self.title = @"Edit Entry";
    
    // table model
    tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
    tableModel.delegate = self;
    
    SCTableViewSection *section = [SCTableViewSection section];
    [tableModel addSection:section];
    
    // Name
    SCTextFieldCell *nameCell = [SCTextFieldCell cellWithText:@"Name" withBoundObject:entry withPropertyName:@"name"];
    [section addCell:nameCell];
    
    // Due To
    SCDateCell *dateCell = [SCDateCell cellWithText:@"Due to" withBoundObject:entry withDatePropertyName:@"due_to"];
    [section addCell:dateCell];
    
    // buttons
    
    UIView *buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    button1 = [[GradientButton alloc] initWithFrame:CGRectMake(20, 10, 120, 30)];
    [button1 useRedDeleteStyle];
    [button1 setTitle:@"Delete" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [buttonsView addSubview:button1];
    
    section.footerView = buttonsView;
    [buttonsView release];
}

- (void)dealloc
{
    [tableModel release];
    [button1 release];
    [super dealloc];
}

- (void)save
{
    if ([self valid]) {
        [parentController performSelector:@selector(reloadEntries)];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)remove
{
    [managedObjectContext deleteObject:entry];
    
    [parentController performSelector:@selector(reloadEntries)];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark SCTableViewModelDelegate methods

- (void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self valid])
        self.navigationItem.rightBarButtonItem.enabled = YES;
    else
        self.navigationItem.rightBarButtonItem.enabled = NO;
}

@end

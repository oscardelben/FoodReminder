//
//  EditEntryViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/14/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "EditEntryViewController.h"
#import "FoodReminderAppDelegate.h"
#import "NSString+DBExtensions.h"

@implementation EditEntryViewController

@synthesize tableView;
@synthesize doneButton;
@synthesize entry;
@synthesize parentController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    
    self.navigationItem.hidesBackButton = YES;
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = [UIColor blackColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.title = @"Edit Entry";
    
    if (![self valid])
        doneButton.hidden = YES;
    
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
}

- (void)dealloc
{
    [tableModel release];
    [tableView release];
    [doneButton release];
    [super dealloc];
}

- (IBAction)save:(id)sender;
{
    if ([self valid]) {
        [parentController performSelector:@selector(reloadEntries)];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)remove:(id)sender;
{
    [managedObjectContext deleteObject:entry];
    
    [parentController performSelector:@selector(reloadEntries)];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark SCTableViewModelDelegate methods

- (void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableBackground"]];
    cell.textLabel.textColor = [UIColor colorWithRed:119/255.0 green:79/255.0 blue:56/255.0 alpha:1];
}

- (void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self valid])
        doneButton.hidden = YES;
    else
        doneButton.hidden = NO;
}

@end

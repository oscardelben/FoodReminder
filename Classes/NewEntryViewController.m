//
//  NewEntryViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/12/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "NewEntryViewController.h"
#import "FoodReminderAppDelegate.h"
#import "NSString+DBExtensions.h"

@implementation NewEntryViewController

@synthesize parentController;
@synthesize tableView;
@synthesize saveButton, saveAndCreateButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        managedObjectContext = 
		[(FoodReminderAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

        entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:managedObjectContext];
        [entry setValue:[NSDate date] forKey:@"due_to"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = [UIColor blackColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
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
    dateCell.datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    dateCell.dateFormatter = dateFormatter;
    [section addCell:dateCell];
    
    // buttons
    
    saveButton.hidden = YES;
    saveAndCreateButton.hidden = YES;
}

- (void)dealloc
{
    [tableModel release];
    [tableView release];
    [saveButton release];
    [saveAndCreateButton release];
    
    [super dealloc];
}

- (BOOL)valid
{
    NSString *name = [entry valueForKey:@"name"];
    
    return (name && ![name blank]);
}

- (IBAction)save:(id)sender;
{
    if (![self valid])
        [managedObjectContext deleteObject:entry];

    [parentController performSelector:@selector(reloadEntries)];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)saveAndCreateNew:(id)sender;
{
    if (![self valid])
        [managedObjectContext deleteObject:entry];
    
    [parentController performSelector:@selector(reloadEntries)];
    [self dismissModalViewControllerAnimated:NO];
    [parentController performSelector:@selector(createNewEntryWithCurlAnimation)];
}

- (IBAction)cancel:(id)sender;
{
    [managedObjectContext deleteObject:entry];
    
    [parentController performSelector:@selector(reloadEntries)];
    [self dismissModalViewControllerAnimated:YES];
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
    BOOL valid = [self valid];

    if (valid && saveButton.hidden)
    {
        saveButton.hidden = NO;
        saveAndCreateButton.hidden = NO;
    }
    else if (!valid && !saveButton.hidden)
    {
        saveButton.hidden = YES;
        saveAndCreateButton.hidden = YES;
    }
}

@end

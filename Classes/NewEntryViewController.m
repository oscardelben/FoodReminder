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
#import "ClassyButton.h"

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

- (void)dealloc
{
    [tableModel release];
    [tableView release];
    [saveButton release];
    [saveAndCreateButton release];
    
    [super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
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
    //tableModel.delegate = self;
    
    SCTableViewSection *section = [SCTableViewSection section];
    [tableModel addSection:section];
    
    // Name
    SCTextFieldCell *nameCell = [SCTextFieldCell cellWithText:@"Name" withBoundObject:entry withPropertyName:@"name"];
    nameCell.textLabel.font = [UIFont fontWithName:@"BrushScriptStd" size:20];
    nameCell.textField.textAlignment = UITextAlignmentRight;
    [section addCell:nameCell];
    
    // Due To
    SCDateCell *dateCell = [SCDateCell cellWithText:@"Due to" withBoundObject:entry withDatePropertyName:@"due_to"];
    dateCell.textLabel.font = [UIFont fontWithName:@"BrushScriptStd" size:20];
    dateCell.datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    dateCell.dateFormatter = dateFormatter;
    [section addCell:dateCell];
    
    // buttons
    
    UIView *buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    saveButton = [[ClassyButton alloc] initWithFrame:CGRectMake(21, 17, 120, 30)];
    saveButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    saveButton.hidden = YES;
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [buttonsView addSubview:saveButton];
    
    saveAndCreateButton = [[ClassyButton alloc] initWithFrame:CGRectMake(160, 17, 140, 30)];
    saveAndCreateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    saveAndCreateButton.hidden = YES;
    [saveAndCreateButton setTitle:@"Save & New" forState:UIControlStateNormal];
    [saveAndCreateButton addTarget:self action:@selector(saveAndCreateNew) forControlEvents:UIControlEventTouchUpInside];
    [buttonsView addSubview:saveAndCreateButton];
    
    section.footerView = buttonsView;
    [buttonsView release];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    ClassyButton *cancelButton = [[ClassyButton alloc] initWithFrame:CGRectMake(17, 10, 74, 37)];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:cancelButton];
    
    section.headerView = headerView;
    [cancelButton release];
}


- (BOOL)valid
{
    NSString *name = [entry valueForKey:@"name"];
    
    return (name && ![name blank]);
}

- (IBAction)save;
{
    if (![self valid])
        [managedObjectContext deleteObject:entry];

    [parentController performSelector:@selector(reloadEntries)];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)saveAndCreateNew;
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

    if (valid)
    {
        saveButton.hidden = NO;
        saveAndCreateButton.hidden = NO;
    }
    else
    {
        saveButton.hidden = YES;
        saveAndCreateButton.hidden = YES;
    }
}

@end

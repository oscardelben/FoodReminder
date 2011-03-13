//
//  NewEntryViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/12/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "NewEntryViewController.h"
#import "FoodReminderAppDelegate.h"
#import "GradientButton.h"
#import "NSString+DBExtensions.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
    
    self.title = @"New Entry";
    
    // table model
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
    
    UIView *buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    button1 = [[GradientButton alloc] initWithFrame:CGRectMake(20, 10, 120, 30)];
    [button1 useBlackStyle];
    button1.hidden = YES;
    [button1 setTitle:@"Save" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [buttonsView addSubview:button1];
    
    button2 = [[GradientButton alloc] initWithFrame:CGRectMake(180, 10, 120, 30)];
    [button2 useBlackStyle];
    button2.hidden = YES;
    [button2 setTitle:@"Add New" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(saveAndCreateNew) forControlEvents:UIControlEventTouchUpInside];
    [buttonsView addSubview:button2];
    
    section.footerView = buttonsView;
    [buttonsView release];
}

- (void)dealloc
{
    [parentController release];
    [tableModel release];
    [button1 release];
    [button2 release];
    [super dealloc];
}

- (BOOL)valid
{
    NSString *name = [entry valueForKey:@"name"];
    NSManagedObject *category = [entry valueForKey:@"category"];
    
    return (name && ![name blank] && category);
}

- (void)save
{
    if (![self valid])
        [managedObjectContext deleteObject:entry];
    
    [parentController performSelector:@selector(dismissController)];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)saveAndCreateNew
{
    if (![self valid])
        [managedObjectContext deleteObject:entry];
    
    [self dismissModalViewControllerAnimated:NO];
    [parentController performSelector:@selector(createNewEntryWithCurlAnimation)];
}

- (void)cancel
{
    [managedObjectContext deleteObject:entry];
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark SCTableViewModelDelegate methods

- (void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL valid = [self valid];

    if (valid && button1.hidden)
    {
        button1.hidden = NO;
        button2.hidden = NO;
    }
    else if (!valid && !button1.hidden)
    {
        button1.hidden = YES;
        button2.hidden = YES;
    }
}

@end

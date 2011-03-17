//
//  RootViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/9/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "CategoriesViewController.h"
#import "FoodReminderAppDelegate.h"
#import "EntriesViewController.h"
#import "ItemChoiceViewController.h"
#import "Entry.h"

@implementation CategoriesViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Categories";
    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
	
	NSManagedObjectContext *managedObjectContext = 
		[(FoodReminderAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
	
	SCClassDefinition *categoryDef =
	[SCClassDefinition definitionWithEntityName:@"Category" withManagedObjectContext:managedObjectContext
							  withPropertyNames: [NSArray arrayWithObjects:@"name", nil]];
	
	tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
	
	// Create and add the objects section
	SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil
																	withEntityClassDefinition:categoryDef];
	objectsSection.allowEditDetailView = FALSE;
	
	[tableModel addSection:objectsSection];
}

// I hate having to reload data every single time, 
// but keeping a reference for every table is insane. 
// Needs a better way
- (void)viewDidAppear:(BOOL)animated
{
    [tableModel reloadBoundValues];
    [tableModel.modeledTableView reloadData];
}

- (void)dealloc {
	[tableModel release];
    [super dealloc];
}

#pragma mark -
#pragma mark Add button

- (void)insertNewObject
{
    ItemChoiceViewController *controller = [[ItemChoiceViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

#pragma mark -
#pragma mark SCTableViewModelDelegate

- (void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	SCArrayOfObjectsSection *section = (SCArrayOfObjectsSection *)[tableViewModel 
																   sectionAtIndex:indexPath.section];
	NSManagedObject *category = [section.items objectAtIndex:indexPath.row];
	
	EntriesViewController *entriesViewController = [[EntriesViewController alloc] initWithStyle:UITableViewStylePlain];
	entriesViewController.category = category;
	
	[self.navigationController pushViewController:entriesViewController animated:YES];
	[entriesViewController release];
}


- (void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCArrayOfObjectsSection *section = (SCArrayOfObjectsSection *)[tableViewModel 
																   sectionAtIndex:indexPath.section];
	Category *category = (Category *)[section.items objectAtIndex:indexPath.row];
    
    int sum = [Entry expiringTodayWithCategory:category];
    
    if (sum > 0)
        cell.badgeView.text = [NSString stringWithFormat:@"%i", sum];
}

@end


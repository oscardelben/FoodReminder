//
//  EntriesViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/9/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "EntriesViewController.h"
#import "FoodReminderAppDelegate.h"
#import "EditEntryViewController.h"

@implementation EntriesViewController

@synthesize category;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
	self.title = [category valueForKey:@"name"];
    
	NSManagedObjectContext *managedObjectContext = 
        [(FoodReminderAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
	
	SCClassDefinition *entryDef =
	[SCClassDefinition definitionWithEntityName:@"Entry" withManagedObjectContext:managedObjectContext
							  withPropertyNames: [NSArray arrayWithObjects:@"name", @"category", @"due_to", nil]];

    // order
    entryDef.keyPropertyName = @"due_to";
    // table model
    
	tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
    tableModel.delegate = self;
	
	// Create and add the objects section
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category = %@", category];
    
    SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil withEntityClassDefinition:entryDef usingPredicate:predicate];
    objectsSection.allowEditDetailView = NO;
    
	[tableModel addSection:objectsSection];
}

- (void)reloadEntries
{
    [tableModel reloadBoundValues];
    [tableModel.modeledTableView reloadData];
}

 
- (void)dealloc {	
    [category release];
	[tableModel release];
    [super dealloc];
}

#pragma mark -
#pragma mark SCTableViewModelDelegate Methods

- (void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Detail Text Label
    SCArrayOfObjectsSection *section = (SCArrayOfObjectsSection *)[tableViewModel 
																   sectionAtIndex:indexPath.section];
	NSManagedObject *entry = [section.items objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    cell.detailTextLabel.text = [dateFormatter stringFromDate:[entry valueForKey:@"due_to"]];
}

- (void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCArrayOfObjectsSection *section = (SCArrayOfObjectsSection *)[tableViewModel 
																   sectionAtIndex:indexPath.section];
	NSManagedObject *entry = [section.items objectAtIndex:indexPath.row];
    
    EditEntryViewController *editViewController = [[EditEntryViewController alloc] initWithStyle:UITableViewStyleGrouped];
    editViewController.entry = entry;
    editViewController.parentController = self;
    
    [self.navigationController pushViewController:editViewController animated:YES];
    [editViewController release];
}

@end
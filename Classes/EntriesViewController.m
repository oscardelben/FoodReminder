//
//  EntriesViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/9/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "EntriesViewController.h"
#import "FoodReminderAppDelegate.h"

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
							  withPropertyNames: [NSArray arrayWithObjects:@"name", nil]];
	
	tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
    tableModel.delegate = self;
	
	// Create and add the objects section
	SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil
																	withEntityClassDefinition:entryDef];
	objectsSection.allowEditDetailView = FALSE;
	
	[tableModel addSection:objectsSection];
}

- (void)dealloc {	[category release];
	[tableModel release];
    [super dealloc];
}

#pragma mark -
#pragma mark SCTableViewModelDelegate Methods

- (void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCArrayOfObjectsSection *section = (SCArrayOfObjectsSection *)[tableViewModel 
																   sectionAtIndex:indexPath.section];
	NSManagedObject *entry = [section.items objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text = [entry valueForKeyPath:@"category.name"];
}

@end
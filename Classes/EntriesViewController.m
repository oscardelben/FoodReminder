//
//  EntriesViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/9/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "EntriesViewController.h"
#import "FoodReminderAppDelegate.h"
#import "NewEntryViewController.h"
#import "SettingsViewController.h"

@implementation EntriesViewController

@synthesize tableView;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = [UIColor blackColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
	NSManagedObjectContext *managedObjectContext = 
        [(FoodReminderAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
	
	SCClassDefinition *entryDef =
	[SCClassDefinition definitionWithEntityName:@"Entry" withManagedObjectContext:managedObjectContext
							  withPropertyNames: [NSArray arrayWithObjects:@"name", @"due_to", nil]];

    // order
    entryDef.keyPropertyName = @"due_to";
    
    // table model    
	tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
    tableModel.delegate = self;
	
    SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil withEntityClassDefinition:entryDef];
    objectsSection.allowEditDetailView = NO;
    
	[tableModel addSection:objectsSection];
}

- (void)dealloc {	
	[tableModel release];
    [tableView release];
    [super dealloc];
}

- (void)showSettings
{
    SettingsViewController *viewController = [[SettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self.navigationController presentModalViewController:navController animated:YES];
    
    [viewController release];
    [navController release];
}

- (IBAction)addEntry:(id)sender;
{
    NewEntryViewController *viewController = [[NewEntryViewController alloc] initWithNibName:@"NewEntryViewController" bundle:nil];
    viewController.parentController = self;
    
    [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:viewController animated:YES];

    [viewController release];
}

- (void)createNewEntryWithCurlAnimation
{
    NewEntryViewController *viewController = [[NewEntryViewController alloc] initWithNibName:@"NewEntryViewController" bundle:nil];
    viewController.parentController = self;
    
    UINavigationController *detailNavController = [[UINavigationController alloc] 
                                                   initWithRootViewController:viewController];
    
    [UIView beginAnimations:nil context:NULL];
    [self.navigationController presentModalViewController:detailNavController animated:NO];
    
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:viewController.view.window cache:NO];
    
    [UIView commitAnimations];
}

- (void)reloadEntries
{
    [tableModel reloadBoundValues];
    [tableModel.modeledTableView reloadData];
}


#pragma mark -
#pragma mark SCTableViewModelDelegate Methods

- (void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableBackground"]];
    cell.textLabel.textColor = [UIColor colorWithRed:119/255.0 green:79/255.0 blue:56/255.0 alpha:1];
    
    // Detail Text Label
    SCArrayOfObjectsSection *section = (SCArrayOfObjectsSection *)[tableViewModel 
																   sectionAtIndex:indexPath.section];
	NSManagedObject *entry = [section.items objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    //cell.detailTextLabel.text = [dateFormatter stringFromDate:[entry valueForKey:@"due_to"]];
    //cell.detailTextLabel.textColor = [UIColor colorWithRed:119/255.0 green:79/255.0 blue:56/255.0 alpha:1];
    
    SCBadgeView *badge = [[SCBadgeView alloc] init];
    cell.badgeView.text = [dateFormatter stringFromDate:[entry valueForKey:@"due_to"]];
    cell.badgeView.color = [UIColor colorWithRed:119/255.0 green:79/255.0 blue:56/255.0 alpha:1];
    //cell.badgeView.font = [UIFont fontWithName:@"Helvetica" size:12];
    cell.highlighted = YES;
    [badge release];
}

/*
- (void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCArrayOfObjectsSection *section = (SCArrayOfObjectsSection *)[tableViewModel 
																   sectionAtIndex:indexPath.section];
	NSManagedObject *entry = [section.items objectAtIndex:indexPath.row];
    
    EditEntryViewController *editViewController = [[EditEntryViewController alloc] initWithNibName:@"EditEntryViewController" bundle:nil];
    editViewController.entry = entry;
    editViewController.parentController = self;
    
    [self.navigationController pushViewController:editViewController animated:YES];
    [editViewController release];
}
*/

@end
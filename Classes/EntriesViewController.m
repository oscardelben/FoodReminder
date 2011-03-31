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
#import "InformationViewController.h"
#import "InstructionsViewController.h"
#import "Entry.h"

@implementation EntriesViewController

@synthesize tableView;
@synthesize appTitle;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Show instructions
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"instructions-shown"]) {
        InstructionsViewController *viewController = [[InstructionsViewController alloc] initWithNibName:@"InstructionsViewController" bundle:nil];
        [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentModalViewController:viewController animated:NO];
        [viewController release];
    }
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = [UIColor blackColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    appTitle.font = [UIFont fontWithName:@"BrushScriptStd" size:48];
    
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
    [appTitle release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait || 
            toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown;
}

- (IBAction)addEntry:(id)sender;
{
    NewEntryViewController *viewController = [[NewEntryViewController alloc] initWithStyle:UITableViewStyleGrouped];
    viewController.parentController = self;
    
    [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:viewController animated:YES];

    [viewController release];
}

- (void)createNewEntryWithCurlAnimation
{
    NewEntryViewController *viewController = [[NewEntryViewController alloc] initWithStyle:UITableViewStyleGrouped];
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

- (IBAction)showInformation:(id)sender
{
    InformationViewController *viewController = [[InformationViewController alloc] initWithNibName:@"InformationViewController" bundle:nil];
    [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:viewController animated:YES];
    [viewController release];
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
	Entry *entry = (Entry *)[section.items objectAtIndex:indexPath.row];
    
    SCBadgeView *badge = [[SCBadgeView alloc] init];
    cell.badgeView.text = [entry readableDate];
    cell.badgeView.color = [UIColor colorWithRed:119/255.0 green:79/255.0 blue:56/255.0 alpha:1];
    cell.highlighted = YES;
    [badge release];
}


@end
//
//  ItemChoiceViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/11/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "ItemChoiceViewController.h"
#import "FoodReminderAppDelegate.h"
#import "NewCategoryViewController.h"
#import "NewEntryViewController.h"

#define kCategoryIndex 0
#define kEntryIndex 1

@implementation ItemChoiceViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Select";
    
    tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
    
    SCArrayOfStringsSection *section = [SCArrayOfStringsSection sectionWithHeaderTitle:nil withItems:[NSArray arrayWithObjects:@"Category", @"Entry", nil]];
    
    section.allowDeletingItems = FALSE;
    section.allowEditDetailView = FALSE;
	
	[tableModel addSection:section];
}

- (void)dealloc
{
    [tableModel release];
    [super dealloc];
}

- (void)dismissController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark SCTableViewModelDelegate methods

- (void)presentNewCategoryViewController
{
    NewCategoryViewController *viewController = [[NewCategoryViewController alloc] initWithStyle:UITableViewStyleGrouped];
    viewController.parentController = self;
    
    UINavigationController *detailNavController = [[UINavigationController alloc] 
                                                   initWithRootViewController:viewController];
    
    [self.navigationController presentModalViewController:detailNavController animated:YES];
    
    [viewController release];
    [detailNavController release];
}

- (void)presentNewEntryViewController
{
    NewEntryViewController *viewController = [[NewEntryViewController alloc] initWithStyle:UITableViewStyleGrouped];
    viewController.parentController = self;
    
    UINavigationController *detailNavController = [[UINavigationController alloc] 
                                                   initWithRootViewController:viewController];
    
    [self.navigationController presentModalViewController:detailNavController animated:YES];
    
    [viewController release];
    [detailNavController release];
}

- (void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case kCategoryIndex:
        {
            [self presentNewCategoryViewController];
        }
            break;
        case kEntryIndex:
        {
            [self presentNewEntryViewController];
        }
            break;
    }
}

@end

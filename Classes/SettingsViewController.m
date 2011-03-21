//
//  SettingsViewController.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/19/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "SettingsViewController.h"


@implementation SettingsViewController

- (void)viewDidLoad
{
    self.title = @"Help";
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    
    [doneButton release];
    
    tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
    
    SCArrayOfStringsSection *section = [SCArrayOfStringsSection sectionWithHeaderTitle:nil withItems:[NSArray arrayWithObjects:@"Foo", @"Bar", nil]];
    section.allowEditDetailView = NO;
    section.allowDeletingItems = NO;
    
    [tableModel addSection:section];
}

- (void)done
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end

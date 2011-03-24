//
//  EntriesViewController.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/9/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"
#import <QuartzCore/QuartzCore.h>

@interface EntriesViewController : UIViewController <SCTableViewModelDelegate> {
	SCTableViewModel *tableModel;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UILabel *appTitle;

- (void)reloadEntries;
- (IBAction)addEntry:(id)sender;

@end

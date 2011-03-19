//
//  EntriesViewController.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/9/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"

@interface EntriesViewController : UITableViewController <SCTableViewModelDelegate> {
	SCTableViewModel *tableModel;
}

- (void)reloadEntries;

@end

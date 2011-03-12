//
//  ItemChoiceViewController.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/11/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"

@interface ItemChoiceViewController : UITableViewController <SCTableViewModelDelegate> {
    SCTableViewModel *tableModel;
    
    SCTableViewModel *categoriesTableModel;
}

- (void)dismissController;

@end

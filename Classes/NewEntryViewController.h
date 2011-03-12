//
//  NewEntryViewController.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/12/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"

@interface NewEntryViewController : UITableViewController {
    NSManagedObject *entry;
    
    SCTableViewModel *tableModel;
    
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) id parentController;

@end

//
//  EditEntryViewController.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/14/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"

@class GradientButton;

@interface EditEntryViewController : UITableViewController <SCTableViewModelDelegate> {
    SCTableViewModel *tableModel;
    
    NSManagedObjectContext *managedObjectContext;
    
    GradientButton *button1;
}

@property (nonatomic, retain) NSManagedObject *entry;
@property (nonatomic, retain) id parentController;

@end
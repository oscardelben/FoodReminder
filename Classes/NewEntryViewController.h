//
//  NewEntryViewController.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/12/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"

@class GradientButton;

@interface NewEntryViewController : UITableViewController <SCTableViewModelDelegate> {
    NSManagedObject *entry;
    
    SCTableViewModel *tableModel;
    
    NSManagedObjectContext *managedObjectContext;
    
    GradientButton *button1;
    GradientButton *button2;
}

@property (nonatomic, retain) id parentController;

@end

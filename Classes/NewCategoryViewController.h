//
//  NewCategoryViewController.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/11/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"

@class GradientButton;

@interface NewCategoryViewController : UITableViewController <SCTableViewModelDelegate> {
    NSManagedObject *category;
    SCTableViewModel *tableModel;
    
    NSManagedObjectContext *managedObjectContext;
    
    GradientButton *button1;
}

@property (nonatomic, retain) id parentController;

@end

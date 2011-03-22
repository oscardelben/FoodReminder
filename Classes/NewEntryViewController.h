//
//  NewEntryViewController.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/12/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"

@class ClassyButton;

@interface NewEntryViewController : UIViewController <SCTableViewModelDelegate> {
    NSManagedObject *entry;
    
    SCTableViewModel *tableModel;
    
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) id parentController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) ClassyButton *saveButton;
@property (nonatomic, retain) ClassyButton *saveAndCreateButton;

- (IBAction)cancel:(id)sender;
- (IBAction)save;
- (IBAction)saveAndCreateNew;

@end

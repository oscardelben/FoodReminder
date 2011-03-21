//
//  EditEntryViewController.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/14/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"

@interface EditEntryViewController : UIViewController <SCTableViewModelDelegate> {
    SCTableViewModel *tableModel;
    
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIButton *doneButton;
@property (nonatomic, retain) NSManagedObject *entry;
@property (nonatomic, retain) id parentController;

- (IBAction)save:(id)sender;
- (IBAction)remove:(id)sender;

@end
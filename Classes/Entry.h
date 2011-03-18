//
//  Entry.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/17/11.
//  Copyright (c) 2011 DibiStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Entry : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * due_to;

+ (int)expiringToday;

@end

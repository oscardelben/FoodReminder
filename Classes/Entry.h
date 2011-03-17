//
//  Entry.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/17/11.
//  Copyright (c) 2011 DibiStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Entry : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * due_to;
@property (nonatomic, retain) Category * category;

+ (int)expiringToday;
+ (int)expiringTodayWithCategory:(Category *)category;

@end

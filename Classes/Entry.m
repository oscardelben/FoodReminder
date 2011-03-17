//
//  Entry.m
//  FoodReminder
//
//  Created by Oscar Del Ben on 3/17/11.
//  Copyright (c) 2011 DibiStore. All rights reserved.
//

#import "Entry.h"
#import "FoodReminderAppDelegate.h"
#import "NSDate+Calculations.h"

@implementation Entry
@dynamic name;
@dynamic due_to;
@dynamic category;

+ (int)expiringToday
{
    NSManagedObjectContext *managedObjectContext = 
    [(FoodReminderAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entry" inManagedObjectContext:managedObjectContext]; 
    
    NSFetchRequest *fetchReq = [[[NSFetchRequest alloc] init] autorelease];
    [fetchReq setEntity:entity];
    [fetchReq setIncludesSubentities:NO];
    [fetchReq setPredicate:[NSPredicate predicateWithFormat:@"due_to <= %@", [[NSDate date] endOfDay]]];
    
    NSError *error;
    return [managedObjectContext countForFetchRequest:fetchReq error:&error];
}

+ (int)expiringTodayWithCategory:(Category *)category
{
    NSManagedObjectContext *managedObjectContext = 
    [(FoodReminderAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entry" inManagedObjectContext:managedObjectContext]; 
    
    NSFetchRequest *fetchReq = [[[NSFetchRequest alloc] init] autorelease];
    [fetchReq setEntity:entity];
    [fetchReq setIncludesSubentities:NO];
    [fetchReq setPredicate:[NSPredicate predicateWithFormat:@"(category = %@) AND (due_to <= %@)", category, [[NSDate date] endOfDay]]];
    
    NSError *error;
    return [managedObjectContext countForFetchRequest:fetchReq error:&error];
}

@end

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

- (NSString *)readableDate
{
    NSDate *date = [self valueForKey:@"due_to"];
    
    if ([date today])
    {
        return @"Today";
    }
    else if ([[date tomorrow] today])
    {
        return @"Yesterday";
    }
    else if ([[date yesterday] today])
    {
        return @"Tomorrow";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
        return [dateFormatter stringFromDate:date];
    }
}

@end

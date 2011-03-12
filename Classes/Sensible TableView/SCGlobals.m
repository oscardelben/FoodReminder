/*
 *  SCGlobals.m
 *  Sensible TableView
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. YOU SHALL NOT DEVELOP NOR
 *	MAKE AVAILABLE ANY WORK THAT COMPETES WITH A SENSIBLE COCOA PRODUCT DERIVED FROM THIS 
 *	SOURCE CODE. THIS SOURCE CODE MAY NOT BE RESOLD OR REDISTRIBUTED ON A STAND ALONE BASIS.
 *
 *	USAGE OF THIS SOURCE CODE IS BOUND BY THE LICENSE AGREEMENT PROVIDED WITH THE 
 *	DOWNLOADED PRODUCT.
 *
 *  Copyright 2010 Sensible Cocoa. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import "SCGlobals.h"
#import "SCClassDefinition.h"


@implementation SCHelper

+ (double)systemVersion
{
	return [[[UIDevice currentDevice] systemVersion] doubleValue];
}

+ (BOOL)is_iPad
{
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}

+ (BOOL)isViewInsidePopover:(UIView *)view
{
	BOOL inPopover = FALSE;
	while (view.superview)
	{
		if (strcmp(object_getClassName(view.superview), "UIPopoverView"))
		{
			inPopover = TRUE;
			break;
		}
		view = view.superview;
	}
	
	return inPopover;
}

+ (NSObject *)getFirstNodeInNibWithName:(NSString *)nibName
{
	NSArray *topLevelNodes = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
	if([topLevelNodes count])
		return [topLevelNodes objectAtIndex:0];
	//else
	return nil;
}

+ (NSMutableArray *)generateObjectsArrayForEntityClassDefinition:(SCClassDefinition *)classDef
										   usingPredicate:(NSPredicate *)predicate
{
	NSMutableArray *objectsArray = nil;
	
#ifdef _COREDATADEFINES_H
	if(classDef.entity)
	{
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		[fetchRequest setEntity:classDef.entity];
		if(predicate)
			[fetchRequest setPredicate:predicate];
		NSString *key;
		if(classDef.orderAttributeName)
			key = classDef.orderAttributeName;
		else
			key = classDef.keyPropertyName;
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] 
											initWithKey:key 
											ascending:YES];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[fetchRequest setSortDescriptors:sortDescriptors];
		
		objectsArray = [NSMutableArray arrayWithArray:[classDef.managedObjectContext 
													   executeFetchRequest:fetchRequest
													   error:NULL]];
		
		[sortDescriptor release];
		[sortDescriptors release];
		[fetchRequest release];
	}
#endif
	
	return objectsArray;
}

+ (NSObject *)valueForPropertyName:(NSString *)propertyName inObject:(NSObject *)object
{
	if(!propertyName)
		return nil;
	
	NSArray *propertyNames = [propertyName componentsSeparatedByString:@";"];
	NSMutableArray *valuesArray = [NSMutableArray arrayWithCapacity:propertyNames.count];
	for(NSString *pName in propertyNames)
	{
		NSObject *value = nil;
		@try 
		{
			value = [object valueForKeyPath:pName];
		}
		@catch (NSException * e) 
		{
			// do nothing
		}
		if(!value)
			value = [NSNull null];
		[valuesArray addObject:value];
	}
	
	if(propertyNames.count > 1)
		return valuesArray;
	//else
	NSObject *value = [valuesArray objectAtIndex:0];
	if([value isKindOfClass:[NSNull class]])
		return nil;
	return value;
}

+ (NSString *)stringValueForPropertyName:(NSString *)propertyName inObject:(NSObject *)object
			separateValuesUsingDelimiter:(NSString *)delimiter
{
	NSObject *value = [SCHelper valueForPropertyName:propertyName inObject:object];
	
	NSMutableString *stringValue = [NSMutableString string];
	if([value isKindOfClass:[NSArray class]])
	{
		NSArray *stringsArray = (NSArray *)value;
		for(int i=0; i<stringsArray.count; i++)
		{
			NSObject *str = [stringsArray objectAtIndex:i];
			if(![str isKindOfClass:[NSNull class]])
			{
				if(i!=0 && delimiter)
					[stringValue appendString:delimiter];
				[stringValue appendString:[NSString stringWithFormat:@"%@", str]];
			}
		}
	}
	else
	{
		if(value)
			[stringValue appendFormat:@"%@", value];
	}
	
	return stringValue;
}

@end




@implementation SCTransparentToolbar

- (id) init
{
	if( (self = [super init]) )
	{
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		self.translucent = YES;
	}
	
	return self;
}

- (id) initWithFrame:(CGRect) frame
{
	if( (self = [super initWithFrame:frame]) )
	{
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		self.translucent = YES;
	}
	
	return self;
}

// overrides super class
- (void)drawRect:(CGRect)rect 
{
    // prevent an drawing here (do nothing)
}

@end


//
//  Person+CoreDataClass.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 12/9/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EXRColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSManagedObject

+ (Person *)personWithContext:(NSManagedObjectContext *)context;

+ (NSArray<Person *> *)personsWithContext:(NSManagedObjectContext *)context;

+ (NSArray<Person *> *)personsWithColor:(EXRSupportedColor)color
                                context:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Person+CoreDataProperties.h"

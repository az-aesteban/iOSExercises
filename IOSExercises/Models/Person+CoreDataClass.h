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

+ (Person *)createEmptyPersonWithContext:(NSManagedObjectContext *)aContext;

+ (NSArray<Person *> *)fetchAllPersonsWithContext:(NSManagedObjectContext *) aContext;

+ (NSArray<Person *> *)fetchPersonsWithColor:(EXRSupportedColor) aColor
                                 withContext:(NSManagedObjectContext *) aContext;

@end

NS_ASSUME_NONNULL_END

#import "Person+CoreDataProperties.h"

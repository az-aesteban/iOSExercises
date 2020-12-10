//
//  Person+CoreDataClass.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 12/9/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//
//

#import "Person+CoreDataClass.h"

static NSString *kEntityName = @"Person";

@implementation Person

#pragma mark - Creating Managed Object Methods

+ (Person *)createEmptyPersonWithContext:(NSManagedObjectContext *)aContext {
    return [NSEntityDescription insertNewObjectForEntityForName:kEntityName
                                         inManagedObjectContext:aContext];
}

#pragma mark - Fetching Object Methods

+ (NSArray<Person *> *)fetchAllPersonsWithContext:(NSManagedObjectContext *) aContext {

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kEntityName];

    NSError *error = nil;
    NSArray *results = [aContext executeFetchRequest:fetchRequest
                                               error:&error];

    if (!results) {
        NSLog(@"Person: Error fetching Person objects: %@\n%@", error.localizedDescription, error.userInfo);
    }

    return results;
}

+ (NSArray<Person *> *)fetchPersonsWithColor:(EXRSupportedColor) aColor
                                         withContext:(NSManagedObjectContext *) aContext {

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kEntityName];
    fetchRequest.predicate = [Person predicateWithColor:aColor];

    NSError *error = nil;
    NSArray *results = [aContext executeFetchRequest:fetchRequest
                                               error:&error];

    if (!results) {
        NSAssert2(NO, @"Person: Error fetching Person objects: %@\n%@", error.localizedDescription, error.userInfo);
    }

    return results;
}

+ (NSPredicate *)predicateWithColor:(EXRSupportedColor) aColor {
    return [NSPredicate predicateWithFormat:@"color = %ld", aColor];
}

@end

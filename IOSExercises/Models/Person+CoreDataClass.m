//
//  Person+CoreDataClass.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 12/9/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//
//

#import "Person+CoreDataClass.h"

static NSString *const kEntityName = @"Person";

@implementation Person

#pragma mark - Creating Managed Object Methods

+ (Person *)personWithContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:kEntityName
                                         inManagedObjectContext:context];
}

#pragma mark - Fetching Object Methods

+ (NSArray<Person *> *)personsWithContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kEntityName];

    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:fetchRequest
                                              error:&error];

    if (!results) {
        NSLog(@"Person: Error fetching Person objects: %@\n%@", error.localizedDescription, error.userInfo);
    }

    return results;
}

+ (NSArray<Person *> *)personsWithColor:(EXRSupportedColor)color
                                context:(NSManagedObjectContext *)context {

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kEntityName];
    fetchRequest.predicate = [Person predicateWithColor:color];

    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:fetchRequest
                                              error:&error];

    if (!results) {
        NSAssert2(NO, @"Person: Error fetching Person objects: %@\n%@", error.localizedDescription, error.userInfo);
    }

    return results;
}

+ (NSPredicate *)predicateWithColor:(EXRSupportedColor)color {
    return [NSPredicate predicateWithFormat:@"color = %ld", color];
}

- (void)setBirthdayWithMonth:(NSInteger)month
                         day:(NSInteger)day
                        year:(NSInteger)year {
    NSDateComponents *birthdayComponents = [[NSDateComponents alloc] init];
    [birthdayComponents setMonth:month];
    [birthdayComponents setDay:day];
    [birthdayComponents setYear:year];
    self.birthday = [[NSCalendar currentCalendar] dateFromComponents:birthdayComponents];
}

@end

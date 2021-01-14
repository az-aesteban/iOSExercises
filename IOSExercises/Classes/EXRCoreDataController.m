//
//  EXRCoreDataController.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 12/9/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRCoreDataController.h"
#import <CoreData/CoreData.h>

@implementation EXRCoreDataController

- (instancetype)initWithCompletionBlock:(void (^)(EXRCoreDataController *))callback {
    if (self = [super init]) {
        NSPersistentContainer *container = self.persistentContainer;
        if (!container) {
            NSAssert(NO, @"EXRCoreDataController: No Persistent Container found");
        } else {
            callback(self);
        }
    }
    return self;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (!_persistentContainer) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"IOSExercises"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"EXRCoreDateController: Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}

- (NSManagedObjectContext *) managedObjectContext {
    return self.persistentContainer.viewContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSError *error = nil;
    if ([self.managedObjectContext hasChanges]) {
        NSLog(@"EXRCoreDataController: Saving context");
        if (![self.managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"EXRCoreDateController: Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}

@end

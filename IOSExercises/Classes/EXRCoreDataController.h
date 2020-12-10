//
//  EXRCoreDataController.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 12/9/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface EXRCoreDataController : NSObject

@property (strong, nonatomic, readonly) NSPersistentContainer *persistentContainer;

- (id)initWithCompletionBlock:(void (^)(EXRCoreDataController *))callback;

- (void)saveContext;

- (NSManagedObjectContext *) managedObjectContext;

@end

NS_ASSUME_NONNULL_END

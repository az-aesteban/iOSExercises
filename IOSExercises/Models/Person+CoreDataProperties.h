//
//  Person+CoreDataProperties.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 12/9/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *birthday;

@property (nonatomic, assign) NSInteger color;

@property (nullable, nonatomic, copy) NSString *imageFilepath;

@property (nullable, nonatomic, copy) NSString *name;

- (void)setBirthdayWithMonth:(NSInteger)month
                         day:(NSInteger)day
                        year:(NSInteger)year;

@end

NS_ASSUME_NONNULL_END

//
//  EXRPerson.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/26/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXRColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXRPerson : NSObject

@property (strong, readwrite, nonatomic) NSString *imageFilepath;

@property (strong, readwrite, nonatomic) NSString *name;

@property (strong, readwrite, nonatomic) NSDate *birthday;

@property (strong, readwrite, nonatomic) EXRColor *color;

+ (instancetype)personWithName:(NSString *)aName
                      birthday:(NSDate *)aBirthday
                 imageFilepath:(NSString *)anImageFilePath
                         color:(EXRColor *)aColor;

- (BOOL)isBirthdayToday;

@end

NS_ASSUME_NONNULL_END
//
//  EXRPerson.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/26/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//
#import "EXRColor.h"
#import "EXRPerson.h"

@implementation EXRPerson

+ (instancetype)personWithName:(NSString *)aName
                      birthday:(NSDate *)aBirthday
                 imageFilepath:(NSString *)anImageFilepath
                         color:(EXRColor *)aColor {
    return [[self alloc] initPersonWithName:aName
                                   birthday:aBirthday
                              imageFilepath:anImageFilepath
                                      color:aColor];
}

- (instancetype)initPersonWithName:(NSString *)aName
                          birthday:(NSDate *)aBirthday
                     imageFilepath:(NSString *)anImageFilepath
                             color:(EXRColor *)aColor {
    if (self = [super init]) {
        _name = aName;
        _birthday = aBirthday;
        _imageFilepath = anImageFilepath;
        _color = aColor;
    }
    return self;
}

- (BOOL)isBirthdayToday {
    NSDateComponents *birthdayComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth
                                                                          fromDate:self.birthday];
    NSDateComponents *todayComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth
                                                                       fromDate:[NSDate date]];
    return (birthdayComponent.day == todayComponent.day
            && birthdayComponent.month == todayComponent.month);
}

@end

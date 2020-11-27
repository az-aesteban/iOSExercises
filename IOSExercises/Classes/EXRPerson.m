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

+ (instancetype)personNamed:(NSString *)aName
               withBirthday:(NSDate *)aBirthday
                   andImage:(NSString *)anImage
                 likesColor:(EXRColor *)aColor {
    return [[self alloc] initPersonWithName:aName
                               withBirthday:aBirthday
                                  withImage:anImage
                                   andColor:aColor];
}

- (instancetype)initPersonWithName:(NSString *)aName
                      withBirthday:(NSDate *)aBirthday
                         withImage:(NSString *)anImage
                          andColor:(EXRColor *)aColor {
    self = [super init];
    if (self) {
        self.name = aName;
        self.birthday = aBirthday;
        self.image = anImage;
        self.color = aColor;
    }
    return self;
}

-(BOOL)isBirthdayToday {
    NSDateComponents *birthdayComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth
                                                                          fromDate:self.birthday];
    NSDateComponents *todayComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth
                                                                       fromDate:[NSDate date]];
    return birthdayComponent.day == todayComponent.day
        && birthdayComponent.month == todayComponent.month;
}

@end

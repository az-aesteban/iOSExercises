//
//  ColorOption.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/24/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRColor.h"

#import "Person+CoreDataClass.h"

@interface EXRColor ()

@property (nonatomic, assign) NSInteger colorCode;

@end

@implementation EXRColor

+ (instancetype)supportedColor:(EXRSupportedColor)aSupportedColor {
    return [[EXRColor alloc] initWithSupportedColor:aSupportedColor];
}

- (instancetype)initWithSupportedColor:(EXRSupportedColor)aSupportedColor {
    if (self = [super init]) {
        switch (aSupportedColor) {
            case EXRSupportedColorBlue:
                self.uiColor = [UIColor blueColor];
                self.colorName = @"Blue";
                break;
            case EXRSupportedColorRed:
                self.uiColor = [UIColor redColor];
                self.colorName = @"Red";
                break;
            case EXRSupportedColorBlack:
                self.uiColor = [UIColor blackColor];
                self.colorName = @"Black";
                break;
            default:
                NSAssert(NO, @"EXRColor: Color not supported.");
        }
        self.colorCode = aSupportedColor;
    }
    return self;
}

+ (EXRSupportedColor)colorWithName:(NSString *)colorName {
    EXRSupportedColor supportedColor = EXRSupportedColorUnsupported;
    if ([colorName isEqualToString:@"Blue"]) {
        supportedColor = EXRSupportedColorBlue;
    } else if ([colorName isEqualToString:@"Red"]) {
        supportedColor = EXRSupportedColorRed;
    } else if ([colorName isEqualToString:@"Black"]) {
        supportedColor = EXRSupportedColorBlack;
    }
    return supportedColor;
}

@end

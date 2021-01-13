//
//  ColorOption.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/24/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRColor.h"

@implementation EXRColor

+ (instancetype)supportedColor:(EXRSupportedColor)aSuppportedColor {
    return [[EXRColor alloc] initWithSupportedColor:aSuppportedColor];
}

- (instancetype)initWithSupportedColor:(EXRSupportedColor)aSuppportedColor {
    if (self = [super init]) {
        switch (aSuppportedColor) {
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
    }
    return self;
}

@end

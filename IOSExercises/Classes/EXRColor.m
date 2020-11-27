//
//  ColorOption.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/24/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRColor.h"

@implementation EXRColor

+ (instancetype)colorNamed:(NSString *)aColorName {
    return [[EXRColor alloc] initColorWithName:aColorName];
}

- (instancetype)initColorWithName:(NSString *)aColorName {
    self = [super init];
    if (self) {
        self.uiColor = [UIColor colorNamed:aColorName];
        self.colorName = aColorName;
    }
    return self;
}

@end

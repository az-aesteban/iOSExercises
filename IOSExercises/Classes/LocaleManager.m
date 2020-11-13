//
//  LocaleManager.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/4/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocaleManager.h"

@implementation LocaleManager

- (NSString *)languageFromRegion {
    NSLog(@"%@", [[NSLocale currentLocale] countryCode]);
    NSString *countryCode = [[NSLocale currentLocale] countryCode];
    NSString *language;

    if (!countryCode) {
        countryCode = @"en";
//        NSAssert(NO, @"LocaleManager: No country code found for current locale.");
//        return language;
    }

    if ([countryCode isEqualToString:@"US"]) {
        language = @"en";
    } else if ([countryCode isEqualToString:@"JP"]) {
        language = @"ja";
    } else if ([countryCode isEqualToString:@"KR"]) {
        language = @"ko";
    } else if ([countryCode isEqualToString:@"ES"]) {
        language = @"es";
    } else if ([countryCode isEqualToString:@"SA"]) {
        language = @"ar";
    }

    return language;
}

+ (instancetype)sharedInstance {
    static LocaleManager *instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LocaleManager alloc] init];
        [instance setValue:[instance languageFromRegion]
                    forKey:@"preferredLanguage"];
    });

    return instance;
}

@end

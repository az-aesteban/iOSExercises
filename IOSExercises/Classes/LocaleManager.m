//
//  LocaleManager.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/4/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocaleManager.h"

@interface LocaleManager ()

@end

@implementation LocaleManager

static LocaleManager *localeManager = nil;

- (id)init {
    if (! localeManager) {
        localeManager = [super init];
    }
    return localeManager;
}

- (NSDictionary *) getRegions {
    return  @{
        SupportedRegionDefault: SupportedLanguageDefault,
        SupportedRegionUS: SupportedLanguageEnglish,
        SupportedRegionJapan: SupportedLanguageJapanese,
        SupportedRegionKorea: SupportedLanguageKorean,
        SupportedRegionSpain: SupportedLanguageSpanish,
        SupportedRegionSaudiArabia: SupportedLanguageArabic
    };
}

- (SupportedLanguage) getPreferredLanguage {
    return [[self getRegions] valueForKey:[[NSLocale currentLocale] countryCode]];
}

+(LocaleManager *) getManager {
    if (!localeManager) {
        localeManager = [[LocaleManager alloc] init];
    }
    return localeManager;
}


@end

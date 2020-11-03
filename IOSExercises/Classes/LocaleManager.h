//
//  LocaleManager.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/4/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString * SupportedRegion NS_STRING_ENUM;
static SupportedRegion SupportedRegionDefault = @"US";
static SupportedRegion SupportedRegionUS = @"US";
static SupportedRegion SupportedRegionSpain = @"ES";
static SupportedRegion SupportedRegionSaudiArabia = @"SA";
static SupportedRegion SupportedRegionJapan = @"JP";
static SupportedRegion SupportedRegionKorea = @"KR";

typedef NSString *SupportedLanguage NS_STRING_ENUM;
static SupportedLanguage SupportedLanguageDefault = @"en";
static SupportedLanguage SupportedLanguageEnglish = @"en";
static SupportedLanguage SupportedLanguageSpanish = @"es";
static SupportedLanguage SupportedLanguageArabic = @"ar";
static SupportedLanguage SupportedLanguageJapanese = @"ja";
static SupportedLanguage SupportedLanguageKorean = @"ko";


@interface LocaleManager : NSObject
-(SupportedLanguage)getPreferredLanguage;
+(LocaleManager *) getManager;
@end

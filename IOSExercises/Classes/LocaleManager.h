//
//  LocaleManager.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/4/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocaleManager : NSObject

@property(readonly, strong, nonatomic) NSString *preferredLanguage;

+ (instancetype)sharedInstance;

@end

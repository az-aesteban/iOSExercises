//
//  main.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 10/28/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Classes/LocaleManager.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AppleLanguages"];
        NSString *appLanguage = [[LocaleManager getManager] getPreferredLanguage];

        if (appLanguage == nil) {
            NSLog(@"Region is not supported. Setting English as default language.");
            appLanguage = SupportedLanguageDefault;
        }

        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:appLanguage, @"en", nil]
                                                  forKey:@"AppleLanguages"];

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

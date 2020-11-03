//
//  ProfileViewController.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 10/27/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (nonatomic, strong) NSMutableArray *landscapeConstraints;
@end

@implementation ProfileViewController

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
static SupportedLanguage SupportedLanguageArabic = @"ar-001";
static SupportedLanguage SupportedLanguageJapanese = @"ar-001";
static SupportedLanguage SupportedLanguageKorean = @"kr";

const CGFloat iPhoneProfileImageWidth = 150;
const CGFloat iPhoneProfileImageHeight = 150;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(OrientationChange:)
                                          name:UIDeviceOrientationDidChangeNotification
                                          object:nil];

    if (UIUserInterfaceIdiomPhone == [[UIDevice currentDevice] userInterfaceIdiom]) {
        [self activateIPhoneConstraints];
    }

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

#pragma mark - Notification handlers

-(void)OrientationChange:(NSNotification*) notification {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if (UIDeviceOrientationIsLandscape(orientation)) {
        [self activateLandscapeConstraints];
    }

    if (UIDeviceOrientationIsPortrait(orientation)) {
        [self activatePortraitConstratints];
    }
}

#pragma mark - Constraints handlers

- (void)activatePortraitConstratints {
    [NSLayoutConstraint deactivateConstraints:_nameLabelLandscapeConstraints];
    [NSLayoutConstraint activateConstraints:_nameLabelPortraitConstraints];
}

- (void)activateLandscapeConstraints {
    [NSLayoutConstraint deactivateConstraints:_nameLabelPortraitConstraints];
    [NSLayoutConstraint activateConstraints:_nameLabelLandscapeConstraints];
}

- (void)activateIPhoneConstraints {
    NSLayoutConstraint *profileImageWidth = [NSLayoutConstraint
                                             constraintWithItem:_profileImageView
                                             attribute:NSLayoutAttributeWidth
                                             relatedBy:NSLayoutRelationLessThanOrEqual
                                             toItem:nil
                                             attribute:NSLayoutAttributeNotAnAttribute
                                             multiplier:1.0
                                             constant:iPhoneProfileImageWidth];
    [profileImageWidth setPriority:UILayoutPriorityDefaultHigh];

    NSLayoutConstraint *profileImageHeight = [NSLayoutConstraint
                                              constraintWithItem:_profileImageView
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationLessThanOrEqual
                                              toItem:nil
                                              attribute:NSLayoutAttributeNotAnAttribute
                                              multiplier:1.0
                                              constant:iPhoneProfileImageHeight];
    [profileImageHeight setPriority:UILayoutPriorityDefaultHigh];

    [NSLayoutConstraint activateConstraints:@[profileImageWidth,
                                              profileImageHeight]];
}

@end

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

-(void)OrientationChange:(NSNotification*) notification {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if (UIDeviceOrientationIsLandscape(orientation)) {
        [self activateLandscapeConstraints];
    }

    if (UIDeviceOrientationIsPortrait(orientation)) {
        [self activatePortraitConstratints];
    }
}

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
                                             constant:150];
    [profileImageWidth setPriority:UILayoutPriorityDefaultHigh];

    NSLayoutConstraint *profileImageHeight = [NSLayoutConstraint
                                              constraintWithItem:_profileImageView
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationLessThanOrEqual
                                              toItem:nil
                                              attribute:NSLayoutAttributeNotAnAttribute
                                              multiplier:1.0
                                              constant:150];
    [profileImageHeight setPriority:UILayoutPriorityDefaultHigh];

    [NSLayoutConstraint activateConstraints:@[profileImageWidth,
                                              profileImageHeight]];
    
}

@end

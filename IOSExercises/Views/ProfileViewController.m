//
//  ProfileViewController.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 10/27/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "ProfileViewController.h"
#import "DetailsViewController.h"
#import "EXRColor.h"

const CGFloat iPhoneProfileImageWidth = 150.f;
const CGFloat iPhoneProfileImageHeight = 150.f;

@interface ProfileViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabelButton;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *nameLabelPortraitConstraints;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *nameLabelLandscapeConstraints;

@property (strong, nonatomic) NSMutableArray<NSLayoutConstraint *> *landscapeConstraints;

@property (strong, nonatomic) DetailsViewController *detailsViewController;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (UIUserInterfaceIdiomPhone == [[UIDevice currentDevice] userInterfaceIdiom]) {
        [self activateIPhoneConstraints];
    }

    UIDeviceOrientation orientation = self.view.bounds.size.width > self.view.bounds.size.height ? UIDeviceOrientationLandscapeRight : UIDeviceOrientationPortrait;

    [self setupConstraints:orientation];
    [self setupStyles];
}

#pragma mark - Setup Style Methods

- (void)setupStyles {
    self.nameLabelButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.nameLabelButton.layer.borderWidth = 0.5f;

    self.profileImageView.layer.borderColor = [UIColor redColor].CGColor;
    self.profileImageView.layer.borderWidth = 0.5f;
}

#pragma mark - Screen Navigation Methods

- (IBAction)pushDetailsViewController:(UIButton *)sender {
    if (!self.detailsViewController) {
        self.detailsViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController"
                                                                             bundle:[NSBundle mainBundle]];
    }
    self.detailsViewController.title = @"Hello, hello!";
    [self.navigationController pushViewController:self.detailsViewController
                                         animated:YES];
}


#pragma mark - Constraints Methods

- (void)viewWillTransitionToSize:(CGSize)size
                                 withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size
          withTransitionCoordinator:coordinator];

    UIDeviceOrientation orientation = size.width > size.height ? UIDeviceOrientationLandscapeRight: UIDeviceOrientationPortrait;

    [self setupConstraints:orientation];
}

- (void)setupConstraints:(UIDeviceOrientation)orientation {
    if (UIDeviceOrientationIsLandscape(orientation)) {
        [self activateLandscapeConstraints];
    }

    if (UIDeviceOrientationIsPortrait(orientation)) {
        [self activatePortraitConstraints];
    }
}

- (void)activatePortraitConstraints {
    [NSLayoutConstraint deactivateConstraints:self.nameLabelLandscapeConstraints];
    [NSLayoutConstraint activateConstraints:self.nameLabelPortraitConstraints];
}

- (void)activateLandscapeConstraints {
    [NSLayoutConstraint deactivateConstraints:self.nameLabelPortraitConstraints];
    [NSLayoutConstraint activateConstraints:self.nameLabelLandscapeConstraints];
}

- (void)activateIPhoneConstraints {
    [self.profileImageView.heightAnchor constraintEqualToConstant:150.f].active = YES;
    [self.profileImageView.widthAnchor constraintEqualToConstant:150.f].active = YES;
}

@end

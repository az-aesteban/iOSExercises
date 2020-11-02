//
//  ProfileViewController.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 10/27/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *nameLabelPortraitConstraints;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *nameLabelLandscapeConstraints;

@end

NS_ASSUME_NONNULL_END

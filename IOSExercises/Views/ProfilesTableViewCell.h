//
//  ProfilesTableViewCell.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/26/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfilesTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *birthdayAssetViewConstraints;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *birthdayColorViewConstraints;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *birthdayGreetingLabelConstraints;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *defaultConstraints;

@property (strong, nonatomic) IBOutlet UIView *colorView;

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UIView *assetsView;

@property (strong, nonatomic) IBOutlet UILabel *birthdayGreetingLabel;

@property (strong, nonatomic) Person *person;

- (void)setupProfileData;

- (void)setupBirthdayConstraints;

- (void)deactivateBirthdayConstraints;

@end

NS_ASSUME_NONNULL_END

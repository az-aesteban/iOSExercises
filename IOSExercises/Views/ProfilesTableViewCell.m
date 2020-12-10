//
//  ProfilesTableViewCell.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/26/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "ProfilesTableViewCell.h"
#import "EXRColor.h"

@implementation ProfilesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

- (void)setupProfileData {
    self.nameLabel.text = self.person.name;
    self.profileImageView.image = [UIImage imageNamed:self.person.image];
}

- (void)setupBirthdayConstraints {
    [NSLayoutConstraint deactivateConstraints:self.defaultConstraints];

    [NSLayoutConstraint activateConstraints:self.birthdayAssetViewConstraints];
    [self.assetsView addSubview:self.colorView];
    self.colorView.backgroundColor = [EXRColor supportedColor:self.person.color].uiColor;
    [NSLayoutConstraint activateConstraints:self.birthdayColorViewConstraints];

    [self.contentView addSubview:self.birthdayGreetingLabel];
    [NSLayoutConstraint activateConstraints:self.birthdayGreetingLabelConstraints];
}

- (void)deactivateBirthdayConstraints {
    [NSLayoutConstraint deactivateConstraints:self.birthdayAssetViewConstraints];
    [self.colorView removeFromSuperview];
    [NSLayoutConstraint deactivateConstraints:self.birthdayColorViewConstraints];

    [self.birthdayGreetingLabel removeFromSuperview];
    [NSLayoutConstraint deactivateConstraints:self.birthdayGreetingLabelConstraints];
    [NSLayoutConstraint activateConstraints:self.defaultConstraints];
}

@end

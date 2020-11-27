//
//  ProfilesTableViewCell.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/26/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "ProfilesTableViewCell.h"

@implementation ProfilesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupConstraints {
    self.nameLabel.text = self.person.name;
    self.profileImageView.image = [UIImage imageNamed:self.person.image];
    if ([self.person isBirthdayToday]) {
        [NSLayoutConstraint deactivateConstraints:self.defaultConstraints];
        
        [NSLayoutConstraint activateConstraints:self.birthdayAssetViewConstraints];
        [self.assetsView addSubview:self.colorView];
        self.colorView.backgroundColor = self.person.color.uiColor;
        [NSLayoutConstraint activateConstraints:self.birthdayColorViewConstraints];

        [self.contentView addSubview:self.birthdayGreetingLabel];
        [NSLayoutConstraint activateConstraints:self.birthdayGreetingLabelConstraints];
    }
}

@end

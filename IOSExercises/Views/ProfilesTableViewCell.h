//
//  ProfilesTableViewCell.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/26/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXRPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfilesTableViewCell : UITableViewCell

@property (strong, nonatomic) EXRPerson *person;

- (void)setupConstraints;

@end

NS_ASSUME_NONNULL_END

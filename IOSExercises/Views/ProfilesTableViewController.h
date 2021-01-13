//
//  ProfilesTableViewController.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/26/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXRCoreDataController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfilesTableViewController : UITableViewController

@property (nonatomic, strong) EXRCoreDataController *dataController;

@end

NS_ASSUME_NONNULL_END

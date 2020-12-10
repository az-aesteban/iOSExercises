//
//  ProfileViewController.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 10/27/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person+CoreDataClass.h"
#import "EXRCoreDataController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property(nonatomic, strong) Person *person;

@property(nonatomic, strong) EXRCoreDataController *dataController;


@end

NS_ASSUME_NONNULL_END

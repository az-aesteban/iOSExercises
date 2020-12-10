//
//  DetailsViewController.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/6/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXRCoreDataController.h"
#import "Person+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Person *person;

@property (strong, nonatomic) EXRCoreDataController *dataController;

@end

NS_ASSUME_NONNULL_END

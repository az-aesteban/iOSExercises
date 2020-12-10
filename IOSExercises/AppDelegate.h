//
//  AppDelegate.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 10/28/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EXRCoreDataController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) EXRCoreDataController *dataController;

@end


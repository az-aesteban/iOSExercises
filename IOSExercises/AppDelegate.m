//
//  AppDelegate.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 10/28/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "AppDelegate.h"
#import "ProfilesTableViewController.h"
#import "Person+CoreDataClass.h"

@interface AppDelegate ()

@property (strong, nonatomic) ProfilesTableViewController *profilesTableViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.dataController = [[EXRCoreDataController alloc] initWithCompletionBlock:^(EXRCoreDataController *controller) {
        [self insertDummyDataWithController:controller];

        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

        self.profilesTableViewController = [[ProfilesTableViewController alloc] initWithNibName:@"ProfilesTableViewController"
                                                                                         bundle:[NSBundle mainBundle]];
        self.profilesTableViewController.dataController = controller;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.profilesTableViewController];
        [self.window setRootViewController:navigationController];
        [self.window makeKeyAndVisible];
    }];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self.dataController saveContext];
}

#pragma mark - Data Setup Methods

- (void)insertDummyDataWithController:(EXRCoreDataController *)controller {

    Person *mocha = [Person personWithContext:controller.managedObjectContext];
    mocha.name = @"Sugarcub Mocha";
    [mocha setBirthdayWithMonth:5
                            day:5
                           year:2013];
    mocha.color = EXRSupportedColorBlue;
    mocha.imageFilepath = @"Mocha-DP";

    Person *latte = [Person personWithContext:controller.managedObjectContext];
    latte.name = @"Sugarcub Latte";
    [latte setBirthdayWithMonth:3
                            day:3
                           year:2013];
    latte.color = EXRSupportedColorRed;
    latte.imageFilepath = @"Latte-DP";

    Person *qoobee = [Person personWithContext:controller.managedObjectContext];
    qoobee.name = @"Qoobee Agapi";
    [qoobee setBirthdayWithMonth:1
                             day:14
                            year:2013];
    qoobee.color = EXRSupportedColorBlack;
    qoobee.imageFilepath = @"Qoobee-DP";

    [controller saveContext];
}

@end

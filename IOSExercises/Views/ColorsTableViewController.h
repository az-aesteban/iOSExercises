//
//  ColorsTableViewController.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/27/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ColorDelegate <NSObject>

-(void)sendSelectedColorName:(NSString *)colorName;

@end

@interface ColorsTableViewController : UITableViewController

@property (nonatomic, weak) id<ColorDelegate>delegate;

- (void)setupAvailableColors:(NSArray *)colorOptions;

@end

NS_ASSUME_NONNULL_END

//
//  ColorsTableViewController.h
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/27/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXRColor.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ColorDelegate <NSObject>

- (void)didSelectColor:(NSString *)colorName;

@end

@interface ColorsTableViewController : UITableViewController

@property (nonatomic, weak) id<ColorDelegate> delegate;

@property (nonatomic, strong) NSArray<EXRColor *> *availableColorOptions;

@end

NS_ASSUME_NONNULL_END

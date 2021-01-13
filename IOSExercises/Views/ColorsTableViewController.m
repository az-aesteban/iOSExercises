//
//  ColorsTableViewController.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/27/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "ColorsTableViewController.h"
#import "EXRColor.h"

NSString *const kCellIdentifier = @"colorCell";

@implementation ColorsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:kCellIdentifier];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.item < self.availableColorOptions.count) {
        NSString *chosenColor = [self.availableColorOptions objectAtIndex:indexPath.item].colorName;
        NSLog(@"ColorsTableViewController: User chose color %@", chosenColor);
        [self.delegate didSelectColor:chosenColor];
    } else {
        NSAssert(NO, @"ColorsTableViewController: Selected row has no color option.");
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.availableColorOptions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                            forIndexPath:indexPath];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kCellIdentifier];
    }
    if (indexPath.item < self.availableColorOptions.count) {
        EXRColor *color = [self.availableColorOptions objectAtIndex:indexPath.item];
        cell.textLabel.text = color.colorName;
        cell.textLabel.textColor = color.uiColor;
    } else {
        NSAssert(NO, @"ColorsTableViewController: No color option on selected row.");
    }
    return cell;
}

@end

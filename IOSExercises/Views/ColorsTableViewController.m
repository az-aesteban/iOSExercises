//
//  ColorsTableViewController.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/27/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "ColorsTableViewController.h"
#import "EXRColor.h"

static NSString *kCellIdentifier = @"colorCell";

@implementation ColorsTableViewController {
    NSArray<EXRColor *> *_availableColorOptions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:kCellIdentifier];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *chosenColor = [_availableColorOptions objectAtIndex:indexPath.item].colorName;
    NSLog(@"ColorsTableViewController: User chose color %@",  chosenColor);
    [self.delegate sendSelectedColorName:chosenColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _availableColorOptions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                            forIndexPath:indexPath];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kCellIdentifier];
    }
    EXRColor *color = [_availableColorOptions objectAtIndex:indexPath.item];
    cell.textLabel.text = color.colorName;
    cell.textLabel.textColor = color.uiColor;
    return cell;
}


#pragma mark - Helper Methods

- (void)setupAvailableColors:(NSArray *)colorOptions {
    _availableColorOptions = colorOptions;
}

@end

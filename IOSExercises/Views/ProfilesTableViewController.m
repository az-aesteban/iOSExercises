//
//  ProfilesTableViewController.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/26/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRPerson.h"
#import "ProfileViewController.h"
#import "ProfilesTableViewCell.h"
#import "ProfilesTableViewController.h"

static NSString *kCellIdentifier = @"profileViewCell";

@implementation ProfilesTableViewController {
    NSArray<EXRPerson *> *_persons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPersons];
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _persons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfilesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"ProfilesTableViewCell"
                                           bundle:[NSBundle mainBundle]]
        forCellReuseIdentifier:kCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    cell.person = [_persons objectAtIndex:indexPath.item];
    [cell setupConstraints];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController"
                                                                                           bundle:[NSBundle mainBundle]];
    [_persons objectAtIndex:indexPath.item];
    [self.navigationController pushViewController:profileViewController
                                         animated:YES];
}

#pragma mark - Data initialization Methods

- (void)setupPersons {
    EXRPerson *mocha = [EXRPerson personWithName:@"Sugarcub Mocha"
                                        birthday:[self birthdayFromMonth:05
                                                                  andDay:05
                                                                 andYear:2018]
                                   imageFilepath:@"Mocha-DP"
                                           color:[EXRColor supportedColor:EXRSupportedColorBlue]];
    
    EXRPerson *latte = [EXRPerson personWithName:@"Sugarcub Latte"
                                        birthday:[self birthdayFromMonth:1
                                                                  andDay:13
                                                                 andYear:2018]
                                   imageFilepath:@"Latte-DP"
                                           color:[EXRColor supportedColor:EXRSupportedColorRed]];

    _persons = [NSArray arrayWithObjects:latte, mocha, nil];
}

- (NSDate *)birthdayFromMonth:(NSInteger)aMonth
                       andDay:(NSInteger)aDay
                      andYear:(NSInteger)aYear {
    NSDateComponents *birthdayComponents = [[NSDateComponents alloc] init];
    [birthdayComponents setMonth:aMonth];
    [birthdayComponents setDay:aDay];
    [birthdayComponents setYear:aYear];
    return [[NSCalendar currentCalendar] dateFromComponents:birthdayComponents];
}

@end

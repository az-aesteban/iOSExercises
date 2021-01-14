//
//  ProfilesTableViewController.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/26/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfilesTableViewCell.h"
#import "ProfilesTableViewController.h"
#import "Person+CoreDataClass.h"

static NSString *kCellIdentifier = @"profileViewCell";

@interface ProfilesTableViewController ()

@property (strong, nonatomic) UISwitch *birthdayListSwitch;

@property (strong, nonatomic) NSArray<Person *> *persons;

@end

@implementation ProfilesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationFilterButtons];
    [self setupCellHeight];
    [self setupPersons];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.persons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfilesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"ProfilesTableViewCell"
                                              bundle:[NSBundle mainBundle]]
        forCellReuseIdentifier:kCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    cell.person = [self.persons objectAtIndex:indexPath.item];

    [cell setupProfileData];
    if ([self isBirthdayTodayOfPerson:cell.person]) {
        [cell setupBirthdayConstraints];
    } else {
        [cell deactivateBirthdayConstraints];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController"
                                                                                           bundle:[NSBundle mainBundle]];

    if (indexPath.item >= self.persons.count) {
        NSAssert(NO, @"ProfilesTableViewController: Selected row does not match to a profile");
        return;
    }
    Person *person = [self.persons objectAtIndex:indexPath.item];
    profileViewController.person = person;
    profileViewController.dataController = self.dataController;
    [self.navigationController pushViewController:profileViewController
                                         animated:YES];
}

#pragma mark - Data initialization Methods

- (void)setupPersons {
    self.persons = [Person personsWithContext:self.dataController.managedObjectContext];
}

- (NSArray<Person *> *)fetchPersonsWithBirthdayToday {

    NSArray<Person *> *persons = [Person personsWithContext:self.dataController.managedObjectContext];

    NSPredicate *birthdayPredicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> *_Nullable bindings) {
        Person *fetchedPerson = (Person *)evaluatedObject;
        return [self isBirthdayTodayOfPerson:fetchedPerson];
    }];
    return [persons filteredArrayUsingPredicate:birthdayPredicate];
}

- (BOOL)isBirthdayTodayOfPerson:(Person *)person {
    NSDateComponents *birthdayComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth
                                                                          fromDate:person.birthday];
    NSDateComponents *todayComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth
                                                                       fromDate:[NSDate date]];
    return birthdayComponent.day == todayComponent.day
        && birthdayComponent.month == todayComponent.month;
}


#pragma mark - Action Handler Methods

- (IBAction)didTapFilterButton:(id)sender {
    UIButton *filterButton = (UIButton *)sender;
    NSString *buttonTitle = filterButton.titleLabel.text;
    NSLog(@"ProfilesTableViewController: %@ Filter Button was tapped", buttonTitle);
    if ([buttonTitle isEqualToString:@"All"]) {
        [self setupPersons];
    } else {
        self.persons = [Person personsWithColor:[EXRColor colorWithName:buttonTitle]
                                        context:self.dataController.managedObjectContext];
    }
    self.birthdayListSwitch.on = NO;
    [self.tableView reloadData];
}

- (void)switchIsChanged:(UISwitch *)paramSender {
    NSLog(@"ProfilesTableViewController: Switch is tapped");
    if ([paramSender isOn]){
        self.persons = [self fetchPersonsWithBirthdayToday];
        NSLog(@"ProfilesTableViewController: Birthday switch is on");
    } else {
        [self setupPersons];
        NSLog(@"ProfilesTableViewController: Birthday switch is off");
    }
    [self.tableView reloadData];
}

#pragma mark - Layout Helper Methods

- (void)setupCellHeight {
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title {
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [barButton setTitle:title
               forState:UIControlStateNormal];
    [barButton addTarget:self
                  action:@selector(didTapFilterButton:)
        forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

- (void)setupNavigationFilterButtons {
    UIBarButtonItem *blackFilterButtonItem = [self barButtonItemWithTitle:@"Black"];
    UIBarButtonItem *allFilterButtonItem = [self barButtonItemWithTitle:@"All"];

    self.birthdayListSwitch = [[UISwitch alloc] init];
    self.birthdayListSwitch.on = NO;
    [self.birthdayListSwitch addTarget:self
                                action:@selector(switchIsChanged:)
           forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.birthdayListSwitch],
                                                blackFilterButtonItem,
                                                allFilterButtonItem];
}

@end

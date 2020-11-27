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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController"
                                                                                                 bundle:[NSBundle mainBundle]];
    [_persons objectAtIndex:indexPath.item];
    [self.navigationController pushViewController:profileViewController
                                         animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Data initialization Methods

- (void)setupPersons {
    EXRPerson *mocha = [EXRPerson personNamed:@"Sugarcub Mocha"
                                 withBirthday:[self birthdayFromMonth:05
                                                               andDay:05
                                                              andYear:2018]
                                     andImage:@"Mocha-DP"
                                   likesColor:[EXRColor supportedColor:EXRSupportedColorBlue]];
    
    EXRPerson *latte = [EXRPerson personNamed:@"Sugarcub Latte"
                                 withBirthday:[self birthdayFromMonth:11
                                                               andDay:27
                                                              andYear:2018]
                                     andImage:@"Latte-DP"
                                   likesColor:[EXRColor supportedColor:EXRSupportedColorRed]];

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

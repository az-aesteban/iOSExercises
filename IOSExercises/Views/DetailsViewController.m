//
//  DetailsViewController.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/6/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "DetailsViewController.h"
#import "EXRColor.h"
#import "ColorsTableViewController.h"

static NSString *kBirthdayDateFormat = @"MMMM d";

@interface DetailsViewController() <UIPopoverPresentationControllerDelegate, ColorDelegate>

@property (strong, nonatomic) IBOutlet UIButton *colorButton;

@property (strong, nonatomic) IBOutlet UIButton *birthdayButton;

@property (strong, nonatomic) IBOutlet UIButton *birthdayInfoButton;

@property (strong, nonatomic) UIViewController *popoverViewController;

@property (strong, nonatomic) UIDatePicker *datePicker;

@end

@implementation DetailsViewController {
    NSArray<EXRColor *> *_availableColorOptions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAvailableColors];
    [self setupInputFields];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupRightBarButtonItem];
}

#pragma mark - User Interaction Handlers


- (IBAction)didTapColorButton:(id)sender {
    NSLog(@"DetailsViewController: Color button tapped");
    if (UIUserInterfaceIdiomPhone == [[UIDevice currentDevice] userInterfaceIdiom]) {
        //
        // Display as action sheet
        // Currently logs layout constraints conflict error
        // Looks like a bug from Apple
        // See https://github.com/lionheart/openradar-mirror/issues/21120
        //
        [self displayColorPickerActionSheet];
    } else {
        [self displayPopoverColorPicker];
    }
}

- (IBAction)didTapBirthdayButton:(id)sender {
    NSLog(@"DetailsViewController: Date picker tapped");
    [self displayPopoverDateTimePicker];
}

- (IBAction)didTapBirthdayInfoButton:(id)sender {
    NSLog(@"DetailsViewController: User did tap Birthday button");
    NSDateFormatter *dateFormatter = [self birthdayFormatter];

    NSDate *birthdate = [dateFormatter dateFromString:self.birthdayButton.currentTitle];

    NSDateComponents *birthdayComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth
                                                                          fromDate:birthdate];
    NSDateComponents *todayComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth
                                                                       fromDate:[NSDate date]];

    NSString *greeting;

    // Currently comparing day and month date components instead of inSameDayAsDate
    if (birthdate
        && birthdayComponent.day == todayComponent.day
        && birthdayComponent.month == todayComponent.month) {
        greeting = @"Happy birthday!";
    } else {
        greeting = @"It's not your birthday";
    }
    [self displayPopoverWithGreeting:greeting];
}

- (IBAction)setBirthday:(id)sender {
    if (self.datePicker) {
        [self setBirthdayWithDate:[self.datePicker date]];
    }

    [self.popoverViewController dismissViewControllerAnimated:YES
                                                   completion:nil];
}

- (IBAction)didTapSaveButton:(id)sender {
    NSLog(@"DetailsViewController: Tapped Save Button");
    // Ignore: From Exercise 3
    // NSLog(@"DetailsViewController: Changes have not been saved");
    // [self promptErrorWithMessage:@"Changes have not been saved"];
    NSDateFormatter *dateFormatter = [self birthdayFormatter];
    NSDate *birthdate = [dateFormatter dateFromString:self.birthdayButton.currentTitle];

    self.person.birthday = birthdate;
    self.person.color = [EXRColor colorWithName:self.colorButton.currentTitle];
    [self.dataController saveContext];

    [self promptSuccessWithMessage:@"Changes have been saved"];
}

#pragma mark - Popover View Controller Methods

- (void)displayPopoverDateTimePicker {
    if (!self.popoverViewController) {
        self.popoverViewController = [[UIViewController alloc] init];
    }
    
    self.popoverViewController.view = [[UIView alloc] init];

    if (!self.datePicker) {
        self.datePicker = [[UIDatePicker alloc] init];
    }
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.popoverViewController.view addSubview:self.datePicker];

    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [saveButton setTitle:@"Set"
                forState:UIControlStateNormal];
    [saveButton addTarget:self
                   action:@selector(setBirthday:)
         forControlEvents:UIControlEventTouchUpInside];

    [self.popoverViewController.view addSubview:saveButton];

    self.popoverViewController.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:self.popoverViewController
                       animated:YES
                     completion:nil];

    [self.datePicker.centerXAnchor constraintEqualToAnchor:self.popoverViewController.view.centerXAnchor].active = YES;
    [self.datePicker.centerYAnchor constraintEqualToAnchor:self.popoverViewController.view.centerYAnchor].active = YES;
    [saveButton.topAnchor constraintEqualToAnchor:self.datePicker.bottomAnchor constant:5.f].active = YES;
    [saveButton.centerXAnchor constraintEqualToAnchor:self.popoverViewController.view.centerXAnchor].active = YES;

    #warning Ok for now. But for localization compute based content size.
    self.popoverViewController.preferredContentSize = CGSizeMake(300.f, 300.f);


    UIPopoverPresentationController *popoverController = [self.popoverViewController popoverPresentationController];

    [popoverController setPermittedArrowDirections:UIPopoverArrowDirectionAny];

    [popoverController setSourceView:self.birthdayButton];
    [popoverController setSourceRect:self.birthdayButton.bounds];
}

- (void)displayPopoverWithGreeting:(NSString *)aGreeting {
    UIViewController *greetingViewController = [[UIViewController alloc] init];
    greetingViewController.view = [[UIView alloc] init];

    #warning Ok for now. But for localization compute based content size.
    greetingViewController.preferredContentSize = CGSizeMake(200.f, 200.f);

    UILabel *greetingLabel = [UILabel new];
    greetingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    greetingLabel.text = aGreeting;
    [greetingViewController.view addSubview:greetingLabel];

    [greetingLabel.centerXAnchor constraintEqualToAnchor:greetingViewController.view.centerXAnchor].active = YES;
    [greetingLabel.centerYAnchor constraintEqualToAnchor:greetingViewController.view.centerYAnchor].active = YES;
    
    [greetingViewController setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:greetingViewController
                       animated:YES
                     completion:nil];

    UIPopoverPresentationController *popoverController = [greetingViewController popoverPresentationController];
    popoverController.permittedArrowDirections = UIPopoverArrowDirectionAny;

    popoverController.sourceView = self.birthdayInfoButton;
    popoverController.sourceRect = self.birthdayInfoButton.bounds;
}

- (void)promptErrorWithMessage:(NSString *)aMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:aMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
 
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}


- (void)promptSuccessWithMessage:(NSString *)aMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success"
                                                                   message:aMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
 
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

- (void)displayColorPickerActionSheet {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Choose a color"
                                                                   message:@"Choose from the available colors"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];

    for (EXRColor *color in _availableColorOptions) {
        UIAlertAction *action = [self alertActionForChoosingColor:color.colorName];
        [alert addAction:action];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                            NSLog(@"DetailsViewController: User did not choose a color");}];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

- (void)displayPopoverColorPicker {
    ColorsTableViewController *controller = [[ColorsTableViewController alloc] init];
    [controller setPreferredContentSize:CGSizeMake(200.f, 125.f)];
    [controller setupAvailableColors:_availableColorOptions];
    controller.delegate = self;
    [controller setModalPresentationStyle:UIModalPresentationPopover];
    [self presentViewController:controller
                       animated:YES
                     completion:nil];

    UIPopoverPresentationController *popoverController = [controller popoverPresentationController];

    [popoverController setSourceView:self.colorButton];
    [popoverController setSourceRect:self.colorButton.bounds];
}

#pragma mark - Helper Methods

- (void)setupInputFields {
    [self.colorButton setTitle:[self colorDisplayNameofSupportedColor:self.person.color]
                      forState:UIControlStateNormal];
    [self.birthdayButton setTitle:[[self birthdayFormatter] stringFromDate:self.person.birthday]
                         forState:UIControlStateNormal];
    self.title = self.person.name;
}

-(NSDateFormatter *)birthdayFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kBirthdayDateFormat];
    return dateFormatter;
}

- (void)setBirthdayWithDate:(NSDate *)aDate {
    NSDateFormatter *dateFormatter = [self birthdayFormatter];
    [self.birthdayButton setTitle:[dateFormatter stringFromDate:aDate]
                         forState:UIControlStateNormal];
}

- (UIAlertAction *)alertActionForChoosingColor:(NSString *)aTitle {
    return [UIAlertAction actionWithTitle:aTitle
                                    style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction *action) {
                                      NSLog(@"DetailsViewController: %@ was selected", aTitle);
                                      [self.colorButton setTitle:aTitle
                                                        forState:UIControlStateNormal];
                                  }];
}

- (void)setupAvailableColors {
    NSMutableArray<EXRColor *> *supportedColors = [[NSMutableArray alloc] init];
    for (int exrSupportedColor = 0; exrSupportedColor < EXRSupportedColorUnsupported; exrSupportedColor++) {
        [supportedColors addObject:[EXRColor supportedColor:exrSupportedColor]];
    }
    _availableColorOptions = supportedColors;
}

- (void)setupRightBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(didTapSaveButton:)];
}

-(void)sendSelectedColorName:(NSString *)colorName {
    [self.colorButton setTitle:colorName
                      forState:UIControlStateNormal];
}

- (NSString *)colorDisplayNameofSupportedColor:(EXRSupportedColor)supportedColor {
    return [EXRColor supportedColor:supportedColor].colorName;
}

@end

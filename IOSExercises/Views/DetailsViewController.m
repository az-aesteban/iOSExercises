//
//  DetailsViewController.m
//  IOSExercises
//
//  Created by Arnold Joseph Caesar Esteban on 11/6/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController() <UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *colorLabel;

@property (strong, nonatomic) IBOutlet UILabel *birthdayLabel;

@property (strong, nonatomic) IBOutlet UIButton *birthdayInfoButton;

@property (strong, nonatomic) UIViewController *popoverViewController;

@property (strong, nonatomic) UIDatePicker *datePicker;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDefaultValue];
    [self initUserInteraction];
}

#pragma mark - User Interaction Handlers

- (void)initUserInteraction {

    UITapGestureRecognizer *colorLabelTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(showColorPicker:)];
    
    colorLabelTapGesture.numberOfTapsRequired = 1;

    [self.colorLabel setUserInteractionEnabled:YES];
    [self.colorLabel addGestureRecognizer:colorLabelTapGesture];

    UITapGestureRecognizer *birthdayLabelTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(showDatePicker:)];
    [self.birthdayLabel setUserInteractionEnabled:YES];
    [self.birthdayLabel addGestureRecognizer:birthdayLabelTapGesture];
}

- (void)showColorPicker:(UITapGestureRecognizer *)recognizer {
    if (UIUserInterfaceIdiomPhone == [[UIDevice currentDevice] userInterfaceIdiom]) {
        /*
         * Display as action sheet
         * Currently logs layout constraints conflict error
         * Looks like a bug from Apple
         * See https://github.com/lionheart/openradar-mirror/issues/21120
         */
        [self displayColorPickerActionSheet];
    } else {
        [self popoverColorPicker];
    }
}

- (void)showDatePicker:(UITapGestureRecognizer *)recognizer {
    [self popoverDateTimePicker];
}

- (IBAction)greetIfBirthday:(id)sender {
    NSDateFormatter *dateFormatter = [self birthdayFormatter];

    NSDate *birthdate = [dateFormatter dateFromString:self.birthdayLabel.text];

    NSDateComponents *bdayComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth
                                                                      fromDate:birthdate];
    NSDateComponents *todayComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth
                                                                       fromDate:[NSDate date]];

    NSString *greeting;

    // Currently comparing day and month date components instead of inSameDayAsDate
    if (birthdate
        && bdayComponent.day == todayComponent.day
        && bdayComponent.month == todayComponent.month) {
        greeting = @"Happy birthday!";
    } else {
        greeting = @"It's not your birthday";
    }
    [self popoverWithGreeting:greeting];
}

- (IBAction)chooseColorRed:(id)sender {
    [self.colorLabel setText:@"Red"];
}

- (IBAction)chooseColorBlue:(id)sender {
    [self.colorLabel setText:@"Blue"];
}

- (IBAction)chooseColorBlack:(id)sender {
    [self.colorLabel setText:@"Black"];
}

- (IBAction)saveBirthday:(id)sender {
    if (self.datePicker) {
        NSLog(@"Saving birthday");
        [self setBirthdayWithDate:[self.datePicker date]];
    }
    NSLog(@"DetailsViewController: Birthday was not saved");

    [self.popoverViewController dismissViewControllerAnimated:YES
                                                   completion:nil];
    [self promptErrorWithMessage:@"Changes have not been saved"];
}

#pragma mark - Popover View Controller Methods

- (void)popoverDateTimePicker{
    if (!self.popoverViewController) {
        self.popoverViewController = [[UIViewController alloc] init];
    }
    
    self.popoverViewController.view = [[UIView alloc] init];
    [self.popoverViewController setPreferredContentSize:CGSizeMake(250.f, 270.f)];

    if (!self.datePicker) {
        self.datePicker = [[UIDatePicker alloc] init];
    }
    [self.datePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.popoverViewController.view addSubview:self.datePicker];

    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [saveButton setTitle:@"Save"
                forState:UIControlStateNormal];
    [saveButton addTarget:self
                   action:@selector(saveBirthday:)
         forControlEvents:UIControlEventTouchUpInside];

    [self.popoverViewController.view addSubview:saveButton];

    [self.popoverViewController setModalPresentationStyle:UIModalPresentationPopover];
    [self presentViewController:self.popoverViewController
                       animated:YES
                     completion:nil];

    NSDictionary *views = @{
        @"datePicker" : self.datePicker,
        @"saveButton" : saveButton
    };

    for (NSString *viewName in views) {
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|[%@]|", viewName]
                                                                                        options:0
                                                                                        metrics:nil
                                                                                          views:views]];
    }

    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[datePicker]|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                    views:views]];

    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[datePicker]-[saveButton]"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:views]];

    UIPopoverPresentationController *popoverController = [self.popoverViewController popoverPresentationController];

    [popoverController setPermittedArrowDirections:UIPopoverArrowDirectionAny];

    [popoverController setSourceView:self.birthdayLabel];
    [popoverController setSourceRect:self.birthdayLabel.bounds];
}

- (void)popoverWithGreeting:(NSString *)aGreeting {

    UIViewController *greetingViewController = [[UIViewController alloc] init];


    greetingViewController.view = [[UIView alloc] init];
    [greetingViewController setPreferredContentSize:CGSizeMake(200.f, 200.f)];

    UILabel *greetingLabel = [UILabel new];
    [greetingLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [greetingLabel setText:aGreeting];
    [greetingViewController.view addSubview:greetingLabel];

    NSDictionary *views = @{
        @"greetingLabel": greetingLabel,
        @"superView": greetingViewController.view
    };
  
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[superView]-(<=1)-[greetingLabel]"
                                                                                    options:NSLayoutFormatAlignAllCenterY
                                                                                    metrics:nil
                                                                                    views:views]];

    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[superView]-(<=1)-[greetingLabel]"
                                                                                    options:NSLayoutFormatAlignAllCenterX
                                                                                    metrics:nil
                                                                                      views:views]];

    [greetingViewController setModalPresentationStyle:UIModalPresentationPopover];
    [self presentViewController:greetingViewController
                       animated:YES
                     completion:nil];

    UIPopoverPresentationController *popoverController = [greetingViewController popoverPresentationController];
    popoverController.permittedArrowDirections = UIPopoverArrowDirectionAny;

    [popoverController setSourceView:self.birthdayInfoButton];
    [popoverController setSourceRect:self.birthdayInfoButton.bounds];
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

- (void)displayColorPickerActionSheet {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleActionSheet];

    for (NSString *color in [NSArray arrayWithObjects:@"Red", @"Blue", @"Black", nil]) {
        UIAlertAction *action = [self actionChooseColor:color];
        [alert addAction:action];
    }

    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

- (void)popoverColorPicker {
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view = [[UIView alloc] init];
    [controller setPreferredContentSize:CGSizeMake(200.f, 125.f)];

    NSArray<NSDictionary *> *colors = [NSArray arrayWithObjects:@{
         @"colorName" : @"Red",
        @"buttonName" : @"redButton",
          @"selector" : [NSValue valueWithPointer:@selector(chooseColorRed:)],
          @"topLabel" : @"|"
      },
      @{
         @"colorName" : @"Blue",
        @"buttonName" : @"blueButton",
          @"selector" : [NSValue valueWithPointer:@selector(chooseColorBlue:)],
          @"topLabel" : @"[redButton]"
      },
      @{
        @"colorName" : @"Black",
        @"buttonName" : @"blackButton",
         @"selector" : [NSValue valueWithPointer:@selector(chooseColorBlack:)],
         @"topLabel" : @"[blueButton]"
      }, nil];

    NSMutableDictionary *buttonViews = [[NSMutableDictionary alloc] init];

    for (NSDictionary *color in colors) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        [button setTitle:[color objectForKey:@"colorName"]
                forState:UIControlStateNormal];
        [button addTarget:self action:[[color objectForKey:@"selector"] pointerValue]
         forControlEvents:UIControlEventTouchUpInside];

        [controller.view addSubview:button];
    
        NSDictionary *views = @{@"button": button};
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|[button]|"]
                                                                                        options:0
                                                                                        metrics:nil
                                                                                          views:views]];

        [buttonViews setValue:button
                       forKey:[color objectForKey:@"buttonName"]];

    }

    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[redButton]-[blueButton]-[blackButton]"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:buttonViews]];

    [controller setModalPresentationStyle:UIModalPresentationPopover];
    [self presentViewController:controller
                       animated:YES
                     completion:nil];

    UIPopoverPresentationController *popoverController = [controller popoverPresentationController];

    [popoverController setPermittedArrowDirections:UIPopoverArrowDirectionAny];

    [popoverController setSourceView:self.colorLabel];
    [popoverController setSourceRect:self.colorLabel.bounds];
}

#pragma mark - Helper Methods

- (void)initDefaultValue {
    [self.colorLabel setText:@"Black"];
    [self.birthdayLabel setText:[[self birthdayFormatter] stringFromDate:[NSDate dateWithTimeIntervalSince1970:0]]];
}

-(NSDateFormatter *)birthdayFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d"];
    return dateFormatter;
}

- (void)setBirthdayWithDate:(NSDate *)aDate {
    // to be retrieved from date picker
    NSDateFormatter *dateFormatter = [self birthdayFormatter];
    [self.birthdayLabel setText:[dateFormatter stringFromDate:aDate]];
}

- (UIAlertAction *)actionChooseColor:(NSString *)aTitle {
    return [UIAlertAction actionWithTitle:aTitle
                                    style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction *action) {
                                      NSLog(@"DetailsViewController: %@ was selected", aTitle);
                                      [self.colorLabel setText:aTitle];
                                  }];
}

@end

//
//  CurrentTimeViewController.m
//  HypnoTime
//
//  Created by Fabrice Guillaume on 1/27/13.
//  Copyright (c) 2013 Fabrice Guillaume. All rights reserved.
//

#import "CurrentTimeViewController.h"

@implementation CurrentTimeViewController

// override the designated initializer for the superclass (UIViewController) and name the tab
// "Time"
- (id)init {
    // Call the superclass's designated initializer
    self = [super initWithNibName:@"CurrentTimeViewController"
                           bundle:nil];
    if (self) {
        // Get the tab bar item
        UITabBarItem *tbi = [self tabBarItem];
        // Give it a label
        [tbi setTitle:@"Time"];
        
        // Create a UIImage from a file
        UIImage *i = [UIImage imageNamed:@"Time.png"];
        // Put that image on the tab bar item
        [tbi setImage:i];
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    // Disregard parameters - implementation detail
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Loaded the view for CurrentTimeViewController");
    
    // Set the background color of the view so we can see it
    //[[self view] setBackgroundColor:[UIColor greenColor]];
}

// Implement the action method to show time
- (IBAction)showCurrentTime:(id)sender
{
    NSDate *now = [NSDate date];
    // Static here means "only once." The *variable* formatter
    // is created when the program is first loaded into memory.
    // The first time this method runs, formatter will
    // be nil and the if-block will execute, creating
    // an NSDateFormatter object that formatter will point to.
    // Subsequent entry into this method will reuse the same
    // NSDateFormatter object.
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
    }
    [timeLabel setText:[formatter stringFromDate:now]];
}

// Override viewWillAppear: to initialize the time label of the CurrentTimeViewController
// to the current time each time it is displayed and viewWillDisappear: to log to the console.
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"CurrentTimeViewController will appear");
    [super viewWillAppear:animated];
    [self showCurrentTime:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"CurrentTimeViewController will DISappear");
    [super viewWillDisappear:animated];
}

@end

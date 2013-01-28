//
//  HypnosisViewController.m
//  HypnoTime
//
//  Created by Fabrice Guillaume on 1/27/13.
//  Copyright (c) 2013 Fabrice Guillaume. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"

@implementation HypnosisViewController

// override the designated initializer for the superclass (UIViewController) and name the tab
// "Hypnosis"
- (id)init {
    // Call the superclass's designated initializer
    self = [super initWithNibName:nil
                           bundle:nil];
    if (self) {
        // Get the tab bar item
        UITabBarItem *tbi = [self tabBarItem];
        // Give it a label
        [tbi setTitle:@"Hypnosis"];
    
        // Create a UIImage from a file
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        // Put that image on the tab bar item
        [tbi setImage:i];
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    // Disregard parameters - nib name is an implementation detail
    return [self init];
}


// This method gets called automatically when the view is created
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Loaded the view for HypnosisViewController");
    
    // Set the background color of the view so we can see it
    //[[self view] setBackgroundColor:[UIColor orangeColor]];
}

// override loadView (message sent when the view needs to be created
// so that it creates an instance of HypnosisView programmatically
- (void)loadView
{
    HypnosisView *hv = [[HypnosisView alloc] initWithFrame:CGRectZero];
    [hv setBackgroundColor:[UIColor whiteColor]];
    [self setView:hv];

}

// ACCELEROMETER Methods
// override the method viewWillAppear: to get a pointer to the
// accelerometer and set its update interval and delegate.
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"Monitoring accelerometer");
    UIAccelerometer *a = [UIAccelerometer sharedAccelerometer];
    
    // Receive updates every 1/10th of a second.
    [a setUpdateInterval:0.1];
    [a setDelegate:self];
    
    // for the shaking feature - making it first responder so tht it receives the motion events
    [[self view] becomeFirstResponder];
}

// When the HypnosisViewController’s view is moved off screen, the accelerometer updates become
// unnecessary, and you should set the accelerometer’s delegate to nil. Setting the UIAccelerometer
// Getting Accelerometer Data ￼￼￼delegate to nil stops the updates to the controller and powers down
// the accelerometer hardware to conserve battery life.
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIAccelerometer sharedAccelerometer] setDelegate:nil];
}

// Implementation of the UIAccelerometer delegate method, accelerometer:didAccelerate:.
// set xShift and yShift and redraw the view
- (void)accelerometer:(UIAccelerometer *)meter
        didAccelerate:(UIAcceleration *)accel
{
    NSLog(@"%f, %f, %f", [accel x], [accel y], [accel z]);
    
    HypnosisView *hv = (HypnosisView *)[self view];
    // Smoothen Data
    float xShift = [hv xShift] * 0.8 + [accel x] * 2.0;
    float yShift = [hv yShift] * 0.8 - [accel y] * 2.0;
    [hv setXShift:xShift];
    [hv setYShift:yShift];
    
    //[hv setXShift:10.0 * [accel x]];
    //[hv setYShift:-10.0 * [accel y]];
    
    // Redraw the view
    [hv setNeedsDisplay];
}

@end

//
//  HypnosisView.m
//  Hypnosis
//
//  Created by Fabrice Guillaume on 1/27/13.
//  Copyright (c) 2013 Fabrice Guillaume. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView
@synthesize xShift, yShift;

// Override the drawRect: method
- (void)drawRect:(CGRect)rect
{
    // What rectangle am I filling?
    CGRect bounds = [self bounds];
    
    // Where is its center?
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // From the center how far out to a corner?
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    // Get the context being drawn upon
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // All lines will be drawn 10 points wide
    CGContextSetLineWidth(context, 10);
    
    // Set the stroke color to light gray
    //[[UIColor lightGrayColor] setStroke];
    
    // Set the stroke color to the current stripeColor
    [stripeColor setStroke];
    
    // Draw concentric circles from the outside in
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20)
    {
        // Accelerometer - offset the center using the xShift and yShift instance variables
        center.x += xShift;
        center.y += yShift;
        
        CGContextAddArc(context, center.x, center.y,
                        currentRadius, 0.0, M_PI * 2.0, YES);
        CGContextStrokePath(context);
    }
    
    // Add some text on top of the citrcles with a shadow
    NSString *text = @"You are getting sleepy...";
    
    // Get a font to draw in it
    UIFont *font = [UIFont boldSystemFontOfSize:28];
    
    // Draw in the center of the rectangle
    CGRect textRect;
    textRect.size = [text sizeWithFont:font];
    textRect.origin.x = center.x - textRect.size.width / 2.0;
    textRect.origin.y = center.y - textRect.size.height / 2.0;
    
    // Set the fill color of the current contect to black
    [[UIColor blackColor] setFill];
    
    // Set the shadow to be offset 4 points right, 3 points down,
    // dark gray and with a blur radius of 2 points
    CGSize offset = CGSizeMake(4, 3);
    CGColorRef color = [[UIColor darkGrayColor] CGColor];
    CGContextSetShadowWithColor(context, offset, 2.0, color);
    
    // Draw the string
    [text drawInRect:textRect
            withFont:font];
    
}

// designated initializer for UIView is initWithFrame
// initialize with stripecolor
- (id)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    if (self) {
        // Notice we explicitly retain the UIColor instance
        // returned by the convenience method lightGrayColor,
        // because it is autoreleased and we need to keep it around
        // so we can use it in drawRect:.
        stripeColor = [UIColor lightGrayColor];
        
        // Create the new layer object
        boxLayer = [[CALayer alloc] init];
        
        // Give it a size
        [boxLayer setBounds:CGRectMake(0.0, 0.0, 85.0, 85.0)];
         
         // Give it a location
         [boxLayer setPosition:CGPointMake(160.0, 100.0)];
         
         // Make half-transparent red the background color for the layer
         UIColor *reddish = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
         
         // Get a CGColor object with the same color values
         CGColorRef cgReddish = [reddish CGColor];
         [boxLayer setBackgroundColor:cgReddish];
        
        // Crete a UIImage
        UIImage *layerImage = [UIImage imageNamed:@"Hypno.png"];
        
        // Get the underlying CGImage
        CGImageRef image = [layerImage CGImage];
        
        // Put the CGImage on the layer
        [boxLayer setContents:(__bridge id)image];
        
        // Inset the image a bit on each side
        [boxLayer setContentsRect:CGRectMake(-0.1, -0.1, 1.2, 1.2)];
        
        // Let the image resize (without changing the aspect ration)
        // to fill the contentRect
        [boxLayer setContentsGravity:kCAGravityResizeAspect];
         
         // Make it a sublayer of the view's layer
         [[self layer] addSublayer:boxLayer];
        
    }
    return self;
}

// Shaking
// Override motionBegan:withEvent: to change the color and redraw the view
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // Shake is the only kind of motion for now, but we should (for future compatibility)
    // check the motion type.
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"shake started");
        float r, g, b;
        // Notice the trailing .0 on the dividends... this is necessary
        // to tell the compiler the result is a floating point number.. otherwise,
        // you will always get 0
        r = random() % 256 / 256.0;
        g = random() % 256 / 256.0;
        b = random() % 256 / 256.0;
        stripeColor = [UIColor colorWithRed:r
                                      green:g
                                       blue:b
                                      alpha:1];
        [self setNeedsDisplay];
    }
}

// There’s one more important detail: the window’s firstResponder is the object that gets
// sent all of the motion events. Right now, the first responder is not HypnosisView,
// so changing this
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end

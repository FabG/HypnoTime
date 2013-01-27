//
//  HypnosisView.m
//  Hypnosis
//
//  Created by Fabrice Guillaume on 1/27/13.
//  Copyright (c) 2013 Fabrice Guillaume. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

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
    [[UIColor lightGrayColor] setStroke];
    
    // Draw concentric circles from the outside in
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20)
    {
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

@end

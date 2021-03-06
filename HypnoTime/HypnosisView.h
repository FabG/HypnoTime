//
//  HypnosisView.h
//  Hypnosis
//
//  Created by Fabrice Guillaume on 1/27/13.
//  Copyright (c) 2013 Fabrice Guillaume. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HypnosisView : UIView
{
    UIColor *stripeColor; // color change when shaking
    float xShift, yShift; // accelerometer
}
@property (nonatomic, assign) float xShift;
@property (nonatomic, assign) float yShift;

@end

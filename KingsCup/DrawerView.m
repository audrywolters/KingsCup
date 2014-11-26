//
//  DrawerView.m
//  KingsCup
//
//  Created by Audry Wolters on 7/17/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//
//  DrawerView code by Akiel Khan
//    http://code.tutsplus.com/tutorials/smooth-freehand-drawing-on-ios--mobile-13164
//

#import "DrawerView.h"
#import "UIColor+KCColors.h"

@implementation DrawerView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setMultipleTouchEnabled:NO]; // (2)
        [self setBackgroundColor:[UIColor kcLightGray]];
        self.path = [UIBezierPath bezierPath];
        [self.path setLineWidth:2.0];
    }
    return self;
}


- (void)drawRect:(CGRect)rect // (5)
{
    [[UIColor kcDarkGray] setStroke];
    [self.path stroke];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.path moveToPoint:p];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.path addLineToPoint:p]; // (4)
    [self setNeedsDisplay];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}


@end
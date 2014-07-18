//
//  DrawerView.m
//  KingsCup
//
//  Created by Audry Wolters on 7/17/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//
//  This code taken from Akiel Khan
//    http://code.tutsplus.com/tutorials/smooth-freehand-drawing-on-ios--mobile-13164
//

#import "DrawerView.h"

@implementation DrawerView
{
    UIBezierPath *path; // (3)
}


- (id)initWithCoder:(NSCoder *)aDecoder // (1)
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setMultipleTouchEnabled:NO]; // (2)
        [self setBackgroundColor:[UIColor whiteColor]];
        path = [UIBezierPath bezierPath];
        [path setLineWidth:2.0];
    }
    return self;
}


- (void)drawRect:(CGRect)rect // (5)
{
    [[UIColor blackColor] setStroke];
    [path stroke];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [path moveToPoint:p];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [path addLineToPoint:p]; // (4)
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


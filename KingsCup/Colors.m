//
//  Color.m
//  KingsCup
//
//  Created by Audry Wolters on 7/25/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import "Colors.h"

@implementation Colors


- (UIColor *)darkGray
{
    if (!_darkGray) {
        _darkGray = [[UIColor alloc ]initWithRed:206.0/255.0
                                           green:202.0/255.0
                                            blue:99.0/255.0
                                           alpha:1.0];
    }
    return _darkGray;
}


- (UIColor *)midGray
{
    if (!_midGray){
        _midGray = [[UIColor alloc] initWithRed:206.0/255.0
                                  green:202.0/255.0
                                   blue:183.0/255.0
                                  alpha:1.0/255.0];
    }
    return _midGray;
    
}



@end
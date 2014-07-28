//
//  UIColor+KCColors.m
//  KingsCup
//
//  Created by Audry Wolters on 7/28/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import "UIColor+KCColors.h"

@implementation UIColor (KCColors)


//GRAY
+ (UIColor *)kcDarkGray
{
    return [[UIColor alloc ]initWithRed:173.0/255.0
                                  green:169.0/255.0
                                   blue:151.0/255.0
                                  alpha:1.0];
}


+ (UIColor *)kcMidGray
{
    return [[UIColor alloc] initWithRed:206.0/255.0
                                  green:202.0/255.0
                                   blue:183.0/255.0
                                  alpha:1.0];
}


+ (UIColor *)kcLightGray
{
    return [[UIColor alloc ]initWithRed:244.0/255.0
                                  green:241.0/255.0
                                   blue:223.0/255.0
                                  alpha:1.0];
}




///GREEN
+ (UIColor *)kcDarkGreen
{
    return [[UIColor alloc] initWithRed:125.0/255.0
                                  green:186.0/255.0
                                   blue:157.0/255.0
                                  alpha:1.0];
}


+ (UIColor *)kcMidGreen
{
    return [[UIColor alloc ]initWithRed:157.0/255.0
                                  green:186.0/255.0
                                   blue:144.0/255.0
                                  alpha:1.0];
}


+ (UIColor *)kcLightGreen
{
    return [[UIColor alloc] initWithRed:224/255.0
                                  green:224/255.0
                                   blue:153/255.0
                                  alpha:1.0];
}




//WARM
+ (UIColor *)kcYellow
{
    return [[UIColor alloc ]initWithRed:247.0/255.0
                                  green:227.0/255.0
                                   blue:141.0/255.0
                                  alpha:1.0];
}


+ (UIColor *)kcOrange
{
    return [[UIColor alloc] initWithRed:226.0/255.0
                                  green:180.0/255.0
                                   blue:129.0/255.0
                                  alpha:1.0];
}


+ (UIColor *)kcRed
{
    return [[UIColor alloc] initWithRed:221.0/255.0
                                  green:164.0/255.0
                                   blue:135.0/255.0
                                  alpha:1.0];
}

@end

//
//  CardData.h
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardData : NSObject

//can't figure out how to make these as plain old variables
//methods were the only way I could make it work
+ (NSArray *) suits;
+ (NSArray *) faces;
+ (NSArray *) titles;
+ (NSArray *) descriptions;

@end

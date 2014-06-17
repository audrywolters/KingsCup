//
//  CardData.h
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardData : NSObject

@property (weak, nonatomic) NSArray *suits; //of UIImage
@property (weak, nonatomic) NSArray *faces; //NSString
@property (weak, nonatomic) NSArray *titles; //NSString
@property (weak, nonatomic) NSArray *descriptions; //NSString


//need properties?
//be instance? -
+ (NSArray *) suits;
+ (NSArray *) faces;
+ (NSArray *) titles;
+ (NSArray *) descriptions;

@end

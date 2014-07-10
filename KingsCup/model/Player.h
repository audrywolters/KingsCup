//
//  Player.h
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSMutableArray *drinkMate;
@property (nonatomic) CGFloat *xPlacement;
@property (nonatomic) CGFloat *yPlacement;

- (NSString *)description;

@end

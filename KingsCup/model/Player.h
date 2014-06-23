//
//  Player.h
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, weak) NSString *name;
@property (nonatomic, weak) UIColor *color;
@property (nonatomic, weak) NSMutableArray *drinkMate;

@end

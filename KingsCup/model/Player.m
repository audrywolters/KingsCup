//
//  Player.m
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import "Player.h"

@implementation Player


- (NSString *)description
{
    return [NSString stringWithFormat: @"Name=%@, Color=%@", self.name, self.color];
}


- (NSMutableArray *) drinkMates
{
    if (!_drinkMates) {
        _drinkMates = [[NSMutableArray alloc]init];
    }
    
    return _drinkMates;
}

@end

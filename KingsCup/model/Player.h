//
//  Player.h
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic) NSInteger number;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSMutableArray *drinkMates;
@property (nonatomic, strong) NSMutableArray *drinkMateSuit;
@property (nonatomic) CGFloat xPlacement;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *colorSquare;

//- (NSString *)action;

@end

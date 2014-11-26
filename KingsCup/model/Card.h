//
//  Card.h
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSString *face;
@property (nonatomic, strong) UIImage *suit;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *action;

@end

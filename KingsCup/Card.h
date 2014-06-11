//
//  Card.h
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, weak) NSString *face;
@property (nonatomic, weak) NSString *suit;
@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) NSString *description;

@end

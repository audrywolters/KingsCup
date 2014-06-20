//
//  CardData.h
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardData : NSObject

@property (strong, nonatomic) NSArray *suits; //of UIImage
@property (strong, nonatomic) NSArray *faces; //NSString
@property (strong, nonatomic) NSArray *titles; //NSString
@property (strong, nonatomic) NSArray *descriptions; //NSString
//to decide which deck data to send
@property (nonatomic) BOOL isTraditional;


- (void) makeTraditionalDeck;
- (void) makeAlternateDeck;


@end

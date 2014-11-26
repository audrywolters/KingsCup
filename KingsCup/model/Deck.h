//
//  Deck.h
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject

//creates the deck

@property (nonatomic, strong) NSMutableArray *shuffledCards;

- (instancetype)init;
- (Card *) drawCard;

@end

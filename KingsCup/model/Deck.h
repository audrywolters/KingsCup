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
-(void) makeDeck;
-(Card *) drawRandomCard;

@end

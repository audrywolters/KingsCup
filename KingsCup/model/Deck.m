//
//  Deck.m
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import "Deck.h"
#import "Card.h"
#import "CardData.h"


@interface Deck()
//array that holds all cards
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, weak)  UIImage *suit;
@end


@implementation Deck


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        //loop 4x to make suit
        for (int i=0; i<4; i++) {
            self.suit = CardData.suits[i];
            
            //loop 13x for rest of cards
            for (int i=0; i<13; i++) {
                
                //create card
                Card *card = [[Card alloc] init];
                card.suit = self.suit;
                card.face = CardData.faces[i];
                card.title = CardData.titles[i];
                card.description = CardData.descriptions[i];
                
                //add card to the cards array
                [self.cards addObject:card];
            }
            
        }
        
    }
    
    return self;
    
}


-(Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        //create random number
        int randomNum = arc4random();
        int index = randomNum % [self.cards count];
        //put card at random index into new card
        randomCard = self.cards[index];
        //remove that card from the cards array
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}


//lazy instantiation of card array
-(NSMutableArray *)cards
{
    if (!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}


@end











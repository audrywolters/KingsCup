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

@end

@implementation Deck



//lazy instantiation of card array
-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


//make deck
-(void) makeDeck;
{
    //save the new card data
    NSString *newSuit;
    NSString *newFace;
    NSString *newTitle;
    
    
    //loop 4x to make suit
    for (int i=0; i<4; i++) {
        newSuit = CardData.suits[i];
        
        //loop 13x for rest of cards
        for (int i=0; i<13; i++) {
            newFace = CardData.faces[i];
            newTitle = CardData.titles[i];
            
           //create card
            Card *card = [[Card alloc] init];
            card.suit = newSuit;
            card.face = newFace;
            card.title = newTitle;
            
            //add card to the cards array
            [self.cards addObject:card];
        }
    
    }
}


-(Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    unsigned randomNum = arc4random();
    //random number within range of size of _cards
    unsigned index = randomNum % [self.cards count];
    //put card at random index into new card
    randomCard = self.cards[index];
    //remove that card from the _cards array
    [self.cards removeObjectAtIndex:index];
    
    return randomCard;
}


@end











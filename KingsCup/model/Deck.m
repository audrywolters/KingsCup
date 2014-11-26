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
@property (nonatomic, strong) NSMutableArray *orderedCards;
@property (nonatomic, weak)  UIImage *suit;
@end


@implementation Deck


//isTraditional comes from other viewControllers
- (instancetype)init
{
    self = [super init];
    
    //make the ordered deck
    CardData *cardData = [[CardData alloc]init];
    [cardData getCardData];
        
    //loop 4x to make suit
    for (int i=0; i<[cardData.suits count]; i++) {
        self.suit = cardData.suits[i];
            
        //loop 13x for rest of cards
        for (int i=0; i<[cardData.faces count]; i++) {
                
            //create card
            Card *card = [[Card alloc] init];
            card.suit = self.suit;
            card.face = cardData.faces[i];
            card.title = cardData.titles[i];
            card.action = cardData.actions[i];
                
            //add card to the cards array
            [self.orderedCards addObject:card];
        }
            
    }
    
    while ([self.orderedCards count] > 0)
    {
        int randomNum = arc4random();
        int index = randomNum % [self.orderedCards count];
        //put card at random index into new card
        Card *randomCard = [[Card alloc] init];
        randomCard = self.orderedCards[index];
        [self.orderedCards removeObjectAtIndex:index];
        //put that card in the shuffled deck
        [self.shuffledCards addObject:randomCard];
    }
    
    //todo: destroy ordered Cards
    
    return self;
    
}


-(Card *)drawCard
{
    Card *card = [[Card alloc] init];
    
    //if there are cards in the deck
    if ([self.shuffledCards count]) {
        //create random number
      
    }
    return card;
}


//lazy instantiation of card array
-(NSMutableArray *)orderedCards
{
    if (!_orderedCards){
        _orderedCards = [[NSMutableArray alloc] init];
    }
    return _orderedCards;
}

//lazy instantiation of card array
-(NSMutableArray *)shuffledCards
{
    if (!_shuffledCards){
        _shuffledCards = [[NSMutableArray alloc] init];
    }
    return _shuffledCards;
}


@end











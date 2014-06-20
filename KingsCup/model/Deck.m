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


//isTraditional comes from other viewControllers
- (instancetype)initWithFlag:(BOOL)isTraditional_
{
    self = [super init];
    
    if (self) {
        self.isTraditional = isTraditional_;
        
        CardData *cardData = [[CardData alloc]init];
        
        //get trad/alt info from card data
        if (self.isTraditional) {
            [cardData makeTraditionalDeck];
        } else {
            [cardData makeAlternateDeck];
        }
        
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
                card.description = cardData.descriptions[i];
                
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
    
    //if there are cards in the deck
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











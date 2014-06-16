//
//  KingsCupViewController.m
//  KingsCup
//
//  Created by Audry Wolters on 6/5/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import "KingsCupViewController.h"
#import "Deck.h"

@interface KingsCupViewController ()

@property (strong, nonatomic) Deck *deck;
//have card property?
@property (weak, nonatomic) IBOutlet UILabel *cardTitle;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *faceTop;
@property (weak, nonatomic) IBOutlet UILabel *faceBottom;
@property (weak, nonatomic) IBOutlet UIImageView *suitTop;
@property (weak, nonatomic) IBOutlet UIImageView *suitBottom;


@end

@implementation KingsCupViewController


- (Deck *)deck
{
    if (!_deck) {
        _deck = [[Deck alloc] init];
    }
    return _deck;
}


- (IBAction)touchCardButton:(id)sender
{
    Card *card = [self.deck drawRandomCard];
    //if there is a card left in the deck
    if (card) {
        //set card data
        self.cardTitle.text = card.title;
        self.description.text = card.description;
        self.faceTop.text = card.face;
        self.faceBottom.text = card.face;
        self.suitTop.image = card.suit;
        self.suitBottom.image = card.suit;
        
    } else {
        self.cardTitle.text = card.title;
        self.description.text = @"GAME OVER";
        self.faceTop.text = card.face;
        self.faceBottom.text = card.face;
        self.suitTop.image = card.suit;
        self.suitBottom.image = card.suit;
    }
    
}



@end

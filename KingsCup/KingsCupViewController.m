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
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (weak, nonatomic) IBOutlet UILabel *cardTitle;
@property (weak, nonatomic) IBOutlet UILabel *description;
//top graphics
@property (weak, nonatomic) IBOutlet UILabel *faceTop;
@property (weak, nonatomic) IBOutlet UIImageView *suitTop;
//bottom graphics
@property (weak, nonatomic) IBOutlet UILabel *faceBottom;
@property (weak, nonatomic) IBOutlet UIImageView *suitBottom;
//count the number of kings
@property (nonatomic) int kingCount;
@property (weak, nonatomic) IBOutlet UIImageView *cup;

- (IBAction)touchCardButton:(id)sender;
- (void)makeKing:(Card *)card;
- (void)makePictionary:(Card *)card;
- (void)makeCharades:(Card *)card;

@end

@implementation KingsCupViewController


- (Deck *)deck
{
    if (!_deck) {
        _deck = [[Deck alloc]initWithFlag:self.isTraditional];
    }
    return _deck;
}



- (IBAction)touchCardButton:(id)sender
{
    //get a random card
    Card *card = [self.deck drawRandomCard];
    
    //if there was a card able to be drawn
    if (card) {
        
        //set card background
        [self.cardButton setBackgroundImage:[UIImage imageNamed:@"cardFront"] forState:UIControlStateNormal];
        //set all card data except description
        self.cardTitle.text = card.title;
        self.faceTop.text = card.face;
        self.suitTop.image = card.suit;
        self.faceBottom.text = card.face;
        self.suitBottom.image = card.suit;
        //flip bottom bits
        self.faceBottom.transform = CGAffineTransformMakeRotation( M_PI/1 );
        self.suitBottom.transform = CGAffineTransformMakeRotation( M_PI/1 );
        
        //if a king
        if ([card.title isEqualToString:@"King's Cup"]) {
            [self makeKing:card];
            
        //if pictionary card
        } else if ([card.title isEqualToString:@"Pictionary"]) {
            [self makePictionary:card];
            
        //if charades card
        } else if ([card.title isEqualToString:@"Charades"]) {
            [self makeCharades:card];

        //if not a king
        } else {
            //set the description
            self.description.text = card.description;
        }
    
    //else there are no more cards
    } else {
        self.cardTitle.text = nil;
        self.description.text = @"GAME OVER";
        self.faceTop.text = nil;
        self.faceBottom.text = nil;
        self.suitTop.image = nil;
        self.suitBottom.image = nil;
    }
    
}




- (void)makeKing:(Card *)card
{
    self.kingCount++;
    
    //coresponding graphics and text for each King
    if (self.kingCount == 0) {
        self.description.text = card.description;
        
    } else if (self.kingCount == 1) {
        self.description.text = card.description;
        self.cup.image = [UIImage imageNamed:@"cup2.png"];
        
    } else if (self.kingCount == 2) {
        self.description.text = card.description;
        self.cup.image = [UIImage imageNamed:@"cup3.png"];
        
    } else if (self.kingCount == 3) {
        self.description.text = card.description;
        self.cup.image = [UIImage imageNamed:@"cup4.png"];
        
    } else if (self.kingCount == 4){
        self.description.text = @"you must drink the whole cup!";
        self.cup.image = [UIImage imageNamed:@"cup1.png"];
        //animation later
    }
    
    
}


- (void)makePictionary:(Card *)card
{
    NSLog(@"Pictionary time!");
    self.description.text = card.description;
    
    //dynamo button
}


- (void)makeCharades:(Card *)card
{
    NSLog(@"Charades time!");
    self.description.text = card.description;
    
    //dynamo button
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set the empty cup image
    self.cup.image = [UIImage imageNamed:@"cup1.png"];
}


@end

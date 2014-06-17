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
    //create new card
    Card *card = [self.deck drawRandomCard];
    
    
    
    //if there is a card left in the deck
    if (card) {

        //if it is a king increase king count by 1
        if ([card.face isEqual: @"K"]) {
            self.kingCount++;
        }
        
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
            self.description.text = @"drink the whole cup";
            self.cup.image = [UIImage imageNamed:@"cup1.png"];
            //animation later
        }
        
        
        //set the button image to be cardFront
        [self.cardButton setBackgroundImage:[UIImage imageNamed:@"cardFront" ] forState:UIControlStateNormal];
        //set card data
        self.cardTitle.text = card.title;
        self.faceTop.text = card.face;
        self.suitTop.image = card.suit;
        
        //flip bottom bits
        self.faceBottom.text = card.face;
        self.faceBottom.transform = CGAffineTransformMakeRotation( M_PI/1 );
        self.suitBottom.image = card.suit;
        self.suitBottom.transform = CGAffineTransformMakeRotation( M_PI/1 );
        
        
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cup.image = [UIImage imageNamed:@"cup1.png"];
}


@end

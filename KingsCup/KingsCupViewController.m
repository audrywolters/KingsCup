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

//add properties of deck and card?
@property (weak, nonatomic) IBOutlet UILabel *cardTitle;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *faceTop;
@property (weak, nonatomic) IBOutlet UILabel *faceBottom;
@property (weak, nonatomic) IBOutlet UILabel *suitTop;

@end

@implementation KingsCupViewController


- (IBAction)touchCardButton:(id)sender {
    Deck *deck = [[Deck alloc] init];
    //if declared deck in property, would instance be self.deck or _deck
    [deck makeDeck];
    Card *card = [deck drawRandomCard];
    
    self.cardTitle.text = card.title;
    self.description.text = card.description;
    self.faceTop.text = card.face;
    self.faceBottom.text = card.face;
    self.suitTop.text = card.suit;
    
    NSLog(@"%@", card.face);
    NSLog(@"%@", card.suit);
    NSLog(@"%@", card.title);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)didFinishLaunchingWithOptions {
    
}

@end

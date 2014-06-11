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

@property (weak, nonatomic) IBOutlet UILabel *cardTitle;
@property (weak, nonatomic) IBOutlet UILabel *description;

@end

@implementation KingsCupViewController


- (IBAction)touchCardButton:(id)sender {
    Deck *deck = [[Deck alloc] init];
    [deck makeDeck];
    Card *card = [deck drawRandomCard];
    
    self.cardTitle.text = card.title;
    self.description.text = card.description;
    
    
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

//
//  KingsCupViewController.m
//  KingsCup
//
//  Created by Audry Wolters on 6/5/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import "KingsCupViewController.h"
#import "Deck.h"
#import "Player.h"

@interface KingsCupViewController ()

@property (strong, nonatomic) Card *currentCard;
@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIButton *pictionaryButton;
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
//who's turn it is
@property (nonatomic) NSInteger playerTurn;
@property (strong, nonatomic) Player *currentPlayer;
//placement
@property (nonatomic) CGFloat currentX;
@property (nonatomic) CGFloat bufferWidth;


- (IBAction)touchCardButton:(id)sender;
- (IBAction)touchTimeButton:(id)sender;
- (IBAction)touchPictionaryButton:(id)sender;
- (IBAction)touchPlayerColorSquare:(id)sender;
- (void)disableButtons;
- (void)makeKing:(Card *)card;
- (void)makePictionary:(Card *)card;
- (void)makeCharades:(Card *)card;
- (void)displayPlayer:(Player *)player;
- (void)trackTurns;
- (void)highlightCurrentPlayer;


@end

@implementation KingsCupViewController


static const int FONT_SIZE = 8;


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
    self.currentCard = [self.deck drawRandomCard];
    [self disableButtons];
    
    //if there was a card able to be drawn
    if (self.currentCard) {
        
        //set card background
        [self.cardButton setBackgroundImage:[UIImage imageNamed:@"cardFront"] forState:UIControlStateNormal];
        //set all card data except description
        self.cardTitle.text = self.currentCard.title;
        self.faceTop.text = self.currentCard.face;
        self.suitTop.image = self.currentCard.suit;
        self.faceBottom.text = self.currentCard.face;
        self.suitBottom.image = self.currentCard.suit;
        //flip bottom bits
        self.faceBottom.transform = CGAffineTransformMakeRotation( M_PI/1 );
        self.suitBottom.transform = CGAffineTransformMakeRotation( M_PI/1 );
        
        
        //if a king
        if ([self.currentCard.title isEqualToString:@"King's Cup"]) {
            [self makeKing:self.currentCard];
            
            //if pictionary card
        } else if ([self.currentCard.title isEqualToString:@"Pictionary"]) {
            [self makePictionary:self.currentCard];
            
            //if charades card
        } else if ([self.currentCard.title isEqualToString:@"Charades"]) {
            [self makeCharades:self.currentCard];
            
            //if not a special card
        } else {
            //set the description
            self.description.text = self.currentCard.description;
        }
        
        
        //track player turn
        [self trackTurns];
        [self highlightCurrentPlayer];
        
        
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
    
    //change king's cup image and card description for each of the 4 cards
    
    switch (self.kingCount) {
        case 0:
            self.description.text = card.description;
            break;
            
        case 1:
            self.description.text = card.description;
            self.cup.image = [UIImage imageNamed:@"cup2.png"];
            break;
            
        case 2:
            self.description.text = card.description;
            self.cup.image = [UIImage imageNamed:@"cup3.png"];
            break;
            
        case 3:
            self.description.text = card.description;
            self.cup.image = [UIImage imageNamed:@"cup4.png"];
            break;
            
        case 4:
            self.description.text = @"you must drink the whole cup!";
            self.cup.image = [UIImage imageNamed:@"cup1.png"];
            //TODO: animation
            break;
            
    }
    
}




- (void)makeCharades:(Card *)card
{
    //set description
    self.description.text = card.description;
    
    //show button
    self.timeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.timeButton addTarget:self action:@selector(touchTimeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.timeButton setTitle:@"start" forState:UIControlStateNormal];
    self.timeButton.frame = CGRectMake(80.0, 200.0, 160.0, 40.0);
    [self.view addSubview:self.timeButton];
}



- (void)touchTimeButton:(id)sender
{
    [self disableButtons];
}





- (void)makePictionary:(Card *)card
{
    //set description
    self.description.text = card.description;
    
    //show button
    self.pictionaryButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.pictionaryButton addTarget:self action:@selector(touchPictionaryButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.pictionaryButton setTitle:@"start" forState:UIControlStateNormal];
    self.pictionaryButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:self.pictionaryButton];
    
}

- (void)touchPictionaryButton:(id)sender
{
    [self disableButtons];
    
    //go to the pictionary view
    PictionaryViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"pvc"];
    [self presentViewController:pvc animated:YES completion:nil];
}



//TODO: bad to have blanket method like this?
- (void)disableButtons
{
    [self.timeButton setEnabled:NO];
    self.timeButton.hidden = YES;
    
    [self.pictionaryButton setEnabled:NO];
    self.pictionaryButton.hidden = YES;
}







- (IBAction)touchPlayerColorSquare:(id)sender
{
    //figure out which player was picked
    UIButton *clickedColorSquare = (UIButton *)sender;
    int playerClickedNum = [clickedColorSquare tag];
    Player *playerClicked = [self.players objectAtIndex:playerClickedNum - 1];
    
    
    //set that person to be the drink buddy
    [self.currentPlayer.drinkMate addObject:playerClicked.name];
    
    NSLog(@"Current Player: %@", self.currentPlayer);
    NSLog(@"Player # clicked: %d", [clickedColorSquare tag]);

}


- (void)findPlacement
{
    //TODO: there must be a one incrementing because squares get farther apart each square
    //TODO: magic numbers?
    self.bufferWidth = 40;
    
    Player *firstPlayer = [self.players objectAtIndex:0];

    self.currentX = 175;
    
    //move starting point over 25 pixels for each player
    for (int i=0; i<[self.players count]; i++){
        self.currentX = self.currentX - 25;
    }
    firstPlayer.xPlacement = self.currentX;
    
    
    //get placement for rest of players
    for (int i=1; i<[self.players count]; i++) {
        self.bufferWidth++;
        self.currentX = self.currentX + self.bufferWidth;
        
        Player *nextPlayer = [self.players objectAtIndex:i];
        nextPlayer.xPlacement = self.currentX;
        
    }
    
}


- (void)trackTurns
{
    //if the turn is at the end of of the players, or empty, reset
    if ((self.playerTurn == [self.players count]) || self.playerTurn == 0) {
        self.playerTurn = 1;
        
        //else increment
    } else {
        self.playerTurn++;
    }
    
    self.currentPlayer = [self.players objectAtIndex:self.playerTurn - 1];
}



- (void)highlightCurrentPlayer
{
    //reset all squares
    for (Player *player in self.players) {
        [player.colorSquare removeFromSuperview];
        [player.nameLabel removeFromSuperview];
        [self displayPlayer:player];
    }
    
    //highlight the current player
    Player *currentPlayer = [self.players objectAtIndex:self.playerTurn - 1];
    currentPlayer.nameLabel.font = [currentPlayer.nameLabel.font fontWithSize:FONT_SIZE + 3];
    currentPlayer.colorSquare.frame = CGRectMake((currentPlayer.xPlacement - 5), (50 - 5), 40, 40);
    [currentPlayer.colorSquare setEnabled:NO];
}



- (void)displayPlayer:(Player *)player
{
    //show player's name
    player.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(player.xPlacement,30,30,20)];
    player.nameLabel.text = player.name;
    player.nameLabel.textAlignment = NSTextAlignmentCenter;
    player.nameLabel.font = [player.nameLabel.font fontWithSize:FONT_SIZE];
    [self.view addSubview:player.nameLabel];
    
    //show player's color square
    player.colorSquare = [[UIButton alloc] initWithFrame:CGRectMake(player.xPlacement, 50, 30, 30)];
    player.colorSquare.backgroundColor = player.color;
    player.colorSquare.tag = player.number;
    [player.colorSquare setImage:[UIImage imageNamed:@"tapped.png"] forState:UIControlStateHighlighted];
    [player.colorSquare addTarget:self action:@selector(touchPlayerColorSquare:) forControlEvents:UIControlEventTouchUpInside];
    //[player.colorSquare setEnabled:NO];
    [self.view addSubview:player.colorSquare];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set the empty cup image
    self.cup.image = [UIImage imageNamed:@"cup1.png"];
    
    //find the placement for player avatars
    [self findPlacement];
    
    //send each player to be displayed
    for (Player *player in self.players) {
        [self displayPlayer:player];
    }
    
}



@end

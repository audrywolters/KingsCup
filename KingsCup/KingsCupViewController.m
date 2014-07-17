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
#import "CardData.h"
#import "IntroViewController.h"

@interface KingsCupViewController ()

@property (strong, nonatomic) Card *currentCard;
@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIButton *drawingButton;
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
@property (strong, nonatomic) NSMutableArray *colorSquares;
//timer
@property (nonatomic) NSTimer *timer;
@property (nonatomic) UILabel *timerLabel;
@property (nonatomic) int seconds;
//generate random words
@property (nonatomic) UIButton *generateRandomWordButton;
@property (nonatomic) NSString *randomWord;
@property (nonatomic) UILabel *randomWordLabel;


- (IBAction)touchCardButton:(id)sender;
- (IBAction)touchTimeButton:(id)sender;
- (IBAction)touchDrawingButton:(id)sender;
- (IBAction)touchPlayerColorSquare:(id)sender;
- (IBAction)touchQuitGame:(id)sender;
- (void)disableButtons;
- (void)makeKing:(Card *)card;
- (void)makeDrawing:(Card *)card;
- (void)makeCharades:(Card *)card;
- (void)displayPlayer:(Player *)player;
- (void)trackTurns;
- (void)highlightCurrentPlayer;
- (void)displayDrinkMates;
- (void)enableDrinkMateButtons;
- (void)disableDrinkMateButtons;
//get random word
- (void)generateRandomWord;




@end

@implementation KingsCupViewController


static const int FONT_SIZE = 8;
NSString *const GUESS_THE_DRAWING = @"Guess the Drawing";
NSString *const CHARADES = @"Charades";
NSString *const KINGS_CUP = @"King's Cup";
NSString *const DRINK_MATE = @"Drink Mate";
//TODO: fix magic numbers
//TODO: arrange methods chronologically


- (void)generateRandomWord
{
    //get rid of button
    [self.generateRandomWordButton removeFromSuperview];
    
    CardData *data = [[CardData alloc]init];
    int randomNum = arc4random();
    int index = randomNum % [data.charadesWords count];
    
    /*
    //if a charades card, get a charades word
    if (self.currentCard.title == CHARADES) {
     */
        self.randomWord = data.charadesWords[index];
        [data.charadesWords removeObjectAtIndex:index];
      /*
        //if a guess the drawing card, get a drawing word
    } else if (self.currentCard.title == GUESS_THE_DRAWING) {
        self.randomWord = data.drawingWords[index];
        [data.drawingWords removeObjectAtIndex:index];
    }
    */
    
    self.randomWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.randomWordLabel.text = self.randomWord;
    [self.view addSubview:self.randomWordLabel];
    
}



- (IBAction)touchCardButton:(id)sender
{
    //get a random card
    self.currentCard = [self.deck drawRandomCard];
    
    self.randomWordLabel.hidden = YES;
    [self disableButtons];
    
    //if there was a card able to be drawn
    if (self.currentCard) {
        
        //track player turn and reset player squares
        [self trackTurns];
        [self highlightCurrentPlayer];
        
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
        if ([self.currentCard.title isEqualToString:KINGS_CUP]) {
            [self makeKing:self.currentCard];
            
            //if pictionary card
        } else if ([self.currentCard.title isEqualToString:GUESS_THE_DRAWING]) {
            [self makeDrawing:self.currentCard];
            
            //if charades card
        } else if ([self.currentCard.title isEqualToString:CHARADES]) {
            [self makeCharades:self.currentCard];
            
            //if drink mate
        } else if ([self.currentCard.title isEqualToString:DRINK_MATE]){
            
            self.description.text = self.currentCard.description;
            [self enableDrinkMateButtons];
            
            //if not a special card
        } else {
            //set the description
            self.description.text = self.currentCard.description;
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
    
    //show time button
    self.timeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.timeButton addTarget:self action:@selector(touchTimeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.timeButton setTitle:@"start" forState:UIControlStateNormal];
    self.timeButton.frame = CGRectMake(80, 200, 160, 40);
    [self.view addSubview:self.timeButton];
    
    //show gen random word button
    self.generateRandomWordButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.generateRandomWordButton addTarget:self action:@selector(generateRandomWord) forControlEvents:UIControlEventTouchUpInside];
    [self.generateRandomWordButton setTitle:@"Generate Random Word" forState:UIControlStateNormal];
    self.generateRandomWordButton.frame = CGRectMake(80, 250, 200, 40);
    [self.view addSubview:self.generateRandomWordButton];
    
    
}



- (void)touchTimeButton:(id)sender
{
    //get rid of start button
    [self disableButtons];
    
    //create timer and call runTimer
    self.seconds = 60;
    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 200, 50, 40)];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
    
    
    
}

- (void)runTimer
{
    //run timer every one second
    self.seconds = self.seconds - 1;
    self.timerLabel.text = [NSString stringWithFormat:@":%i", self.seconds];
    self.timerLabel.textColor = [UIColor redColor];
    [self.view addSubview:self.timerLabel];
    
    //if at end of time display drink!
    if (self.seconds == -1) {
        self.timerLabel.text = @"Drink!";
    }
    
    //after drink! remove timer
    if (self.seconds == -2) {
        [self.timer invalidate];
        self.timer = nil;
        [self.timerLabel removeFromSuperview];
    }
}




- (void)makeDrawing:(Card *)card
{
    //set description
    self.description.text = card.description;
    
    //show button
    self.drawingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.drawingButton addTarget:self action:@selector(touchDrawingButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.drawingButton setTitle:@"start" forState:UIControlStateNormal];
    self.drawingButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:self.drawingButton];
    
}

- (void)touchDrawingButton:(id)sender
{
    [self disableButtons];
    
    //go to the pictionary view
    DrawingViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"pvc"];
    [self presentViewController:pvc animated:YES completion:nil];
}



- (void)disableButtons
{
    [self.timeButton removeFromSuperview];
    [self.drawingButton removeFromSuperview];
    [self.generateRandomWordButton removeFromSuperview];
    [self.randomWordLabel removeFromSuperview];
    
    [self.timer invalidate];
    self.timer = nil;
    [self.timerLabel removeFromSuperview];
}



- (void)enableDrinkMateButtons
{
    NSInteger currentPlayerNum = self.currentPlayer.number;
    for (Player *player in self.players) {
        if (player.number == currentPlayerNum) {
            //keep disabled
        } else {
            //player.colorSquare.backgroundColor = [UIColor brownColor];
            //make buttons clickable
            [player.colorSquare setEnabled:YES];
        }
    }
}


- (void)disableDrinkMateButtons
{
    for (Player *player in self.players) {
        [player.colorSquare setEnabled:NO];
    }
}


- (void)displayDrinkMates
{
    CGFloat bufferWidth = 0;
    
    for (int i=0; i<[self.currentPlayer.drinkMates count]; i++) {
        UILabel *drinkMateLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.currentPlayer.xPlacement + bufferWidth), 87,6,6)];
        drinkMateLabel.backgroundColor = [self.currentPlayer.drinkMates objectAtIndex:i];
        [self.view addSubview:drinkMateLabel];
        bufferWidth = bufferWidth + 8;
    }
    
}



- (IBAction)touchPlayerColorSquare:(id)sender
{
    //figure out which player was picked
    UIButton *clickedColorSquare = (UIButton *)sender;
    NSInteger playerClickedNum = [clickedColorSquare tag];
    Player *playerClicked = [self.players objectAtIndex:playerClickedNum - 1];
    
    
    //set that person to be the drink buddy
    [self.currentPlayer.drinkMates addObject:playerClicked.color];
    
    //disable buttons
    [self disableDrinkMateButtons];
    
    [self displayDrinkMates];
    
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
    [player.colorSquare setEnabled:NO];
    [self.view addSubview:player.colorSquare];
    
    //add to array for dealing with later
    //[self.colorSquares addObject:player.colorSquare];
    
}

//TODO: fix view controller switch (make one intro view controller)
- (IBAction)touchQuitGame:(id)sender
{
    
    NSLog(@"HI");
    //dismiss view controller
    
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    /*
    IntroViewController *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"ivc"];
    [self presentViewController:ivc animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
     */
 
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
    
    //make quit button
    UIButton *quitGameButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [quitGameButton addTarget:self action:@selector(touchQuitGame:) forControlEvents:UIControlEventTouchUpInside];
    [quitGameButton setTitle:@"Quit Game" forState:UIControlStateNormal];
    quitGameButton.frame = CGRectMake(10, 300, 80, 30);
    [self.view addSubview:quitGameButton];
}


- (Deck *)deck
{
    if (!_deck) {
        _deck = [[Deck alloc]initWithFlag:self.isTraditional];
    }
    return _deck;
}


- (NSMutableArray *)colorSquares
{
    if (!_colorSquares) {
        _colorSquares = [[NSMutableArray alloc] init];
    }
    
    return _colorSquares;
}



@end

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
#import "PlayersViewController.h"
#import "UIColor+KCColors.h"

@interface KingsCupViewController ()

@property (strong, nonatomic) Card *currentCard;
@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIButton *drawingButton;
@property (weak, nonatomic) IBOutlet UILabel *cardTitle;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UIButton *playAgainButton;
@property (weak, nonatomic) IBOutlet UIButton *quitButton;
//top graphics
@property (weak, nonatomic) IBOutlet UILabel *faceTop;
@property (weak, nonatomic) IBOutlet UIImageView *suitTop;
//bottom graphics
@property (weak, nonatomic) IBOutlet UILabel *faceBottom;
@property (weak, nonatomic) IBOutlet UIImageView *suitBottom;
//keep track of kings
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

//cycle through cards
- (IBAction)touchCardButton:(id)sender;
- (void)trackTurns;
- (IBAction)touchPlayAgainButton:(id)sender;
//display player
- (void)findPlacement;
- (void)displayPlayer:(Player *)player;
- (void)highlightCurrentPlayer;
- (void)resetDisplayedPlayers;
//drink mates
- (void)displayDrinkMates;
- (void)enableDrinkMateButtons;
- (void)disableDrinkMateButtons;
//king
- (void)makeKingCard:(Card *)card;
//charades
- (void)makeCharadesCard:(Card *)card;
- (void)generateRandomWord;
- (IBAction)touchTimeButton:(id)sender;
- (void)runTimer;
//guess the drawing
- (void)makeDrawingCard:(Card *)card;
- (IBAction)touchDrawingButton:(id)sender;
- (IBAction)touchPlayerColorSquare:(id)sender;
- (IBAction)touchQuitGameButton:(id)sender;
//whole game
- (void)disableButtons;

@end


@implementation KingsCupViewController


static const int SMALL_FONT = 9;
static const int BODY_FONT = 11;
static const int FONT_SIZE = 15;
static const int BUTTON_FONT = 17;
static const int LARGE_FONT = 35;

NSString *const GUESS_THE_DRAWING = @"Guess the Drawing";
NSString *const CHARADES = @"Charades";
NSString *const KINGS_CUP = @"King's Cup";
NSString *const DRINK_MATE = @"Drink Mate";





#pragma mark <View Did Load>

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Pixelette" size:BODY_FONT]];
    [[UILabel appearance] setTextColor:[UIColor kcDarkGray]];
    
    
    [self.faceTop setFont:[UIFont fontWithName:@"Pixelette" size:LARGE_FONT]];
    [self.faceBottom setFont:[UIFont fontWithName:@"Pixelette" size:LARGE_FONT]];
    [self.cardTitle setFont:[UIFont fontWithName:@"Pixelette" size:FONT_SIZE]];
    [self.quitButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:BUTTON_FONT]];
    [self.quitButton setTitleColor:[UIColor kcYellow] forState:UIControlStateNormal];
    
    //set the empty cup image
    self.cup.image = [UIImage imageNamed:@"cup1.png"];
    
    //find the placement for player avatars
    [self findPlacement];
    
    //send each player to be displayed
    for (Player *player in self.players) {
        [self displayPlayer:player];
    }
}




#pragma mark <Cycle Through Cards>

- (IBAction)touchCardButton:(id)sender
{
    //get a random card
    self.currentCard = [self.deck drawRandomCard];
    
    //hide buttons and labels
    //ranom word label must be hidden seperately cuz of timing
    self.randomWordLabel.hidden = YES;
    [self disableButtons];
    
    //stop animations
    [self.cup.layer removeAllAnimations];
    if (self.kingCount == 4) {
        self.cup.image = [UIImage imageNamed:@"cup1.png"];
    }
    
    //if there was a card able to be drawn
    if (self.currentCard) {
        
        //track player turn and reset player squares
        [self trackTurns];
        [self highlightCurrentPlayer];
        
        //set card background
        //TODO: why is this not working? button still see through
        [self.cardButton setBackgroundImage:[UIImage imageNamed:@"cardFront"] forState:UIControlStateNormal];
        [self.cardButton setBackgroundImage:[UIImage imageNamed:@"cardFront"] forState:UIControlStateHighlighted];
        
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
            [self makeKingCard:self.currentCard];
            
            //if pictionary card
        } else if ([self.currentCard.title isEqualToString:GUESS_THE_DRAWING]) {
            [self makeDrawingCard:self.currentCard];
            
            //if charades card
        } else if ([self.currentCard.title isEqualToString:CHARADES]) {
            [self makeCharadesCard:self.currentCard];
            
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
        self.cardTitle.text = @"GAME OVER";
        self.cardTitle.font = [self.cardTitle.font fontWithSize:BUTTON_FONT];
        
        self.description.text = nil;
        self.faceTop.text = nil;
        self.faceBottom.text = nil;
        self.suitTop.image = nil;
        self.suitBottom.image = nil;
        self.cardButton.enabled = NO;
        //TODO: background see through
        
        //play again?
        self.playAgainButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.playAgainButton addTarget:self action:@selector(touchPlayAgainButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.playAgainButton setTitle:@"Play Again?" forState:UIControlStateNormal];
        self.playAgainButton.frame = CGRectMake(50, 250, 200, 30);
        [self.playAgainButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:BUTTON_FONT]];
        [self.playAgainButton setTitleColor:[UIColor kcRed] forState:UIControlStateNormal];
        [self.view addSubview:self.playAgainButton];
        
    }
    
}



- (void)trackTurns
{
    //if the turn is at the end of of the players, or empty, reset
    if (self.playerTurn == [self.players count] || self.playerTurn == 0) {
        self.playerTurn = 1;
        
    //else increment
    } else {
        self.playerTurn++;
    }
    
    //set the current player
    self.currentPlayer = [self.players objectAtIndex:self.playerTurn - 1];
}





#pragma mark <Display Players>

- (void)findPlacement
{
    //TODO: there must be a one incrementing because squares get farther apart each square
    //TODO: magic numbers?
    self.bufferWidth = 45;
    //int minusCounter = [self.players count];
    
    Player *firstPlayer = [self.players objectAtIndex:0];
    
    //middle of screen (for two players)
    self.currentX = 175;
    
    //move starting point over 25 pixels for each player
    for (int i=0; i<[self.players count]; i++){
        self.currentX = self.currentX - 25;
    }
    firstPlayer.xPlacement = self.currentX;
    
    
    //get placement for rest of players
    for (int i=1; i<[self.players count]; i++) {
        self.bufferWidth++;
        //minusCounter--;
        self.currentX = (self.currentX + self.bufferWidth); //- minusCounter;
        
        Player *nextPlayer = [self.players objectAtIndex:i];
        nextPlayer.xPlacement = self.currentX;
        
    }
    
}



- (void)displayPlayer:(Player *)player
{
    //show player's name
    player.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((player.xPlacement - 11),22,55,20)];
    player.nameLabel.text = player.name;
    player.nameLabel.textAlignment = NSTextAlignmentCenter;
    player.nameLabel.font = [UIFont fontWithName:@"Pixelette" size:SMALL_FONT];
    player.nameLabel.textColor = [UIColor kcLightGray];
    [self.view addSubview:player.nameLabel];
    
    //show player's color square
    player.colorSquare = [[UIButton alloc] initWithFrame:CGRectMake(player.xPlacement,42,33,33)];
    player.colorSquare.backgroundColor = player.color;
    player.colorSquare.tag = player.number;
    [player.colorSquare setImage:[UIImage imageNamed:@"tapped.png"] forState:UIControlStateHighlighted];
    [player.colorSquare addTarget:self action:@selector(touchPlayerColorSquare:) forControlEvents:UIControlEventTouchUpInside];
    [player.colorSquare setEnabled:NO];
    [self.view addSubview:player.colorSquare];
}



- (void)highlightCurrentPlayer
{
    [self resetDisplayedPlayers];
    
    //highlight the current player
    Player *currentPlayer = [self.players objectAtIndex:self.playerTurn - 1];
    
    //make current player bigger
    currentPlayer.nameLabel.font = [currentPlayer.nameLabel.font fontWithSize:(SMALL_FONT + 1)];
    currentPlayer.nameLabel.frame = CGRectMake(currentPlayer.xPlacement-12, 22-5, 55, 20);
    currentPlayer.colorSquare.frame = CGRectMake((currentPlayer.xPlacement - 5), (42 - 5), 40, 40);
    
    [currentPlayer.colorSquare setEnabled:NO];
}


- (void)resetDisplayedPlayers
{
    //destroy and recreate players
    for (Player *player in self.players) {
        [player.colorSquare removeFromSuperview];
        [player.nameLabel removeFromSuperview];
        [self displayPlayer:player];
    }
}


#pragma mark <Drink Mate>

- (void)displayDrinkMates
{
    CGFloat bufferWidth = 0;
    
    for (int i=0; i<[self.currentPlayer.drinkMates count]; i++) {
        UILabel *drinkMateLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.currentPlayer.xPlacement + bufferWidth), 78,6,6)];
        drinkMateLabel.backgroundColor = [self.currentPlayer.drinkMates objectAtIndex:i];
        [self.view addSubview:drinkMateLabel];
        bufferWidth = bufferWidth + 9;
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



- (void)enableDrinkMateButtons
{
    NSInteger currentPlayerNum = self.currentPlayer.number;
    for (Player *player in self.players) {
        if (player.number == currentPlayerNum) {
            //keep disabled
        } else {
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






#pragma mark <King>

- (void)makeKingCard:(Card *)card
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
            //self.cup.image = [UIImage imageNamed:@"cup1.png"];
            NSArray *cupAnimationImages = [[NSArray alloc] initWithObjects:
                                           //[UIImage imageNamed:@"cup4.png"],
                                           [UIImage imageNamed:@"cup5.png"],
                                           [UIImage imageNamed:@"cup4.png"],
                                           [UIImage imageNamed:@"cup5.png"],
                                           [UIImage imageNamed:@"cup4.png"],
                                           [UIImage imageNamed:@"cup3.png"],
                                           [UIImage imageNamed:@"cup2.png"],
                                           [UIImage imageNamed:@"cup1.png"],
                                           nil];
            
            self.cup.animationImages = cupAnimationImages;
            self.cup.animationDuration = 2;
            
            [self.cup startAnimating];
            break;
            
    }
    
}





#pragma mark <Charades>

- (void)makeCharadesCard:(Card *)card
{
    //set description
    self.description.text = card.description;
    
    //show gen random word button
    self.generateRandomWordButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.generateRandomWordButton addTarget:self action:@selector(generateRandomWord) forControlEvents:UIControlEventTouchUpInside];
    [self.generateRandomWordButton setTitle:@"Generate Random Word" forState:UIControlStateNormal];
    self.generateRandomWordButton.frame = CGRectMake(50, 310, 200, 30);
    [self.generateRandomWordButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:BODY_FONT]];
    [self.generateRandomWordButton setTitleColor:[UIColor kcRed] forState:UIControlStateNormal];
    [self.view addSubview:self.generateRandomWordButton];
    
}



- (void)generateRandomWord
{
    //get rid of button
    [self.generateRandomWordButton removeFromSuperview];
    
    //show time button
    self.timeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.timeButton addTarget:self action:@selector(touchTimeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.timeButton setTitle:@"Start" forState:UIControlStateNormal];
    self.timeButton.frame = CGRectMake(50, 330, 200, 30);
    [self.timeButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:FONT_SIZE]];
    [self.timeButton setTitleColor:[UIColor kcRed] forState:UIControlStateNormal];
    [self.view addSubview:self.timeButton];
    
    //get random word
    CardData *data = [[CardData alloc]init];
    int randomNum = arc4random();
    int index = randomNum % [data.charadesWords count];
    self.randomWord = data.charadesWords[index];
    [data.charadesWords removeObjectAtIndex:index];
    
    //show random word
    self.randomWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 310, 200, 30)];
    self.randomWordLabel.text = self.randomWord;
    self.randomWordLabel.textAlignment = NSTextAlignmentCenter;
    [self.randomWordLabel setFont:[UIFont fontWithName:@"Pixelette" size:FONT_SIZE]];
    self.randomWordLabel.textColor = [UIColor kcMidGreen];
    [self.view addSubview:self.randomWordLabel];
    
}



- (void)touchTimeButton:(id)sender
{
    //get rid of start button
    [self disableButtons];
    
    //create timer and call runTimer
    self.seconds = 60;
    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 310, 200, 40)];
    [self.timerLabel setFont:[UIFont fontWithName:@"Pixelette" size:BUTTON_FONT]];
        self.timerLabel.textColor = [UIColor kcRed];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
}



- (void)runTimer
{
    //run timer every one second
    self.seconds = self.seconds - 1;
    self.timerLabel.text = [NSString stringWithFormat:@":%i", self.seconds];
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




#pragma mark <Guess the Drawing>

- (void)makeDrawingCard:(Card *)card
{
    //set description
    self.description.text = card.description;
    
    //show button
    self.drawingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.drawingButton addTarget:self action:@selector(touchDrawingButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.drawingButton setTitle:@"start" forState:UIControlStateNormal];
    self.drawingButton.frame = CGRectMake(66, 318, 160, 40);
    [self.drawingButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:FONT_SIZE]];
    [self.drawingButton setTitleColor:[UIColor kcRed] forState:UIControlStateNormal];
    [self.view addSubview:self.drawingButton];
    
}



- (void)touchDrawingButton:(id)sender
{
    [self disableButtons];
    
    //go to the guess the drawing view
    DrawingViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"dvc"];
    [self presentViewController:dvc animated:YES completion:nil];
}




#pragma mark <Disable Buttons>

- (void)disableButtons
{
    [self.timeButton removeFromSuperview];
    [self.drawingButton removeFromSuperview];
    [self.generateRandomWordButton removeFromSuperview];
    [self.randomWordLabel removeFromSuperview];
    [self.playAgainButton removeFromSuperview];
    
    [self.timer invalidate];
    self.timer = nil;
    [self.timerLabel removeFromSuperview];
}





#pragma mark <Game State>

- (IBAction)touchQuitGameButton:(id)sender
{
    PlayersViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"pvc"];
    [self presentViewController:pvc animated:YES completion:nil];
}


- (IBAction)touchPlayAgainButton:(id)sender
{
    //reset drink mates
    for (Player *player in self.players) {
        player.drinkMates = nil;
    }
    
    //init new kvc
    KingsCupViewController *kvc = [self.storyboard instantiateViewControllerWithIdentifier:@"kvc"];
    kvc.players = self.players;
    [self presentViewController:kvc animated:NO completion:nil];
}




#pragma mark <Init>

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

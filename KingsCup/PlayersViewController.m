//
//  PlayersViewController.m
//  KingsCup
//
//  Created by Audry Wolters on 6/17/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import "PlayersViewController.h"
#import "KingsCupViewController.h"
#import "Player.h"
#import "UIColor+KCColors.h"

@interface PlayersViewController () <UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *players; //of Player
@property (strong, nonatomic) NSMutableArray *colors;  //of Image
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIImageView *nameBox;
@property (strong, nonatomic) IBOutlet UIButton *addPlayerButton;
@property (weak, nonatomic) IBOutlet UIButton *deletePlayerButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIImageView *cupAnimation;
//player squares
@property (strong, nonatomic) NSArray *playerSquares;
@property (weak, nonatomic) IBOutlet UIImageView *player1Square;
@property (weak, nonatomic) IBOutlet UIImageView *player2Square;
@property (weak, nonatomic) IBOutlet UIImageView *player3Square;
@property (weak, nonatomic) IBOutlet UIImageView *player4Square;
@property (weak, nonatomic) IBOutlet UIImageView *player5Square;
@property (weak, nonatomic) IBOutlet UIImageView *player6Square;
//player names
@property (strong, nonatomic) NSArray *playerNames;
@property (weak, nonatomic) IBOutlet UILabel *player1Name;
@property (weak, nonatomic) IBOutlet UILabel *player2Name;
@property (weak, nonatomic) IBOutlet UILabel *player3Name;
@property (weak, nonatomic) IBOutlet UILabel *player4Name;
@property (weak, nonatomic) IBOutlet UILabel *player5Name;
@property (weak, nonatomic) IBOutlet UILabel *player6Name;

- (IBAction)touchAddPlayerButton:(id)sender;
- (IBAction)touchDeletePlayerButton:(id)sender;
- (IBAction)touchStartButton:(id)sender;

@end


@implementation PlayersViewController

//TODO: change min players!
static const int MIN_PLAYERS = 1;
static const int MAX_PLAYERS = 6;
static const int MAX_NAME_LENGTH = 7;
static const int FONT_SIZE = 17;
static const int SMALL_FONT_SIZE = 11;


- (void)viewDidLoad
{
    //set type buttons
    [self.addPlayerButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:FONT_SIZE]];
    [self.addPlayerButton setTitleColor:[UIColor kcYellow] forState:UIControlStateNormal];
    [self.deletePlayerButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:FONT_SIZE]];
    [self.deletePlayerButton setTitleColor:[UIColor kcYellow] forState:UIControlStateNormal];
    [self.startButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:FONT_SIZE]];
    [self.startButton setTitleColor:[UIColor kcYellow] forState:UIControlStateNormal];
    
    //hide buttons until at least 2 players are added
    self.startButton.hidden = YES;
    //hide button unitl 1 player added
    self.deletePlayerButton.hidden = YES;
    //hide text field image until add player clicked
    self.nameBox.hidden = YES;
    
    
    //hide squares
    self.playerSquares = [[NSArray alloc] initWithObjects:
                              self.player1Square,
                              self.player2Square,
                              self.player3Square,
                              self.player4Square,
                              self.player5Square,
                              self.player6Square,
                              nil];
    
    
    for (UIView *square in self.playerSquares)
    {
        square.hidden = YES;
    }

    
    //hide names
    self.playerNames = [[NSArray alloc] initWithObjects:
                            self.player1Name,
                            self.player2Name,
                            self.player3Name,
                            self.player4Name,
                            self.player5Name,
                            self.player6Name,
                            nil];
    
    
    for (UILabel *name in self.playerNames)
    {
        name.hidden = YES;
    }
    
    
    //cup animation
    NSArray *cupAnimationImages = [[NSArray alloc] initWithObjects:
                                   [UIImage imageNamed:@"cup1.png"],
                                   [UIImage imageNamed:@"cup2.png"],
                                   [UIImage imageNamed:@"cup3.png"],
                                   [UIImage imageNamed:@"cup4.png"],
                                   [UIImage imageNamed:@"cup5.png"],
                                   [UIImage imageNamed:@"cup4.png"],
                                   [UIImage imageNamed:@"cup5.png"],
                                   [UIImage imageNamed:@"cup4.png"],
                                   [UIImage imageNamed:@"cup5.png"],
                                   [UIImage imageNamed:@"cup4.png"],
                                   [UIImage imageNamed:@"cup3.png"],
                                   [UIImage imageNamed:@"cup2.png"],
                                   [UIImage imageNamed:@"cup1.png"],
                                   [UIImage imageNamed:@"cup1.png"],
                                    nil];
    
    self.cupAnimation.animationImages = cupAnimationImages;
    self.cupAnimation.animationDuration = 5;
    
    [self.cupAnimation startAnimating];
    
}



#pragma mark <create and display player>

- (void)touchAddPlayerButton:(id)sender
{
    self.addPlayerButton.hidden = YES;
    
    //show text field box
    self.nameBox.hidden = NO;
    self.nameField.hidden = NO;
    
    if ([self.players count] < MAX_PLAYERS ) {
        //make text field for name entry
        self.nameField.font = [UIFont fontWithName:@"Pixelette" size:FONT_SIZE - 2];
        self.nameField.placeholder = @"Enter your name";
        [self.nameField setTextColor:[UIColor kcLightGray]];
        self.nameField.attributedPlaceholder = [[NSAttributedString alloc]
                                                initWithString:@"Enter Your Name"
                                                    attributes:@{NSForegroundColorAttributeName:[UIColor kcLightGray]}];
        self.nameField.textAlignment = NSTextAlignmentCenter;
        self.nameField.returnKeyType = UIReturnKeyDone;
        self.nameField.delegate = self;
    }
}

- (IBAction)touchDeletePlayerButton:(id)sender
{
    //remove created player from array
    [self.players removeLastObject];
    
    //hide name and label
    NSInteger numPlayers = [self.players count];
    UIView *squareToDelete = self.playerSquares[numPlayers];
    UILabel *nameToDelete = self.playerNames[numPlayers];
    squareToDelete.hidden = YES;
    nameToDelete.hidden = YES;
    
    //TODO: ensure players are deleted when returning from kvc

    if ([self.players count] < 1) {
        self.deletePlayerButton.hidden = YES;
    }
    
    if ([self.players count] < 2) {
        self.startButton.hidden = YES;
    }
    
    if ([self.players count] < MAX_PLAYERS) {
        self.addPlayerButton.hidden = NO;
    }
}

//When user finishes entering name, store player information
- (BOOL)textFieldShouldReturn:(UITextField *)nameField
{
    self.addPlayerButton.enabled = YES;
    
    //hide text field box
    self.nameBox.hidden = YES;
    
    //if the text field is empty, don't add player
    if ([nameField.text  isEqual: @""]) {
        //do nothing
        
    //else add player
    } else {
        //create player
        Player *player = [[Player alloc]init];
        
        //set id #
        player.number = [self.players count] + 1;
        
        //get name from text field
        player.name = nameField.text;
        
        //get the color for the player
        NSInteger numPlayers = [self.players count]; //if 5th time called, there are 5 saved players, get the 5th color in array
        player.color = self.colors[numPlayers];
        
        //save player
        [self.players addObject:player];
        
        //populate players into view
        [self displayPlayer:player];
    }
    
    
    //show start button if 2nd players added
    if ([self.players count] == MIN_PLAYERS) {
        //self.traditionalButton.hidden = NO;
        self.startButton.hidden = NO;
    }
    
    
    //hide add player button if 6 players added
    if ([self.players count] == MAX_PLAYERS) {
        self.addPlayerButton.hidden = YES;
    }
    
    //show delete player button if there are at least 1 player
    if ([self.players count] >= 1) {
        self.deletePlayerButton.hidden = NO;
    }
    
    if ([self.players count] < MAX_PLAYERS) {
        self.addPlayerButton.hidden = NO;
    }
    
    //hide keyboard and text field
    [nameField resignFirstResponder];
    nameField.text = @"";
    nameField.hidden = YES;
    return YES;
}

//don't allow more than 10 characters in name
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > MAX_NAME_LENGTH) ? NO : YES;
}

- (void)displayPlayer:(Player *)player
{
    //display the square
    NSUInteger playerNumber = self.players.count - 1;
    UIView *currentSquare = self.playerSquares[playerNumber];
    currentSquare.hidden = NO;
    
    //display the name
    UILabel *currentName = self.playerNames[playerNumber];
    currentName.text = player.name;
    currentName.textAlignment = NSTextAlignmentCenter;
    [currentName setFont:[UIFont fontWithName:@"Pixelette" size:SMALL_FONT_SIZE]];
    currentName.textColor = [UIColor kcLightGray];
    currentName.hidden = NO;
}



#pragma mark <touch start buttons>

- (IBAction)touchStartButton:(id)sender
{
    KingsCupViewController *kvc = [self.storyboard instantiateViewControllerWithIdentifier:@"kvc"];
    kvc.players = self.players;
    kvc.isTraditional = NO;
    [self presentViewController:kvc animated:YES completion:nil];
}



#pragma mark <init objects>

- (NSMutableArray *)players
{
    if (!_players) {
        _players = [[NSMutableArray alloc]init];
    }
    return _players;
}



- (NSMutableArray *)colors
{
    //TODO: MAKE ARRAY OF IMAGES
    if (!_colors) {
        _colors = [[NSMutableArray alloc] initWithObjects:
                   [UIColor kcDarkGreen],
                   [UIColor kcMidGreen],
                   [UIColor kcLightGreen],
                   [UIColor kcYellow],
                   [UIColor kcOrange],
                   [UIColor kcRed],
                   nil];
    }
    return _colors;
}


@end
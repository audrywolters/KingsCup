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
@property (strong, nonatomic) UITextField *nameField;
@property (strong, nonatomic) UIImageView *nameFieldBox;
@property (strong, nonatomic) IBOutlet UIButton *addPlayerButton;
@property (weak, nonatomic) IBOutlet UIButton *deletePlayerButton;
@property (weak, nonatomic) IBOutlet UIButton *traditionalButton;
@property (weak, nonatomic) IBOutlet UIButton *alternateButton;
@property (weak, nonatomic) IBOutlet UIImageView *cupAnimation;

- (IBAction)touchAddPlayerButton:(id)sender;
- (IBAction)touchDeletePlayerButton:(id)sender;
- (void)findPlacement:player;
- (IBAction)touchTraditionalButton:(id)sender;
- (IBAction)touchAlternateButton:(id)sender;

@end


@implementation PlayersViewController

static const int MIN_PLAYERS = 2;
static const int MAX_PLAYERS = 6;
static const int MAX_NAME_LENGTH = 8;
static const int FONT_SIZE = 17;
static const int SMALL_FONT_SIZE = 11;




- (void)viewDidLoad
{
    //add player button
    self.addPlayerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addPlayerButton addTarget:self
                             action:@selector(touchAddPlayerButton:)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.addPlayerButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:FONT_SIZE]];
    [self.addPlayerButton setTitleColor:[UIColor kcYellow] forState:UIControlStateNormal];
    [self.addPlayerButton setTitle:@"Add Player" forState:UIControlStateNormal];
    self.addPlayerButton.frame = CGRectMake(58, 140, 200, 30);
    [self.view addSubview:self.addPlayerButton];
    
    
    
    //add delete player button
    self.deletePlayerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deletePlayerButton addTarget:self
                                action:@selector(touchDeletePlayerButton:)
                      forControlEvents:UIControlEventTouchUpInside];
    [self.deletePlayerButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:FONT_SIZE]];
    [self.deletePlayerButton setTitleColor:[UIColor kcYellow] forState:UIControlStateNormal];
    [self.deletePlayerButton setTitle:@"Delete Player" forState:UIControlStateNormal];
    self.deletePlayerButton.frame = CGRectMake(58, 215, 200, 30);
    [self.view addSubview:self.deletePlayerButton];
    
    
    
    //add text field box
    self.nameFieldBox = [[UIImageView alloc] initWithFrame:CGRectMake(58, 177, 210, 30)];
    self.nameFieldBox.image = [UIImage imageNamed:@"nameBox.png"];
    [self.view addSubview:self.nameFieldBox];
    
    
    //add traditional button
    self.traditionalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.traditionalButton addTarget:self
                                action:@selector(touchTraditionalButton:)
                      forControlEvents:UIControlEventTouchUpInside];
    [self.traditionalButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:FONT_SIZE]];
    [self.traditionalButton setTitleColor:[UIColor kcYellow] forState:UIControlStateNormal];
    [self.traditionalButton setTitle:@"Traditional Rules >" forState:UIControlStateNormal];
    self.traditionalButton.frame = CGRectMake(58, 480 , 210, 30);
    [self.view addSubview:self.traditionalButton];
    
    
    //add alternate button
    self.alternateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alternateButton addTarget:self
                               action:@selector(touchAlternateButton:)
                     forControlEvents:UIControlEventTouchUpInside];
    [self.alternateButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:FONT_SIZE]];
    [self.alternateButton setTitleColor:[UIColor kcYellow] forState:UIControlStateNormal];
    [self.alternateButton setTitle:@"Alternate Rules >" forState:UIControlStateNormal];
    self.alternateButton.frame = CGRectMake(58, 518, 210, 30);
    [self.view addSubview:self.alternateButton];
    
    //hide buttons until at least 2 players are added
    self.traditionalButton.hidden = YES;
    self.alternateButton.hidden = YES;
    //hide button unitl 1 player added
    self.deletePlayerButton.hidden = YES;
    //hide text field image until add player clicked
    self.nameFieldBox.hidden = YES;
    
    
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
    self.addPlayerButton.enabled = NO;
    
    //show text field box
    self.nameFieldBox.hidden = NO;
    
    if ([self.players count] < MAX_PLAYERS ) {
        //make text field for name entry
        //CGRect nameRect = CGRectMake(40, 170, 240, 30);
        self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(58, 177, 210, 30)];
        self.nameField.font = [UIFont fontWithName:@"Pixelette" size:FONT_SIZE - 2];
        self.nameField.placeholder = @"Enter your name";
        [self.nameField setTextColor:[UIColor kcLightGray]];
        self.nameField.attributedPlaceholder = [[NSAttributedString alloc]
                                                initWithString:@"Enter Your Name"
                                                    attributes:@{NSForegroundColorAttributeName:[UIColor kcLightGray]}];
        self.nameField.textAlignment = NSTextAlignmentCenter;
        self.nameField.returnKeyType = UIReturnKeyDone;
        self.nameField.delegate = self;
        [self.view addSubview:self.nameField];
    }
}

- (IBAction)touchDeletePlayerButton:(id)sender
{
    Player *lastPlayerAdded = [self.players lastObject];
    [self.players removeLastObject];

    //TODO: does not delete these when returning from kvc
    [lastPlayerAdded.nameLabel removeFromSuperview];
    [lastPlayerAdded.colorSquare removeFromSuperview];

    if ([self.players count] < 1) {
        self.deletePlayerButton.hidden = YES;
    }
    
    if ([self.players count] < 2) {
        self.traditionalButton.hidden = YES;
        self.alternateButton.hidden = YES;
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
    self.nameFieldBox.hidden = YES;
    
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
        [self findPlacement:player];
        [self displayPlayer:player];
    }
    
    
    //show start button if 2nd players added
    if ([self.players count] == MIN_PLAYERS) {
        self.traditionalButton.hidden = NO;
        self.alternateButton.hidden = NO;
    }
    
    
    //hide add player button if 6 players added
    if ([self.players count] == MAX_PLAYERS) {
        self.addPlayerButton.hidden = YES;
    }
    
    //show delete player button if there are at least 1 player
    if ([self.players count] >= 1) {
        self.deletePlayerButton.hidden = NO;
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


- (void)findPlacement:(Player *)player
{
    switch ([self.players count])
    {
        case 0:
            NSLog(@"Something went wrong with players count");
            break;
            
        case 1:
            player.xPlacement = 58;
            player.yPlacement = 265;
            break;
            
        case 2:
            player.xPlacement = 134;
            player.yPlacement = 265;
            break;
            
        case 3:
            player.xPlacement = 211;
            player.yPlacement = 265;
            break;
            
        case 4:
            player.xPlacement = 58;
            player.yPlacement = 350;
            break;
            
        case 5:
            player.xPlacement = 134;
            player.yPlacement = 350;
            break;
            
        case 6:
            player.xPlacement = 211;
            player.yPlacement = 350;
            break;
            
        default:
            NSLog(@"Something went wrong with players count");
            break;
    }
    
  
}


- (void)displayPlayer:(Player *)player
{
    //player's name
    player.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(player.xPlacement-10, player.yPlacement,70,50)];
    player.nameLabel.text = player.name;
    player.nameLabel.textAlignment = NSTextAlignmentCenter;
    [player.nameLabel setFont:[UIFont fontWithName:@"Pixelette" size:SMALL_FONT_SIZE]];
    player.nameLabel.textColor = [UIColor kcLightGray];
    [self.view addSubview:player.nameLabel];
    
    //player's color square
    player.colorSquare = [[UIButton alloc] initWithFrame:CGRectMake(player.xPlacement,(player.yPlacement + 35), 50, 50)];
    
    player.colorSquare.backgroundColor = player.color;
    //[player.colorSquare setImage:player.color forState:UIControlStateNormal];
    [self.view addSubview:player.colorSquare];
    player.colorSquare.enabled = NO;
    
}




#pragma mark <touch start buttons>

- (IBAction)touchTraditionalButton:(id)sender
{
    KingsCupViewController *kvc = [self.storyboard instantiateViewControllerWithIdentifier:@"kvc"];
    //send players array
    kvc.players = self.players;
    //send game state
    kvc.isTraditional = YES;
    //go to King's cup
    [self presentViewController:kvc animated:YES completion:nil];
}


- (IBAction)touchAlternateButton:(id)sender
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
                   /*
                   [UIImage imageNamed:@"bigColorSquareDarkGreen.png"],
                   [UIImage imageNamed:@"bigColorSquareMidGreen.png"],
                   [UIImage imageNamed:@"bigColorSquareLightGreen.png"],
                   [UIImage imageNamed:@"bigColorSquareYellow.png"],
                   [UIImage imageNamed:@"bigColorSquareOrange.png"],
                   [UIImage imageNamed:@"bigColorSquareRed.png"],
                    */
                   nil];
    }
    return _colors;
}


@end
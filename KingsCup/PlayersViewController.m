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

@interface PlayersViewController () <UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *players; //of Player
@property (strong, nonatomic) NSMutableArray *colors;  //of Color
@property (strong, nonatomic) UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *addPlayerButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

- (IBAction)touchStartButton:(id)sender;
- (IBAction)touchAddPlayerButton:(id)sender;
- (void)showPlayer:player;
@end


@implementation PlayersViewController

static const int MAX_PLAYERS = 6;
static const int MAX_NAME_LENGTH = 7;
static const int FONT_SIZE = 11;


- (IBAction)touchStartButton:(id)sender
{
    KingsCupViewController *kvc = [self.storyboard instantiateViewControllerWithIdentifier:@"kvc"];
    
    //send players array
    kvc.players = self.players;
    
    //send game style choice
    if (self.isTraditional) {
        kvc.isTraditional = YES;
        
    } else if (!self.isTraditional) {
        kvc.isTraditional = NO;
    }
    
    
    [self presentViewController:kvc animated:YES completion:nil];
}



- (void)touchAddPlayerButton:(id)sender
{
    self.addPlayerButton.enabled = NO;
    
    if ([self.players count] < MAX_PLAYERS ) {
        //make text field for name entry
        CGRect nameRect = CGRectMake(40, 150, 240, 30);
        self.nameField = [[UITextField alloc] initWithFrame:nameRect];
        self.nameField.borderStyle = UITextBorderStyleLine;
        self.nameField.placeholder = @"Enter your name";
        self.nameField.returnKeyType = UIReturnKeyDone;
        self.nameField.delegate = self;
        [self.view addSubview:self.nameField];
        
    } else {
        //TODO: add label or warning thingy
        NSLog(@"oops too many players");
    }
}



//When user finishes entering name
//print the user's stuff
- (BOOL)textFieldShouldReturn:(UITextField *)nameField
{
    self.addPlayerButton.enabled = YES;
    
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
        int numPlayers = [self.players count]; //if 5th time called, there are 5 saved players, get the 5th color in array
        player.color = self.colors[numPlayers];
        
        //save player
        [self.players addObject:player];
        
        //populate players into view
        [self showPlayer:player];
    }
    
    
    //show start button if 2nd player added
    if ([self.players count] == 2) {
        self.startButton.hidden = NO;
    }
    
    
    //hide keyboard and text field
    [nameField resignFirstResponder];
    nameField.text = @"";
    nameField.hidden = YES;
    return YES;
    
}



//print the player after it is created
- (void)showPlayer:(Player *)player
{
    
    CGFloat xPlacement = 0;
    CGFloat yPlacement = 0;
    
    switch ([self.players count])
    {
        case 0:
            NSLog(@"Something went wrong with players count");
            break;
            
        case 1:
            xPlacement = 50;
            yPlacement = 200;
            break;
            
        case 2:
            xPlacement = 120;
            yPlacement = 200;
            break;
            
        case 3:
            xPlacement = 190;
            yPlacement = 200;
            break;
            
        case 4:
            xPlacement = 50;
            yPlacement = 300;
            break;
            
        case 5:
            xPlacement = 120;
            yPlacement = 300;
            break;
            
        case 6:
            xPlacement = 190;
            yPlacement = 300;
            break;
            
        default:
            NSLog(@"Something went wrong with players count");
            break;
    }
    
  
    
    
    //player's name
    UILabel *playerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPlacement, yPlacement,50,50)];
    playerNameLabel.text = player.name;
    playerNameLabel.textAlignment = NSTextAlignmentCenter;
    playerNameLabel.font = [playerNameLabel.font fontWithSize:FONT_SIZE];
    //playerNameLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:playerNameLabel];
    
    //player's color square
    UILabel *playerColorSquare = [[UILabel alloc] initWithFrame:CGRectMake(xPlacement,(yPlacement + 30), 50, 50)];
    playerColorSquare.backgroundColor = player.color;
    [self.view addSubview:playerColorSquare];
}



//don't allow more than 10 characters in name
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > MAX_NAME_LENGTH) ? NO : YES;
}



- (NSMutableArray *)players
{
    if (!_players) {
        _players = [[NSMutableArray alloc]init];
    }
    return _players;
}



- (NSMutableArray *)colors
{
    if (!_colors) {
        _colors = [[NSMutableArray alloc] initWithObjects:
                   [UIColor redColor],
                   [UIColor yellowColor],
                   [UIColor greenColor],
                   [UIColor purpleColor],
                   [UIColor blueColor],
                   [UIColor orangeColor],
                   [UIColor blackColor],
                   [UIColor brownColor],
                   nil];
    }
    return _colors;
}



- (void)viewDidLoad
{
    //hide start button until at least 2 players are added
    self.startButton.hidden = YES;
}





@end
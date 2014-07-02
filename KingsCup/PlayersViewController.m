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
@property (weak, nonatomic) IBOutlet UIButton *startButton;

- (IBAction)touchStartButton:(id)sender;
- (IBAction)touchAddPlayer:(id)sender;
- (void)showPlayer:player;
@end


@implementation PlayersViewController

static const int MAX_PLAYERS = 6;

- (IBAction)touchStartButton:(id)sender
{
    KingsCupViewController *kvc = [self.storyboard instantiateViewControllerWithIdentifier:@"kvc"];
    kvc.players = self.players;
    [self presentViewController:kvc animated:YES completion:nil];
}

- (void)touchAddPlayer:(id)sender
{
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



- (BOOL)textFieldShouldReturn:(UITextField *)nameField
{
    //TODO: add user validation
    
    //create and save player
    Player *player = [[Player alloc]init];
    player.name = nameField.text;
    player.color = self.colors[[self.players count]]; //if 5th time called, there are 5 saved players, get the 5th color in array
    [self.players addObject:player];
    
    //populate players into view
    [self showPlayer:player];
    
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



- (void)showPlayer:(Player *)player
{
    int xPlacement = 0;
    int yPlacement = 0;
    
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
    UILabel *playerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPlacement,yPlacement,50,50)];
    playerNameLabel.text = player.name;
    [self.view addSubview:playerNameLabel];
    playerNameLabel.textAlignment = NSTextAlignmentCenter;
    //TODO: this bugs out kings cup controller nameLabel
    playerNameLabel.adjustsFontSizeToFitWidth = YES;
    
    //player's color square
    UILabel *playerColorSquare = [[UILabel alloc] initWithFrame:CGRectMake(xPlacement,(yPlacement + 30), 50, 50)];
    playerColorSquare.backgroundColor = player.color;
    [self.view addSubview:playerColorSquare];
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



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //send game rules to king's cup VC
    KingsCupViewController *kingsCupVC = segue.destinationViewController;
    
    if (self.isTraditional) {
        kingsCupVC.isTraditional = YES;
        
    } else if (!self.isTraditional) {
        kingsCupVC.isTraditional = NO;
    }
}


- (void)viewDidLoad
{
    //hide start button so at least 2 players are added
    self.startButton.hidden = YES;
    
    
    
}


@end
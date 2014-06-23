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

- (IBAction)touchAddPlayer:(id)sender;
@end

@implementation PlayersViewController

- (void)touchAddPlayer:(id)sender
{
    self.nameField.hidden = NO;
}



- (BOOL)textFieldShouldReturn:(UITextField *)nameField
{
    //create and save the player
    Player *player = [[Player alloc]init];
    player.name = nameField.text;
    player.color = self.colors[0];
    [self.colors removeObjectAtIndex:0];
    //add player to array
    [self.players addObject:player];
    NSLog(@"%@", player.name);
    NSLog(@"%@", player.color);
    
    //hide keyboard and text field
    [nameField resignFirstResponder];
    nameField.text = @"";
    nameField.hidden = YES;
    return YES;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //should put in method?
    //make text field for name entry
    CGRect nameRect = CGRectMake(40, 150, 240, 30);
    self.nameField = [[UITextField alloc] initWithFrame:nameRect];
    self.nameField.borderStyle = UITextBorderStyleLine;
    self.nameField.placeholder = @"Enter your name";
    self.nameField.returnKeyType = UIReturnKeyDone;
    self.nameField.delegate = self;
    [self.view addSubview:self.nameField];
    //keep hidden until touchAddPlayer
    self.nameField.hidden = YES;
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



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
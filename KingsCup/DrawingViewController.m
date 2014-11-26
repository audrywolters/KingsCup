//
//  PictionaryViewController.m
//  KingsCup
//
//  Created by Audry Wolters on 6/20/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import "DrawingViewController.h"
#import "CardData.h"
#import "DrawerView.h"
#import "UIColor+KCColors.h"

@interface DrawingViewController ()

@property (weak, nonatomic) IBOutlet UIButton *returnToGameButton;
@property (weak, nonatomic) IBOutlet UIButton *generateRandomWordButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *startTimerButton;
@property (weak, nonatomic) IBOutlet UILabel *randomWordLabel;
@property (nonatomic) int seconds;
@property (strong, nonatomic) UILabel *timerLabel;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) DrawerView *drawer;

- (IBAction)touchReturnToGame:(id)sender;
- (IBAction)touchGenerateRandomWord:(id)sender;
- (IBAction)touchStartTimer:(id)sender;
- (IBAction)touchClearButton:(id)sender;

@end

@implementation DrawingViewController

static const int SMALL_FONT = 11;
static const int BODY_FONT = 15;
static const int BUTTON_FONT = 17;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setScreen];
    
    //clear button
    [self.clearButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:BODY_FONT]];
    [self.clearButton setTitleColor:[UIColor kcRed] forState:UIControlStateNormal];
    self.clearButton.hidden = YES;
    
    //random word button
    [self.generateRandomWordButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:SMALL_FONT]];
    [self.generateRandomWordButton setTitleColor:[UIColor kcRed] forState:UIControlStateNormal];
    
    //back button
    [self.returnToGameButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:BODY_FONT]];
    [self.returnToGameButton setTitleColor:[UIColor kcRed] forState:UIControlStateNormal];
    
    
    self.startTimerButton.hidden = YES;
}


- (IBAction)touchStartTimer:(id)sender
{
    //show/hide buttons and label
    self.randomWordLabel.hidden = YES;
    self.startTimerButton.hidden = YES;
    self.randomWordLabel.hidden = YES;
    self.clearButton.hidden = NO;
    
    //start timer
    self.seconds = 60;
    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(111, 10, 100, 40)];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
    
}

- (IBAction)touchClearButton:(id)sender
{
    [self setScreen];
}


- (void)runTimer
{
    //run timer every one second
    self.seconds = self.seconds - 1;
    self.timerLabel.text = [NSString stringWithFormat:@":%i", self.seconds];
    self.timerLabel.textColor = [UIColor kcMidGreen];
    self.timerLabel.font = [UIFont fontWithName:@"Pixelette" size:BUTTON_FONT];
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


- (IBAction)touchGenerateRandomWord:(id)sender
{
    //get rid of button
    self.generateRandomWordButton.hidden = YES;
    
    //get random word
    CardData *data = [[CardData alloc]init];
    int randomNum = arc4random();
    int index = randomNum % [data.charadesWords count];
    NSString *randomWord = data.drawingWords[index];
    [data.drawingWords removeObjectAtIndex:index];

    //random word & start button
    //show random word
    self.randomWordLabel.hidden = NO;
    self.randomWordLabel.text = randomWord;
    self.randomWordLabel.font = [UIFont fontWithName:@"Pixelette" size:BUTTON_FONT];
    self.randomWordLabel.textColor = [UIColor kcDarkGray];
    
    //show start button
    [self.startTimerButton.titleLabel setFont:[UIFont fontWithName:@"Pixelette" size:BUTTON_FONT]];
    [self.startTimerButton setTitleColor:[UIColor kcRed] forState:UIControlStateNormal];
    self.startTimerButton.hidden = NO;
}


- (IBAction)touchReturnToGame:(id)sender
{
    [self dismissViewControllerAnimated:YES completion: nil];
}


- (void)setScreen
{
    //make the drawer view
    self.drawer = [[DrawerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:self.drawer];
    [self.view bringSubviewToFront:self.drawer];
    
    //bring buttons to front
    [self.view bringSubviewToFront:self.startTimerButton];
    [self.view bringSubviewToFront:self.generateRandomWordButton];
    [self.view bringSubviewToFront:self.returnToGameButton];
    [self.view bringSubviewToFront:self.clearButton];
    [self.view bringSubviewToFront:self.randomWordLabel];
}


@end

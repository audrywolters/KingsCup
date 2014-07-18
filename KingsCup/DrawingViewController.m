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

@interface DrawingViewController ()

@property (weak, nonatomic) UIButton *returnToGameButton;
@property (weak, nonatomic) UIButton *generateRandomWordButton;
@property (strong, nonatomic) UILabel *randomWordLabel;
@property (weak, nonatomic) UIButton *startTimerButton;
@property (nonatomic) int seconds;
@property (strong, nonatomic) UILabel *timerLabel;
@property (nonatomic) NSTimer *timer;
//drawing stuff
//@property (strong, nonatomic) UIBezierPath *path;
@property (nonatomic) DrawerView *drawer;

- (IBAction)touchReturnToGame:(id)sender;
- (IBAction)touchGenerateRandomWord:(id)sender;
- (IBAction)touchStartTimer:(id)sender;

@end

@implementation DrawingViewController




- (IBAction)touchStartTimer:(id)sender
{
    //hide random word
    [self.randomWordLabel removeFromSuperview];
    
    //hide start button
    [self.startTimerButton removeFromSuperview];
    
    //start timer
    self.seconds = 60;
    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
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




- (IBAction)touchGenerateRandomWord:(id)sender
{
    //get rid of button
    [self.generateRandomWordButton removeFromSuperview];
    
    //get random word
    CardData *data = [[CardData alloc]init];
    int randomNum = arc4random();
    int index = randomNum % [data.charadesWords count];
    NSString *randomWord = data.drawingWords[index];
    [data.drawingWords removeObjectAtIndex:index];
    
    //show random word
    self.randomWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(81, 100, 100, 40)];
    self.randomWordLabel.text = randomWord;
    [self.view addSubview:self.randomWordLabel];
    
    //show start button
    self.startTimerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.startTimerButton addTarget:self action:@selector(touchStartTimer:) forControlEvents:UIControlEventTouchUpInside];
    [self.startTimerButton setTitle:@"Start" forState:UIControlStateNormal];
    self.startTimerButton.frame = CGRectMake(100, 100, 100, 40);
    [self.view addSubview:self.startTimerButton];
    
    
    
}


- (IBAction)touchReturnToGame:(id)sender
{
    [self dismissViewControllerAnimated:YES completion: nil];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //make back button
    self.returnToGameButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.returnToGameButton addTarget:self action:@selector(touchReturnToGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.returnToGameButton setTitle:@"back" forState:UIControlStateNormal];
    self.returnToGameButton.frame = CGRectMake(80, 210, 160, 40);
    [self.view addSubview:self.returnToGameButton];
    
    //make random word button
    self.generateRandomWordButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.generateRandomWordButton addTarget:self action:@selector(touchGenerateRandomWord:) forControlEvents:UIControlEventTouchUpInside];
    [self.generateRandomWordButton setTitle:@"Generate Random Word" forState:UIControlStateNormal];
    self.generateRandomWordButton.frame = CGRectMake(81, 100, 100, 40);
    [self.view addSubview:self.generateRandomWordButton];
    
    //make the drawer view
    self.drawer = [[DrawerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //self.drawer = [[DrawerView alloc] initWithFrame:CGRectMake(0, 10, 200, 200)];
    [self.view addSubview:self.drawer];
   
}

     


@end

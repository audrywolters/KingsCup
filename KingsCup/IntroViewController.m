//
//  IntroViewController.m
//  KingsCup
//
//  Created by Audry Wolters on 6/9/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import "IntroViewController.h"
#import "CardData.h"

@interface IntroViewController ()
//- (IBAction)traditionalRulesClick:(id)sender;
//- (IBAction)alternateRulesClick:(id)sender;

@end

@implementation IntroViewController

/*
 - (IBAction)traditionalRulesClick:(id)sender {
     PlayersViewController *playersVC = [[PlayersViewController alloc] init];
     playersVC.isTraditional = YES;
     [self.navigationController pushViewController:playersVC animated:YES];
 
     CardData *cardData = [[CardData alloc] init];
     cardData.isTraditional = YES;
 }

- (IBAction)alternateRulesClick:(id)sender {
    CardData *cardData = [[CardData alloc] init];
    cardData.isTraditional = NO;
}
*/


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PlayersViewController *playersVC = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"toTraditionalPlayers"]) {
        playersVC.isTraditional = YES;
    
    } else if ([segue.identifier isEqualToString:@"toAlternatePlayers"]) {
        playersVC.isTraditional = NO;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

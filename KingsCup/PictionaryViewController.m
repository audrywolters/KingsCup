//
//  PictionaryViewController.m
//  KingsCup
//
//  Created by Audry Wolters on 6/20/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import "PictionaryViewController.h"

@interface PictionaryViewController ()

@property (weak, nonatomic) UIButton *returnToGameButton;
- (IBAction)touchReturnToGame:(id)sender;

@end

@implementation PictionaryViewController




- (IBAction)touchReturnToGame:(id)sender
{
    [self dismissViewControllerAnimated:YES completion: nil];
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
    
    self.returnToGameButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.returnToGameButton addTarget:self action:@selector(touchReturnToGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.returnToGameButton setTitle:@"back" forState:UIControlStateNormal];
    self.returnToGameButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:self.returnToGameButton];
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

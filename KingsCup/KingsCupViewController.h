//
//  KingsCupViewController.h
//  KingsCup
//
//  Created by Audry Wolters on 6/5/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroViewController.h"
#import "DrawingViewController.h"

@interface KingsCupViewController : UIViewController

@property (nonatomic) BOOL isTraditional;
@property (strong, nonatomic) NSMutableArray *players;

@end

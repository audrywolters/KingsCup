//
//  CardData.m
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import "CardData.h"
@implementation CardData



+ (NSArray *) suits
{
    return [NSArray arrayWithObjects: [UIImage imageNamed:@"hearts.png"],
                                [UIImage imageNamed:@"diamonds.png"],
                                [UIImage imageNamed:@"clubs.png"],
                                [UIImage imageNamed:@"spades.png"],
                                nil];
    
    //return @[@"<3", @"C>", @"c3", @"<>"];
}



+ (NSArray *)faces
{
    return @[@"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}


+ (NSArray *) titles
{
    return @[@"Waterfall", @"Give 2", @"Give 3", @"Give 2, Take 2",
             @"Rule", @"Thumbs", @"Raise Hand To Heaven", @"Mate",
             @"Rhyme", @"Categories", @"Boys Drink", @"Girls Drink", @"King's Cup"];
}


+ (NSArray *) descriptions
{
    return @[@"each player starts drinking at the same time as the person to their left. you can’t stop until the player before you does!",
             @"assign 2 drinks to a player",
             @"take 3 drinks",
             @"assign 2 drinks, take 2 drinks",
             @"make up a rule to follow for the rest of the game\ni.e. drink with left hand, no first names, etc",
             @"last person to put their thumb on the table drinks",
             @"last person to raise their hand drinks",
             @"choose a player to drink when you do\n(but only because of a rule)",
             @"say a word. rhyme that word in a circle until a player repeats a word or flubs then they must drink",
             @"think of a category of things i.e.brands of gum. players name item of said category in a circle until a repeat or flub. that player must drink",
             @"all males drink",
             @"all girls drink",
             @"see that big cup in the middle of the table? pour some of your drink in it. last person to draw a king must drink the whole cup!"];
}

@end

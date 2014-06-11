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
    return @[@"<3", @"C>", @"c3", @"<>"];
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
    return nil;
}

@end

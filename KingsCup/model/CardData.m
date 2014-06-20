//
//  CardData.m
//  KingsCup
//
//  Created by Audry Wolters on 6/6/14.
//  Copyright (c) 2014 audrywolters. All rights reserved.
//

#import "CardData.h"
@implementation CardData


- (void) makeTraditionalDeck
{
    self.suits = [NSArray arrayWithObjects: [UIImage imageNamed:@"hearts.png"],
                                [UIImage imageNamed:@"diamonds.png"],
                                [UIImage imageNamed:@"clubs.png"],
                                [UIImage imageNamed:@"spades.png"],
                                nil];
    
    self.faces = @[@"A",
                   @"2",
                   @"3",
                   @"4",
                   @"5",
                   @"6",
                   @"7",
                   @"8",
                   @"9",
                   @"10",
                   @"J",
                   @"Q",
                   @"K"];
    
    self.titles = @[@"Waterfall",
                    @"Give 2",
                    @"Give 3",
                    @"Give 2, Take 2",
                    @"Rule",
                    @"Thumbs",
                    @"Raise Hand To Heaven",
                    @"Drink Mate",
                    @"Rhyme",
                    @"Categories",
                    @"Boys Drink",
                    @"Girls Drink",
                    @"King's Cup"];
    
    self.descriptions = @[@"each player starts drinking at the same time as the person to their left. you can’t stop until the player before you does!",
                          @"assign 2 drinks to a player or 1 drink to 2 players",
                          @"take 3 drinks",
                          @"assign 2 drinks, take 2 drinks",
                          @"make a rule to follow for the rest of the game i.e. drink with left hand, no first names. rule breakers must drink.",
                          @"last person to put their thumb on the table drinks",
                          @"last person to raise their hand drinks",
                          @"choose a player to drink when you do. player may already be a drink mate!",
                          @"say a word. go in a circle rhyming that word until a player messes up. that player must drink.",
                          @"name a category of things i.e. metal bands. go in a circle naming items of said category until someone messes up. that player must drink!",
                          @"all males drink!",
                          @"all females drink!",
                          @"pour some of your drink into that big cup on the table. last person to draw a king must drink the whole cup!"];
}


- (void) makeAlternateDeck
{
    self.suits = [NSArray arrayWithObjects: [UIImage imageNamed:@"hearts.png"],
                  [UIImage imageNamed:@"diamonds.png"],
                  [UIImage imageNamed:@"clubs.png"],
                  [UIImage imageNamed:@"spades.png"],
                  nil];
    
    self.faces = @[@"A",
                   @"2",
                   @"3",
                   @"4",
                   @"5",
                   @"6",
                   @"7",
                   @"8",
                   @"9",
                   @"10",
                   @"J",
                   @"Q",
                   @"K"];
    
    self.titles = @[@"I’ve Never",
                    @"Story",
                    @"Charades",
                    @"Pictionary",
                    @"Rule",
                    @"Truth or Dare",
                    @"Dance Party",
                    @"Drink Mate",
                    @"Rhyme",
                    @"Categories",
                    @"Boy Likers Drink",
                    @"Girl Likers Drink",
                    @"King's Cup"];
    
    self.descriptions = @[@"everyone hold up 3 fingers. go in a circle naming things you've never done. if a player has done that they must lower a     finger. first player to run out of fingers must drink! ",
                          @"say a word. the next player repeats that word and adds one of their own. go in a circle repeating the whole story until someone messes up. that player must drink!",
                          @"act out a random word. if other players cannot guess that word in 1 minute, the actor must drink!",
                          @"draw a picture of a random word. if players cannot guess that word in 1 minute, the drawer must drink!",
                          @"make a rule to follow for the rest of the game i.e. drink with left hand, no first names. rule breakers must drink.",
                          @"player to draw this card must choose truth or dare. if player won't answer they must drink!",
                          @"everybody dance!",
                          @"choose a player to drink when you do. player may already be a drink mate!",
                          @"say a word. go in a circle rhyming that word until a player messes up. that player must drink!",
                          @"name a category of things i.e. metal bands. go in a circle naming items of said category until someone messes up. that player must drink!",
                          @"if you like boys (you know, in that way) drink!",
                          @"if you like girls (you know, in that way) drink!",
                          @"pour some of your drink into that big cup on the table. last person to draw a king must drink the whole cup!"];
}



@end

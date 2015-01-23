//
//  PlayGameHistoryViewController.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/23/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "PlayGameHistoryViewController.h"
#import "Card.h"

@interface PlayGameHistoryViewController ()

@end

@implementation PlayGameHistoryViewController

- (void)updateUI
{
    NSMutableString *string = [[NSMutableString alloc] init];
    for(CardMatchingGameMove *move in self.moves)
    {
        if (move.moveType != MoveTypeCommon)
            [string appendFormat:@"%@\n", [self stringFromMove:move]];
    }
    self.history.text = string;
}

- (NSString *)stringFromMove:(CardMatchingGameMove *)move
{
    NSString *result = nil;
    switch(move.moveType)
    {
        case MoveTypeCommon:
            result = [self stringFromCards:move.cards];
            break;
        case MoveTypeDontMatch:
            result = [NSString stringWithFormat:@"%@ don`t match! %d points penalty!",
                      [self stringFromCards:move.cards], abs((int)move.score)];
            break;
        case MoveTypeMatch:
            result = [NSString stringWithFormat:@"Matched %@ for %d points!",
                      [self stringFromCards:move.cards], (int)move.score];
            break;
    }
    return result;
}

- (NSString *)stringFromCards:(NSArray *)cards
{
    NSMutableString *result = [[NSMutableString alloc] init];
    for(Card *card in cards)
    {
        [result appendFormat:@"%@", card.contents];
    }
    return result;
}

@end

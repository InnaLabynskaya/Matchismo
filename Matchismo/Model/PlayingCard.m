//
//  PlayingCard.m
//  Matchizmo
//
//  Created by InnaL on 1/5/15.
//  Copyright (c) 2015 InnaL. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for(int i = 0; i < otherCards.count; i++){
        PlayingCard *card = [otherCards objectAtIndex:i];
        for(int j = i + 1; j < otherCards.count; j++){
            PlayingCard *otherCard = [otherCards objectAtIndex:j];
            if([card.suit isEqualToString:otherCard.suit]){
                score += 1;
            } else if(card.rank == otherCard.rank){
                score += 4;
            }
        }
        if([self.suit isEqualToString:card.suit]){
            score += 1;
        } else if(self.rank == card.rank){
            score += 4;
        }
    }
    return score;
}

-(NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    
}

@synthesize suit = _suit;

+(NSArray *) validSuits{
    return @[@"♠",@"♥",@"♦",@"♣"];
}

+(NSArray *) rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank {
    return[[self rankStrings] count] - 1;
}

-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

-(void) setSuit:(NSString *)suit{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

-(NSString *) suit
{
    return _suit ? _suit : @"?";
}

@end

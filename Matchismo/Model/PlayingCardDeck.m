//
//  PlayingCardDeck.m
//  Matchizmo
//
//  Created by Inna Labuskaya on 1/6/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "PlayingCardDeck.h"

@implementation PlayingCardDeck

- (instancetype) init
{
    self = [super init];
    if(self){
        for(NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++){
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
        
    }
    return self;
}

@end

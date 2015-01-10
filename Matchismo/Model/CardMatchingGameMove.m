//
//  CardMatchingGameMove.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/10/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "CardMatchingGameMove.h"

@implementation CardMatchingGameMove

- (instancetype)initWithMoveType:(CardMatchingGameMoveType)moveType
                           cards:(NSArray *)cards
                           score:(NSInteger)score
{
    self = [super init];
    if(self) {
        _moveType = moveType;
        _cards = cards;
        _score = score;
    }
    return self;
}

@end

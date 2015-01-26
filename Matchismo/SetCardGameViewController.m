//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/21/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (CardMatchingGame*)createGame:(NSUInteger)openCards
{
    CardMatchingGame *game = [[CardMatchingGame alloc] initWithCardDeck:[[SetCardDeck alloc]init]];
    game.matchCards = 3;
    return game;
}

@end

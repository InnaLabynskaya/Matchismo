//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by InnaL on 1/6/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "CardMatchingGameMove.h"

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic) NSUInteger matchCards;

@property (nonatomic, readonly, strong) NSMutableArray *chosenCards;

@end

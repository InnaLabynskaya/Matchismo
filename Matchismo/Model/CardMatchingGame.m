//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by InnaL on 1/6/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end


@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if(self){
        for(int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
              [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
        self.matchCards = 2;
    }
    return self;
}

#define MISMATCH_PENALTY 2
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
        } else {
            NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
            for(Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    [chosenCards addObject:otherCard];
                }
            }
            card.chosen = YES;
            if(chosenCards.count + 1 >= self.matchCards){
                int matchScore = [card match:chosenCards];
                if(matchScore != 0){
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for(Card *otherCard in chosenCards) {
                        otherCard.matched = YES;
                    }
                } else {
                    self.score -= MISMATCH_PENALTY;
                    for(Card *otherCard in chosenCards) {
                        otherCard.chosen = NO;
                    }
                }
            } else {
                self.score -= COST_TO_CHOOSE;
            }
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ?
    self.cards[index] : nil;
}

@end

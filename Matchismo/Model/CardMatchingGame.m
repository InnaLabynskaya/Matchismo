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
@property (nonatomic, strong) NSMutableArray *moves;
@property (nonatomic, strong) NSMutableArray *chosenCards;

@end


@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)moves
{
    if(!_moves) _moves = [[NSMutableArray alloc] init];
    return _moves;
}

- (NSMutableArray *)chosenCards
{
    if(!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
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

#define MISMATCH_PENALTY (-2)
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = -1;

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
            [self.chosenCards removeObject:card];
            [self.moves addObject:[[CardMatchingGameMove alloc]
                                   initWithMoveType:MoveTypeCommon
                                   cards:self.chosenCards
                                   score:0]];
        } else {
            if(self.chosenCards.count + 1 >= self.matchCards) {
                int matchScore = [card match:self.chosenCards];
                if(matchScore != 0) {
                    self.score += matchScore * MATCH_BONUS + COST_TO_CHOOSE;
                    card.matched = YES;
                    for(Card *otherCard in self.chosenCards) {
                        otherCard.matched = YES;
                    }
                    card.chosen = YES;
                    [self.chosenCards addObject:card];
                    [self.moves addObject:[[CardMatchingGameMove alloc]
                                           initWithMoveType:MoveTypeMatch
                                           cards:self.chosenCards
                                           score:matchScore*MATCH_BONUS + COST_TO_CHOOSE]];
                    self.chosenCards = nil;
                } else {
                    self.score += MISMATCH_PENALTY + COST_TO_CHOOSE;
                    for(Card *otherCard in self.chosenCards) {
                        otherCard.chosen = NO;
                    }
                    card.chosen = YES;
                    [self.moves addObject:[[CardMatchingGameMove alloc]
                                           initWithMoveType:MoveTypeDontMatch
                                           cards:[self.chosenCards arrayByAddingObject:card]
                                           score:MISMATCH_PENALTY + COST_TO_CHOOSE]];
                    self.chosenCards = nil;
                    [self.chosenCards addObject:card];
                }
            } else {
                self.score += COST_TO_CHOOSE;
                card.chosen = YES;
                [self.chosenCards addObject:card];
                [self.moves addObject:[[CardMatchingGameMove alloc]
                                       initWithMoveType:MoveTypeCommon
                                       cards:self.chosenCards
                                       score:COST_TO_CHOOSE]];
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

//
//  ViewController.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/6/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (CardMatchingGame *)game
{
    if(!_game) {
        _game = [self createGame:[self.cardButtons count]];
    }
    return _game;
}

-(Deck *)createDeck
{
    return nil;
}

- (CardMatchingGame*)createGame:(NSUInteger)openCards
{
    return [[CardMatchingGame alloc] initWithCardCount:openCards usingDeck:[self createDeck]];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (IBAction)touchReDealButton:(UIButton *)sender
{
    self.game = nil;
    [self updateUI];
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        NSUInteger cardIndex =[self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [self updateButton:cardButton fromCard:card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
    self.textLabel.text = [self stringFromMove:self.game.moves.lastObject];
}

- (void)updateButton:(UIButton*)button fromCard:(Card*)card
{
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

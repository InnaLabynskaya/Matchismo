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
#import "HistoryViewController.h"

@interface ViewController ()

@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"History"]){
        if([segue.destinationViewController isKindOfClass:[HistoryViewController class]]){
            HistoryViewController *tsvc = (HistoryViewController *)segue.destinationViewController;
            tsvc.moves = self.game.moves;
        }
    }
}

- (CardMatchingGame *)game
{
    if(!_game) {
        _game = [self createGame];
    }
    return _game;
}

-(Deck *)createDeck
{
    return nil;
}

- (CardMatchingGame*)createGame
{
    return [[CardMatchingGame alloc] initWithCardDeck:[self createDeck]];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (IBAction)touchReDealButton:(UIBarButtonItem *)sender
{
    self.game = nil;
    [self updateUI];
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [self updateButton:cardButton fromCard:card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
}

- (void)updateButton:(UIButton*)button fromCard:(Card*)card
{
}

@end

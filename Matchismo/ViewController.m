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

- (CardMatchingGame*)createGame
{
    return nil;
}

- (IBAction)touchReDealButton:(UIBarButtonItem *)sender
{
    self.game = nil;
    [self updateUI];
}

- (void)updateUI
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
}

@end

//
//  ViewController.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/6/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

@implementation ViewController

- (CardMatchingGame *)game
{
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        if(self.segmentControl.selectedSegmentIndex == 0){
            _game.matchCards = 2;
        } else {
            _game.matchCards = 3;
        }
    }
    
    return _game;
}

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.segmentControl.enabled = NO;
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (IBAction)touchReDealButton:(UIButton *)sender
{
    self.segmentControl.enabled = YES;
    self.game = nil;
    [self updateUI];
}

- (IBAction)segmentControlChange:(UISegmentedControl *)sender
{
    if(sender.selectedSegmentIndex == 0) {
        self.game.matchCards = 2;
    } else {
        self.game.matchCards = 3;
    }
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        NSUInteger cardIndex =[self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"card_front" : @"card_back"];
}
@end

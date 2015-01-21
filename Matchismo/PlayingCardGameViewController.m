//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/21/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}

- (void)updateButton:(UIButton*)button fromCard:(Card*)card
{
    [button setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [button setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    button.enabled = !card.isMatched;
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

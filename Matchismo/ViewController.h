//
//  ViewController.h
//  Matchismo
//
//  Created by Inna Labuskaya on 1/6/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController : UIViewController

- (Deck *)createDeck;
- (CardMatchingGame*)createGame:(NSUInteger)openCards;
- (void)updateButton:(UIButton*)button fromCard:(Card*)card;
- (void)updateUI;

@end


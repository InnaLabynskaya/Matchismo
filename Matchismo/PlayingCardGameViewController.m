//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/21/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "Grid.h"

@interface PlayingCardGameViewController ()

@property (nonatomic, strong) NSMutableArray *cardViews;

@end

@implementation PlayingCardGameViewController

- (NSMutableArray *)cardViews
{
    if(!_cardViews)
        _cardViews =[[NSMutableArray alloc]init];
    return _cardViews;
}

- (CardMatchingGame*)createGame
{
    CardMatchingGame *game = [[CardMatchingGame alloc] initWithCardDeck:[[PlayingCardDeck alloc]init]];
    [self initGame:game];
    return game;
}

- (void)initGame:(CardMatchingGame*)game
{
    const NSUInteger cards = 25;
    Grid *grid = [[Grid alloc]init];
    CGPoint offset = CGPointMake(16, 100);
    grid.size = CGSizeMake(self.view.frame.size.width - offset.x*2, self.view.frame.size.height - offset.y);
    grid.cellAspectRatio = 2.0/2.8;
    grid.minimumNumberOfCells = cards;
    
    CGRect frame = CGRectZero;
    frame.origin = CGPointMake(-[grid cellSize].width, -[grid cellSize].height);
    frame.size = CGSizeMake([grid cellSize].width * 0.9, [grid cellSize].height * 0.9);
    //remove old cards from view
    float delay = 0;
    if (self.cardViews.count) {
        delay = self.cardViews.count * 0.1;
        for (int i = 0; i < self.cardViews.count; ++i) {
            PlayingCardView *view = self.cardViews[i];
            [UIView animateWithDuration:0.3
                                  delay:i*0.1
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 view.center = CGPointMake(-[grid cellSize].width, -[grid cellSize].height);
                             }
                             completion:^(BOOL finished) {
                                 [view removeFromSuperview];
                             }];
        }
        self.cardViews = nil;
    }
    //create new cards
    for (int i = 0; i < cards; ++i) {
        PlayingCard* card = (PlayingCard*)[game drawCard];
        PlayingCardView *view = [[PlayingCardView alloc]initWithFrame:frame];
        view.suit = card.suit;
        view.rank = card.rank;
        view.faceUp = NO;
        CGPoint position = [grid centerOfCellAtRow:i/grid.columnCount inColumn:i%grid.columnCount];
        [UIView animateWithDuration:0.3
                              delay:delay+i*0.1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             view.center = CGPointMake(offset.x+position.x, offset.y+position.y);
                         }
                         completion:^(BOOL finished) {}];
        UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [view addGestureRecognizer:tapRecognizer];
        [self.cardViews addObject:view];
        [self.view addSubview:view];
    }
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    NSUInteger cardIndex = [self.cardViews indexOfObject:sender.view];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI
{
    [super updateUI];
    for(PlayingCardView *cardView in self.cardViews){
        NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:cardIndex];
        cardView.faceUp = card.isChosen;
        cardView.alpha = card.isMatched? 0.5: 1.0;
    }
}

@end

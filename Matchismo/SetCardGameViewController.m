//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/21/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "Grid.h"
#import "SetCardView.h"

@interface SetCardGameViewController ()
@property (weak, nonatomic) IBOutlet UIView *boardView;
@property(nonatomic, strong)NSMutableArray *cardViews;
@end

@implementation SetCardGameViewController

-(NSMutableArray *)cardViews
{
    if(!_cardViews)
        _cardViews =[[NSMutableArray alloc]init];
    return _cardViews;
}

- (CardMatchingGame*)createGame
{
    CardMatchingGame *game = [[CardMatchingGame alloc] initWithCardDeck:[[SetCardDeck alloc]init]];
    game.matchCards = 3;
    [self initGame:game];
    return game;
}

- (void)initGame:(CardMatchingGame*)game
{
    const NSUInteger cards = 12;
    Grid *grid = [[Grid alloc]init];
    grid.size = self.boardView.frame.size;
    grid.cellAspectRatio = 2.0/2.8;
    grid.minimumNumberOfCells = cards;
    
    CGRect frame = CGRectZero;
    frame.origin = CGPointMake(-self.view.frame.size.width, -self.view.frame.size.height);
    frame.size = CGSizeMake([grid cellSize].width * 0.9, [grid cellSize].height * 0.9);
    //remove old cards from view
    float delay = 0;
    if (self.cardViews.count) {
        delay = self.cardViews.count * 0.1;
        for (int i = 0; i < self.cardViews.count; ++i) {
            SetCardView *view = self.cardViews[i];
            [UIView animateWithDuration:0.3
                                  delay:i*0.1
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 view.center = CGPointMake(-self.view.frame.size.width, -self.view.frame.size.height);
                             }
                             completion:^(BOOL finished) {
                                 [view removeFromSuperview];
                             }];
        }
        self.cardViews = nil;
    }
    //create new cards
    for (int i = 0; i < cards; ++i) {
        SetCard* card = (SetCard*)[game drawCard];
        SetCardView *view = [[SetCardView alloc] initWithFrame:frame];
        view.color = card.color;
        view.shape = card.shape;
        view.shading = card.shading;
        view.number = card.number;
        CGPoint position = [grid centerOfCellAtRow:i/grid.columnCount inColumn:i%grid.columnCount];
        [UIView animateWithDuration:0.3
                              delay:delay+i*0.1
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             view.center = position;
                         }
                         completion:^(BOOL finished) {}];
        UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [view addGestureRecognizer:tapRecognizer];
        [self.cardViews addObject:view];
        [self.boardView addSubview:view];
    }
}

- (IBAction)addCards:(id)sender
{
    const NSUInteger maxCardsOnBoard = 20;
    NSUInteger cards = 3;
    if (self.cardViews.count+cards>maxCardsOnBoard) {
        cards = maxCardsOnBoard - self.cardViews.count;
    }
    Grid *grid = [[Grid alloc]init];
    grid.size = self.boardView.frame.size;
    grid.cellAspectRatio = 2.0/2.8;
    grid.minimumNumberOfCells = self.cardViews.count + cards;
    
    CGRect frame = CGRectZero;
    frame.origin = CGPointMake(-[grid cellSize].width, -[grid cellSize].height);
    frame.size = CGSizeMake([grid cellSize].width * 0.9, [grid cellSize].height * 0.9);
    for (int i = 0; i < cards; ++i) {
        SetCard* card = (SetCard*)[self.game drawCard];
        SetCardView *view = [[SetCardView alloc] initWithFrame:frame];
        view.color = card.color;
        view.shape = card.shape;
        view.shading = card.shading;
        view.number = card.number;
        UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [view addGestureRecognizer:tapRecognizer];
        [self.cardViews addObject:view];
        [self.boardView addSubview:view];
    }
    NSTimeInterval delay = 0;
    for(int i = 0; i < self.cardViews.count; i++) {
        SetCardView *view = self.cardViews[i];
        CGPoint position = [grid centerOfCellAtRow:i/grid.columnCount inColumn:i%grid.columnCount];
        if (!CGPointEqualToPoint(view.center, position) || !CGSizeEqualToSize(view.bounds.size, frame.size))
        {
            [UIView animateWithDuration:0.3
                                  delay:delay
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 view.center = position;
                                 CGRect bounds = view.bounds;
                                 bounds.size = frame.size;
                                 view.bounds = bounds;
                             }
                             completion:^(BOOL finished) {}];
            delay += i > self.cardViews.count - cards - 1 ? 0.1: 0.0;
        }
    }
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    NSUInteger cardIndex = [self.cardViews indexOfObject:sender.view];
    [self.game chooseCardAtIndex:cardIndex];
    NSIndexSet *removedIndexes = [self.game removeMatchedCards];
    if(removedIndexes.count) {
        [self removeCardsAtIndexes:removedIndexes];
    }
    [self updateUI];
}

- (void)removeCardsAtIndexes:(NSIndexSet*)removedIndexes
{
    NSArray *removedCards = [self.cardViews objectsAtIndexes:removedIndexes];
    [self.cardViews removeObjectsAtIndexes:removedIndexes];
    for(SetCardView *view in removedCards)
    {
        [UIView animateWithDuration:0.3 animations:^{
            view.center = CGPointMake(-self.view.frame.size.width, -self.view.frame.size.height);
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    Grid *grid = [[Grid alloc]init];
    grid.size = self.boardView.frame.size;
    grid.cellAspectRatio = 2.0/2.8;
    grid.minimumNumberOfCells = self.cardViews.count;
    CGRect frame = CGRectZero;
    frame.size = CGSizeMake([grid cellSize].width * 0.9, [grid cellSize].height * 0.9);
    for(int i = 0; i < self.cardViews.count; i++) {
        SetCardView *view = self.cardViews[i];
        CGPoint position = [grid centerOfCellAtRow:i/grid.columnCount inColumn:i%grid.columnCount];
        if (!CGPointEqualToPoint(view.center, position) || !CGSizeEqualToSize(view.bounds.size, frame.size))
        {
            [UIView animateWithDuration:0.3
                                  delay:0.3
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 view.center = position;
                                 CGRect bounds = view.bounds;
                                 bounds.size = frame.size;
                                 view.bounds = bounds;
                             }
                             completion:^(BOOL finished) {}];
        }
    }

}

-  (void)updateUI
{
    [super updateUI];
    for(SetCardView *cardView in self.cardViews){
        NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:cardIndex];
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:0
                         animations:^{
                             cardView.alpha = card.isChosen? 0.5: 1.0;
                         }
                         completion:^(BOOL finished) {
                         }];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    Grid *grid = [[Grid alloc] init];
    grid.size = self.boardView.frame.size;
    grid.cellAspectRatio = 2.0/2.8;
    grid.minimumNumberOfCells = self.cardViews.count;
    CGSize cellSize = CGSizeMake([grid cellSize].width * 0.9, [grid cellSize].height * 0.9);
    for (int i = 0; i < self.cardViews.count; ++i) {
        SetCardView *view = self.cardViews[i];
        CGPoint position = [grid centerOfCellAtRow:i/grid.columnCount inColumn:i%grid.columnCount];
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             view.center = position;
                             CGRect bounds = view.bounds;
                             bounds.size = cellSize;
                             view.bounds = bounds;
                         }
                         completion:^(BOOL finished) {}];
    }
}

@end

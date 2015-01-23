//
//  PlayGameHistoryViewController.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/23/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)setMoves:(NSArray *)moves
{
    _moves = moves;
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    self.history.text = @"";
}

@end

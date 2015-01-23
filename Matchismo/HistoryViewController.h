//
//  PlayGameHistoryViewController.h
//  Matchismo
//
//  Created by Inna Labuskaya on 1/23/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGameMove.h"

@interface HistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *history;
@property (nonatomic, strong) NSArray *moves;
- (void)updateUI;

@end

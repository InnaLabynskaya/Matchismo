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

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc]init];
}

- (void)updateButton:(UIButton*)button fromCard:(Card*)card
{
    if([card isKindOfClass:[SetCard class]])
    {
        SetCard *setCard = (SetCard*)card;
        if(setCard.isChosen)
        {
            if(setCard.isMatched)
                button.alpha = 0.5;
            else
                button.alpha = 0.75;
        }
        else
        {
            button.alpha = 1;
        }
        NSString *string = nil;
        switch (setCard.shape) {
            case SetCardShapeTriangle:
                string = @"triangle";
                break;
            case SetCardShapeCircle:
                string = @"circle";
                break;
            case SetCardShapeRectangle:
                string = @"rectangle";
                break;
        }
        [button setTitle:string forState:UIControlStateNormal];
    }
}

- (UIColor*)colorForSetColor:(SetCardColor)setColor
{
    switch (setColor) {
        case SetCardColorRed:
            return [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:1];
        case SetCardColorGreen:
            return [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:1];
        case SetCardColorBlue:
            return [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:1];
    }
}

@end

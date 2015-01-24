//
//  SetGameHistoryViewController.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/23/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "SetGameHistoryViewController.h"
#import "SetCard.h"

@interface SetGameHistoryViewController ()

@end

@implementation SetGameHistoryViewController

- (void)updateUI
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    for(CardMatchingGameMove *move in self.moves)
    {
        if (move.moveType != MoveTypeCommon)
            [string appendAttributedString:[self stringFromMove:move]];
    }
    self.history.attributedText = string;
}

-(NSAttributedString *)stringFromMove:(CardMatchingGameMove *)move
{
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    switch(move.moveType)
    {
        case MoveTypeCommon:
            [result appendAttributedString:[self stringFromCards:move.cards]];
            [result appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            break;
        case MoveTypeDontMatch:
            [result appendAttributedString:[self stringFromCards:move.cards]];
            [result appendAttributedString:
             [[NSAttributedString alloc] initWithString:
              [[NSString alloc] initWithFormat:@"is not set! %d penalty!\n", abs((int)move.score)]]];
            break;
        case MoveTypeMatch:
            [result appendAttributedString:
             [[NSAttributedString alloc] initWithString:
              [[NSString alloc] initWithFormat:@"is set! %d points!\n", (int)move.score]]];
            break;
    }
    return result;    
}

- (NSAttributedString *)stringFromCards:(NSArray *)setCards
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    for(SetCard *setCard in setCards){
        [string appendAttributedString:[self stringFromCard:setCard]];
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    }
    return string;
}

- (NSAttributedString*)stringFromCard:(SetCard*)setCard
{
    NSString *string = [@"" stringByPaddingToLength:setCard.number
                                         withString:[self stringFromShape:setCard.shape shading:setCard.shading]
                                    startingAtIndex:0];
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName: [self colorFromSetColor:setCard.color shading:setCard.shading]
                                 };
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    return attrString;
}

- (NSString*)stringFromShape:(SetCardShape)setShape shading:(SetCardShading)setShading
{
    BOOL empty = setShading == SetCardShadingNone;
    switch (setShape) {
        case SetCardShapeTriangle:
            return empty? @"△": @"▲";
        case SetCardShapeCircle:
            return empty? @"○": @"●";
        case SetCardShapeRectangle:
            return empty? @"◇": @"◆";
    }
}

- (UIColor*)colorFromSetColor:(SetCardColor)setColor shading:(SetCardShading)setShading
{
    CGFloat alpha = setShading == SetCardShadingDashed? 0.5: 1.0;
    switch (setColor) {
        case SetCardColorRed:
            return [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:alpha];
        case SetCardColorGreen:
            return [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:alpha];
        case SetCardColorBlue:
            return [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:alpha];
    }
}

@end

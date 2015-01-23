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
            return empty? @"▫︎": @"▪︎";
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

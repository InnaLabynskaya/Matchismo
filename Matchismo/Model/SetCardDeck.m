//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/21/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype) init
{
    self = [super init];
    if(self){
        for(SetCardShape shape = SetCardShapeTriangle; shape <= SetCardShapeCircle; shape++)
        {
            for(NSUInteger number = 1; number <= [SetCard maxNumber]; number++)
            {
                for(SetCardColor color = SetCardColorRed; color <= SetCardColorBlue; color++)
                {
                    for(SetCardShading shade = SetCardShadingNone; shade <= SetCardShadingDashed; shade++)
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.number = number;
                        card.color = color;
                        card.shading = shade;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}


@end

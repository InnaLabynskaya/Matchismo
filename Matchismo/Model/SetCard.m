//
//  SetCard.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/21/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

static const NSUInteger sMaxNumber = 3;

+ (NSUInteger)maxNumber
{
    return sMaxNumber;
}

- (int) match:(NSArray *) otherCards
{
    int score = 0;
    if([otherCards count] == sMaxNumber - 1) {
        NSUInteger sumNumber = self.number;
        NSUInteger sumColor = self.color;
        NSUInteger sumShading = self.shading;
        NSUInteger sumShape = self.shape;
        for(SetCard *card in otherCards) {
            sumNumber += card.number;
            sumColor += card.color;
            sumShading += card.shading;
            sumShape += card.shape;
        }
        if(sumNumber % sMaxNumber == 0 &&
           sumColor % sMaxNumber == 0 &&
           sumShading % sMaxNumber == 0 &&
           sumShape % sMaxNumber == 0)
        {
            score = 1;
        }
    }
    return score;
}

@end

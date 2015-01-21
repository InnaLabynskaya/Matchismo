//
//  SetCard.h
//  Matchismo
//
//  Created by Inna Labuskaya on 1/21/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "Card.h"

typedef enum : NSUInteger {
    SetCardColorRed,
    SetCardColorGreen,
    SetCardColorBlue
} SetCardColor;

typedef enum : NSUInteger {
    SetCardShadingNone,
    SetCardShadingSolid,
    SetCardShadingDashed
} SetCardShading;

@interface SetCard : Card

@property(nonatomic) SetCardColor color;
@property(nonatomic) SetCardShading shading;
@property(nonatomic, strong) NSString *shape;
@property(nonatomic) NSUInteger number;

+ (NSArray *)validShapes;
+ (NSUInteger)maxNumber;

@end

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
    SetCardColorPurple
} SetCardColor;

typedef enum : NSUInteger {
    SetCardShadingUnfilled,
    SetCardShadingSolid,
    SetCardShadingStriped
} SetCardShading;

typedef enum : NSUInteger {
    SetCardShapeSquiggles,
    SetCardShapeDiamond,
    SetCardShapeOval,
} SetCardShape;

@interface SetCard : Card

@property(nonatomic) SetCardColor color;
@property(nonatomic) SetCardShading shading;
@property(nonatomic) SetCardShape shape;
@property(nonatomic) NSUInteger number;

+ (NSUInteger)maxNumber;

@end

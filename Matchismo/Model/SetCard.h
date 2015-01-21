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

typedef enum : NSUInteger {
    SetCardShapeTriangle,
    SetCardShapeRectangle,
    SetCardShapeCircle,
} SetCardShape;

@interface SetCard : Card

@property(nonatomic) SetCardColor color;
@property(nonatomic) SetCardShading shading;
@property(nonatomic) SetCardShape shape;
@property(nonatomic) NSUInteger number;

+ (NSUInteger)maxNumber;

@end

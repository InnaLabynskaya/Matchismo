//
//  SetCard.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/21/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validShapes
{
    return @[@"○", @"☐", @"△"];
}

+ (NSUInteger)maxNumber
{
    return 3;
}

@end

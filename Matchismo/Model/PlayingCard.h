//
//  PlayingCard.h
//  Matchizmo
//
//  Created by InnaL on 1/5/15.
//  Copyright (c) 2015 InnaL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card
@property(strong, nonatomic) NSString *suit;
@property(nonatomic) NSUInteger rank;

+(NSArray *) validSuits;
+(NSUInteger) maxRank;

@end

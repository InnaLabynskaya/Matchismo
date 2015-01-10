//
//  CardMatchingGameMove.h
//  Matchismo
//
//  Created by Inna Labuskaya on 1/10/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MoveTypeCommon,
    MoveTypeMatch,
    MoveTypeDontMatch,
} CardMatchingGameMoveType;

@interface CardMatchingGameMove : NSObject

@property (nonatomic, readonly) CardMatchingGameMoveType moveType;
@property (nonatomic, readonly, strong) NSArray *cards;
@property (nonatomic, readonly) NSInteger score;

- (instancetype)initWithMoveType:(CardMatchingGameMoveType)moveType
                           cards:(NSArray *)cards
                           score:(NSInteger)score;

@end

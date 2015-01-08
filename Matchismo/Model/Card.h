//
//  Card.h
//  Matchizmo
//
//  Created by InnaL on 1/5/15.
//  Copyright (c) 2015 InnaL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property(strong, nonatomic) NSString *contents;

@property(nonatomic, getter = isChosen) BOOL chosen;
@property(nonatomic, getter = isMatched) BOOL matched;

- (int) match:(NSArray *) otherCards;
@end

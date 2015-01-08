//
//  Deck.h
//  Matchizmo
//
//  Created by InnaL on 1/5/15.
//  Copyright (c) 2015 InnaL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
-(void) addCard:(Card *) card atTop: (BOOL) atTop;
-(void) addCard:(Card *) card;
-(Card *) drawRandomCard;
@end

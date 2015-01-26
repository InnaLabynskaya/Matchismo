//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Inna Labuskaya on 1/25/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

@end

//
//  SetCardView.h
//  Matchismo
//
//  Created by Inna Labuskaya on 1/26/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@interface SetCardView : UIView

@property(nonatomic) SetCardColor color;
@property(nonatomic) SetCardShading shading;
@property(nonatomic) SetCardShape shape;
@property(nonatomic) NSUInteger number;

@end

//
//  SetCardView.m
//  Matchismo
//
//  Created by Inna Labuskaya on 1/26/15.
//  Copyright (c) 2015 Inna Labuskaya. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#define CORNER_FONT_STANDART_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor {return self.bounds.size.height / CORNER_FONT_STANDART_HEIGHT;}
- (CGFloat)cornerRadius {return CORNER_RADIUS * [self cornerScaleFactor];}
- (CGFloat)cornerOffSet {return [self cornerRadius] / 3.0;}

- (void)setNumber:(NSUInteger)number
{
    _number = number;
    [self setNeedsDisplay];
}

- (void)setShading:(SetCardShading)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setShape:(SetCardShape)shape
{
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setColor:(SetCardColor)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    [self drawShapeInRect:rect];
}

- (void)drawShapeInRect:(CGRect)rect
{
    [[self uiColorFromSetColor:self.color] setFill];
    [[self uiColorFromSetColor:self.color] setStroke];
    switch (self.shape) {
        case SetCardShapeDiamond:
            [self drawDiamondsInRect:rect];
            break;
        case SetCardShapeOval:
            [self drawOvalsInRect:rect];
            break;
        case SetCardShapeSquiggles:
            [self drawSquigglesInRect:rect];
            break;
            
        default:
            break;
    }
}


-(UIColor*)uiColorFromSetColor:(SetCardColor)setColor
{
    switch(setColor){
        case SetCardColorGreen:
            return [UIColor colorWithRed:0 green:0.6 blue:0.3 alpha:1.0];
        case SetCardColorRed:
            return [UIColor redColor];
        case SetCardColorPurple:
            return [UIColor purpleColor];
    }
}

- (void)drawPath:(UIBezierPath *)shape
        withShading:(SetCardShading)shading
{
    switch(shading){
        case SetCardShadingUnfilled:
            [shape stroke];
            break;
        case SetCardShadingSolid:
            [shape fill];
            break;
        case SetCardShadingStriped:
            [shape fillWithBlendMode:kCGBlendModeNormal alpha:0.5];
            break;
    }
}

#pragma mark - Initialization
- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    self.shape = SetCardShapeSquiggles;
    self.color = SetCardColorGreen;
    self.shading = SetCardShadingSolid;
    self.number = 3;
    [self setNeedsDisplay];
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)drawDiamondsInRect:(CGRect)rect
{
    UIBezierPath *shape = nil;
    if(self.number == 3){
        shape = [self makeDiamondInRect:CGRectMake(rect.size.width/4, rect.size.height/8, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
        shape = [self makeDiamondInRect:CGRectMake(rect.size.width/4, rect.size.height*0.375, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
        shape = [self makeDiamondInRect:CGRectMake(rect.size.width/4, rect.size.height*0.625, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
    }
    if(self.number == 2){
        shape = [self makeDiamondInRect:CGRectMake(rect.size.width/4, rect.size.height*0.125, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
        shape = [self makeDiamondInRect:CGRectMake(rect.size.width/4, rect.size.height*0.625, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
    }
    if(self.number == 1){
        shape = [self makeDiamondInRect:CGRectMake(rect.size.width/4, rect.size.height*0.375, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
    }
}

- (void)drawOvalsInRect:(CGRect)rect
{
    UIBezierPath *shape = nil;
    if(self.number == 3){
        shape = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.size.width/4, rect.size.height/8, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
        shape = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.size.width/4, rect.size.height*0.375, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
        shape = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.size.width/4, rect.size.height*0.625, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
    }
    if(self.number == 2){
        shape = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.size.width/4, rect.size.height*0.125, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
        shape = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.size.width/4, rect.size.height*0.625, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
    }
    if(self.number == 1){
        shape = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.size.width/4, rect.size.height*0.375, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
    }
}

- (void)drawSquigglesInRect:(CGRect)rect
{
    UIBezierPath *shape = nil;
    if(self.number == 3){
        shape = [self makeSquiggleInRect:CGRectMake(rect.size.width/4, rect.size.height/8, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
        shape = [self makeSquiggleInRect:CGRectMake(rect.size.width/4, rect.size.height*0.375, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
        shape = [self makeSquiggleInRect:CGRectMake(rect.size.width/4, rect.size.height*0.625, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
    }
    if(self.number == 2){
        shape = [self makeSquiggleInRect:CGRectMake(rect.size.width/4, rect.size.height*0.125, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
        shape = [self makeSquiggleInRect:CGRectMake(rect.size.width/4, rect.size.height*0.625, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
    }
    if(self.number == 1){
        shape = [self makeSquiggleInRect:CGRectMake(rect.size.width/4, rect.size.height*0.375, rect.size.width*0.5, rect.size.height*0.2)];
        [self drawPath:shape withShading:self.shading];
    }
}

- (UIBezierPath*)makeSquiggleInRect:(CGRect)smallRect
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(smallRect.origin.x, smallRect.origin.y + smallRect.size.height)];
    [path addCurveToPoint:CGPointMake(smallRect.origin.x + smallRect.size.width, smallRect.origin.y)
            controlPoint1:CGPointMake(smallRect.origin.x, smallRect.origin.y)
            controlPoint2:CGPointMake(smallRect.origin.x + smallRect.size.width, smallRect.origin.y + smallRect.size.height*0.5)];
    [path addCurveToPoint:CGPointMake(smallRect.origin.x, smallRect.origin.y + smallRect.size.height)
            controlPoint1:CGPointMake(smallRect.origin.x + smallRect.size.width, smallRect.origin.y + smallRect.size.height)
            controlPoint2:CGPointMake(smallRect.origin.x, smallRect.origin.y + smallRect.size.height*0.5)];
    return path;
}

- (UIBezierPath*)makeDiamondInRect:(CGRect)smallRect
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(smallRect.origin.x, smallRect.origin.y + smallRect.size.height/2)];
    [path addLineToPoint:CGPointMake(smallRect.origin.x + smallRect.size.width/2, smallRect.origin.y)];
    [path addLineToPoint:CGPointMake(smallRect.origin.x + smallRect.size.width, smallRect.origin.y + smallRect.size.height/2)];
    [path addLineToPoint:CGPointMake(smallRect.origin.x + smallRect.size.width/2, smallRect.origin.y + smallRect.size.height)];
    [path closePath];
    return path;
}


@end

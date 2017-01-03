//
//  UIImage+BackgroundColorForState.m
//  CamScanner
//
//  Created by Vercity on 14-2-10.
//  Copyright (c) 2014年 2012 Intsig Information Co., LTD. All rights reserved.
//

#import "UIImage+BackgroundColorForState.h"

@implementation UIImage (BackgroundColorForState)

+ (UIImage *) imageWithColor:(UIColor *) color inRect:(CGRect) rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *) imageWithColor:(UIColor *) color
{
    return [self imageWithColor:color inRect:CGRectMake(0, 0, 100, 100)];
}

@end

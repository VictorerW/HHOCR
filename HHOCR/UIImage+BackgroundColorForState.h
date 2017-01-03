//
//  UIImage+BackgroundColorForState.h
//  CamScanner
//
//  Created by Vercity on 14-2-10.
//  Copyright (c) 2014年 2012 Intsig Information Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BackgroundColorForState)

+ (UIImage *) imageWithColor:(UIColor *) color;
+ (UIImage *) imageWithColor:(UIColor *) color inRect:(CGRect) rect;

@end

//
//  ISBankCardResultViewController.h
//  ISBankCardDemo
//
//  Created by Felix on 15/9/1.
//  Copyright (c) 2015年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ISBankCard/ISBankCard.h>

@interface ISBankCardResultItem : NSObject

@property (nonatomic, copy) NSString * typeText;
@property (nonatomic, copy) NSString * resultText;

@end

@interface ISBankCardResultViewController : UIViewController

- (instancetype)initWithInfo:(NSDictionary*) info;

@end

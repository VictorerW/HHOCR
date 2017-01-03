//
//  ISCardReaderResultItem.h
//  ISIDReaderSDK
//
//  Created by Felix on 15/8/13.
//  Copyright (c) 2015年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kOpenSDKCardResultTypeOriginImage;//origin image(原图)
extern NSString * const kOpenSDKCardResultTypeImage;//cropped image(切边后的图)
extern NSString * const kOpenSDKCardResultTypeHeadImage;//headImage(头像)
extern NSString * const kOpenSDKCardResultTypeCardName;
extern NSString * const kOpenSDKCardResultTypeCardItemInfo;

@interface ISCardReaderResultItem : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *itemValue;

@end

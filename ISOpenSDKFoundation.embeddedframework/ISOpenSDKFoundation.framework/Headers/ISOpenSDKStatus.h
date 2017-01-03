//
//  ISSDKStatus.h
//  ISSDK
//
//  Created by Felix on 15/3/23.
//  Copyright (c) 2015年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ISOpenSDKStatus)
{
    ISOpenSDKStatusUnauthorized = -1,
    ISOpenSDKStatusSuccess,
    ISOpenSDKStatusUnreachable,
    ISOpenSDKStatusDeviceIDError,
    ISOpenSDKStatusAppIDError,
    ISOpenSDKStatusAppKeyError,
    ISOpenSDKStatusAuthExpiredError,
    ISOpenSDKStatusDeviceCappedError,
    ISOpenSDKStatusDetectCappedError,
    ISOpenSDKStatusSubAppKeyError,
    ISOpenSDKStatusUnsupportedAuthError,
    ISOpenSDKStatusAuthorizeInfoError,
    ISOpenSDKStatusConstructResourceError,
    ISOpenSDKStatusVersionError
};


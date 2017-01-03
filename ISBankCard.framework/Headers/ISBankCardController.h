//
//  ISBankCardController.h
//  ISBankCard
//
//  Created by Felix on 15/3/23.
//  Copyright (c) 2015年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ISOpenSDKFoundation/ISOpenSDKFoundation.h>
#import <CoreMedia/CoreMedia.h>

typedef NS_ENUM(NSInteger, ISBankCardType) {
    ISBankCardTypeNone = 0,
    ISBankCardTypeCreditCard, //贷记卡
    ISBankCardTypeDebitCard, //借记卡
    ISBankCardTypeQuasiCreditCard //准贷记卡
};

typedef NS_ENUM(NSInteger, ISCreditCardType) {
    ISCreditCardTypeNone = 0,
    ISCreditCardTypeVISA,         // Visa
    ISCreditCardTypeMASTER,       // MasterCard
    ISCreditCardTypeMAESTRO,      // Maestro
    ISCreditCardTypeAMEX,         // American Express
    ISCreditCardTypeDINERS,       // Diners Club
    ISCreditCardTypeDISCOVER,     // Discover
    ISCreditCardTypeJCB,          // JCB
    ISCreditCardTypeUNIONPAY      // China UNIONPAY
};

typedef void(^ConstructResourcesFinishHandler)(ISOpenSDKStatus status);
typedef void(^DetectCardFinishHandler)(int result, NSArray *borderPointsArray);
typedef void(^RecognizeCardFinishHandler)(NSDictionary *cardInfo);
typedef void(^AccessRawDataFinishHandler)(uint8_t *rawData, int rawDataWidth, int rawDataHeight);

extern NSString *const kBankCardType;
extern NSString *const kCreditCardType;
extern NSString *const kCardNumber;
extern NSString *const kExpiryDate;
extern NSString *const kHolderName;
extern NSString *const kBankName;
extern NSString *const kBankID;
extern NSString *const kCardNumberRect;
extern NSString *const kCardNumberOriginalBorderPoints;
extern NSString *const kBankNumberImage;

@interface ISBankCardController : NSObject<ISPreviewSDKProtocol>

+ (ISBankCardController *)sharedController;

/*
 Call this method to get the built in ISOpenSDKCameraViewController that defined in <ISOpenSDKFoundation.framework/ISOpenSDKCameraViewController.h>
 调用该方法获取内置的拍照界面，拍照界面详细定义请参见<ISOpenSDKFoundation.framework/ISOpenSDKCameraViewController.h>
 */
- (ISOpenSDKCameraViewController *)cameraViewControllerWithAppkey:(NSString *)appKey subAppkey:(NSString *)subAppKey;

#pragma mark --

/* 
 You should call this method to construct resources before call other APIs in the SDK,calling this API will cause an online authorization for the first time this SDK is used.Once authorized successfully, this API will be returned immediately within expire time and try to update authorization status in background
 */
- (void)constructResourcesWithAppKey:(NSString *)appKey subAppkey:(NSString *)subAppKey finishHandler:(ConstructResourcesFinishHandler)handler;

/*
 Use this method to recognize one card.
 */
- (ISOpenSDKStatus)detectCardWithOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
                                       cardRect:(CGRect)rect//rect should be a golden rect for credit cards that are shaped with its proportions
                        detectCardFinishHandler:(DetectCardFinishHandler)detectCardFinishHandler
                     recognizeCardFinishHandler:(RecognizeCardFinishHandler)recognizeFinishHandler;

/*
 Recognize one card has 3 stpes:Getting raw data, detecting the corners and recognizing.In most cases you may not concern about them.
 */
- (ISOpenSDKStatus)accessRawDataWithOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer accessRawDataFinishHandler:(AccessRawDataFinishHandler)accessRawDataFinishHandler;//Should free the rawData  yourself after use

- (ISOpenSDKStatus)detectCardWithRawData:(uint8_t *)rawData
                        rawDataWidth:(int)width
                       rawDataHeight:(int)height
                            cardRect:(CGRect)rect
             detectCardFinishHandler:(DetectCardFinishHandler)detectCardFinishHandler;

- (ISOpenSDKStatus)recognizeCardWithRawData:(uint8_t *)rawData
                           rawDataWidth:(int)width
                          rawDataHeight:(int)height
                           borderPoints:(NSArray *)borderPoints
             recognizeCardFinishHandler:(RecognizeCardFinishHandler)recognizeFinishHandler;

/*
 Use this mothod to release SDK resources
 */
- (void)destructBankCardResources;

@end

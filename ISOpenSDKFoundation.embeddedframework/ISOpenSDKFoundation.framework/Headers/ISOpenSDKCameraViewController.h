//
//  ISOpenSDKCameraViewController.h
//  ISOpenSDKFoundation
//
//  Created by Felix Liu on 15/12/22.
//  Copyright © 2015年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISOpenSDKStatus.h"

typedef NS_ENUM(NSInteger, ISOpenPreviewSDKType)
{
    ISOpenPreviewSDKTypeBankCardReader = 1 << 0,
    ISOpenPreviewSDKTypeIDReader = 1 << 1,
};

@protocol ISOpenSDKCameraViewControllerDelegate <NSObject>

@optional

- (void)constructResourcesDidFinishedWithStatusCode:(ISOpenSDKStatus)status;
- (void)accessCameraDidFailed;
- (void)cameraViewController:(UIViewController *)viewController didFinishDetectCardWithResult:(int)result borderPoints:(NSArray *)borderPoints;
- (void)cameraViewController:(UIViewController *)viewController didFinishRecognizeCard:(NSDictionary *)resultInfo cardSDKType:(ISOpenPreviewSDKType)sdkType;
- (void)cameraViewController:(UIViewController *)viewController didClickCancelButton:(id)sender;

@end

@interface ISOpenSDKCameraViewController : UIViewController

- (instancetype)initWithPreviewSDKType:(ISOpenPreviewSDKType)previewSDKType appkey:(NSString *)appKey subAppkey:(NSString *)subAppkey;

@property (nonatomic, assign) BOOL needShowBackButton;//是否显示右上角返回按钮
@property (nonatomic, assign) BOOL shouldHightlightCorners;//找边成功之后是否高亮显示
@property (nonatomic, weak) id<ISOpenSDKCameraViewControllerDelegate>delegate;

@end

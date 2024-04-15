//
//  ReactWrapperModule.m
//  tnk_rwd_rn
//
//  Created by hana go on 4/12/24.
//

#import "ReactWrapperModule.h"
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(ReactWrapperModule, NSObject)
RCT_EXTERN_METHOD(simpleMethod)
RCT_EXTERN_METHOD(showAttPopup)
RCT_EXTERN_METHOD(simpleMethodReturns:(RCTResponseSenderBlock) callback)
RCT_EXTERN_METHOD(simpleMethodWithParams:(NSString *) param callback: (RCTResponseSenderBlock)callback )
RCT_EXTERN_METHOD(resolvePromise: (RCTPromiseResolveBlock) resolve rejecter: (RCTPromiseRejectBlock) reject)
RCT_EXTERN_METHOD(rejectPromise: (RCTPromiseResolveBlock) resolve rejecter: (RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(showToast:(NSString *) message num:(NSInteger) num)
RCT_EXTERN_METHOD(setUserName:(NSString *) userName)
RCT_EXTERN_METHOD(setCoppa:(int) coppa)
RCT_EXTERN_METHOD(showOfferwallWithAtt)
RCT_EXTERN_METHOD(showOfferwall)
@end

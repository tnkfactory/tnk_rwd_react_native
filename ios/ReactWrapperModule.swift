//
//  ReactWrapperModule.swift
//  tnk_rwd_rn
//
//  Created by hana go on 4/12/24.
//

import Foundation
import TnkRwdSdk2

@objc(ReactWrapperModule) class ReactWrapperModule: RCTEventEmitter, OfferwallEventListener {
  // iOS는 함수 스텍이 끝나면 메모리를 해제하기 때문에 리스너를 static 처리
  private let _callableJSModules = RCTCallableJSModules()
  static var emitter: RCTEventEmitter?

  @objc public func simpleMethod() {
    print("tnk_rwd_test")
  }
  @objc public func simpleMethodReturns(
    _ callback: RCTResponseSenderBlock
  ) {
    callback(["ReactWrapperModule.simpleMethodReturns()"])
  }
  @objc public func simpleMethodWithParams(_ param: String,callback: RCTResponseSenderBlock) {
    TnkSession.sharedInstance()?.setUserName(param)
    TnkSession.sharedInstance()?.setCOPPA(true)

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if #available(iOS 14, *) {

                    DispatchQueue.main.async {
                      let tnkOfferwall = AdOfferwallViewController()
                      tnkOfferwall.title = "TEST Offerwall"

                      let navController = UINavigationController(rootViewController: tnkOfferwall)
                      navController.modalPresentationStyle = .fullScreen
                      navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

                      if let wd = UIApplication.shared.delegate?.window {
                        if let vc = wd?.rootViewController{
                          vc.present(navController, animated: true)
                        }
                      }
                    }
            } else {
              let tnkOfferwall = AdOfferwallViewController()
              tnkOfferwall.title = "TEST Offerwall"

              let navController = UINavigationController(rootViewController: tnkOfferwall)
              navController.modalPresentationStyle = .fullScreen
              navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

              if let wd = UIApplication.shared.delegate?.window {
                if let vc = wd?.rootViewController{
                  vc.present(navController, animated: true)
                }
              }
            }
        }

    callback(["ReactWrapperModule.simpleMethodWithParams('\(param)')"])
  }
  @objc public func throwError() throws {
//    throw createError(message: "CustomMethods.throwError()")
    throw NSError(domain: "ReactWrapperModule", code: 99, userInfo: ["Message" :"ReactWrapperModule.throwError()"])
  }
  @objc public func resolvePromise(
    _ resolve: RCTPromiseResolveBlock,
    rejecter reject: RCTPromiseRejectBlock
  ) -> Void {
    resolve("ReactWrapperModule.resolvePromise()")
  }
  @objc public func rejectPromise(
    _ resolve: RCTPromiseResolveBlock,
    rejecter reject: RCTPromiseRejectBlock
  ) -> Void {
    reject("0", "ReactWrapperModule.rejectPromise()", nil)
  }

 @objc public func showToast(message: String, num: Int) -> Bool { return true }
 @objc public func setUserName(_ userName: String) {
   TnkSession.sharedInstance()?.setUserName(userName)
 }
 @objc public func setCoppa(_ coppa: Int){
   if(coppa == 0){
     TnkSession.sharedInstance()?.setCOPPA(false)
   }else{
     TnkSession.sharedInstance()?.setCOPPA(true)
   }
 }
 @objc public func showAttPopup() {
   DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
     if let wd = UIApplication.shared.delegate?.window {
       if let vc = wd?.rootViewController{
         TnkAlerts.showATTPopup(
          vc,
          agreeAction: {// 사용자 동의함

          },
          denyAction:{ // 동의하지 않음

          })
       }
     }
   }
 }
  @objc public func showOfferwallWithAtt(){
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      if let wd = UIApplication.shared.delegate?.window {
        if let vc = wd?.rootViewController{
          TnkAlerts.showATTPopup(
           vc,
           agreeAction: {// 사용자 동의함
             self.showOfferwall()
           },
           denyAction:{ // 동의하지 않음
             self.showOfferwall()
           })
        }
      }
    }
  }
  @objc public func showOfferwall(){
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      let tnkOfferwall = AdOfferwallViewController()
      tnkOfferwall.title = "TEST Offerwall"
      tnkOfferwall.offerwallListener = self

      let navController = UINavigationController(rootViewController: tnkOfferwall)
      navController.modalPresentationStyle = .fullScreen
      navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

      if let wd = UIApplication.shared.delegate?.window {
        if let vc = wd?.rootViewController{
          vc.present(navController, animated: true)
        }
      }
    }
  }
  // tnkEventListener 구현
  func didOfferwallRemoved(){
    sendEvent(message:"tnk_event_offerwall_closed")
  }

  // eventEmitter 구현
  private static let changeEvent = "tnk_event"

  func sendEvent(message: String) {
    Self.emitter?.sendEvent(withName: Self.changeEvent, body: ["name": message]/* ex: true, 5, "foo", [1, 2, 3] */)
  }

  override func startObserving() {
    super.startObserving()
    self.callableJSModules = _callableJSModules
    self.callableJSModules.setBridge(self.bridge)
    Self.emitter = self
  }
  override func supportedEvents() -> [String]! {
    return [Self.changeEvent]
  }
}

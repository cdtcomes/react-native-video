import AVFoundation
import React

@objc(RCTVideoManager)
class RCTVideoManager: RCTViewManager {
    
    var video:RCTVideo?

   // @objc var saludo:NSString?
   
    override func view() -> UIView {
        video = RCTVideo(eventDispatcher: bridge.eventDispatcher() as! RCTEventDispatcher)
        return video!
    }
    
    func methodQueue() -> DispatchQueue {
        return bridge.uiManager.methodQueue
    }
    
    @objc(save:reactTag:resolver:rejecter:)
    func save(options: NSDictionary, reactTag: NSNumber, resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {
        bridge.uiManager.prependUIBlock({_ , viewRegistry in
            let view = viewRegistry?[reactTag]
            if !(view is RCTVideo) {
                RCTLogError("Invalid view returned from registry, expecting RCTVideo, got: %@", String(describing: view))
            } else if let view = view as? RCTVideo {
                view.save(options: options, resolve: resolve, reject: reject)
            }
        })
    }
    
    @objc(setLicenseResult:reactTag:)
    func setLicenseResult(license: NSString, reactTag: NSNumber) -> Void {
        bridge.uiManager.prependUIBlock({_ , viewRegistry in
            let view = viewRegistry?[reactTag]
            if !(view is RCTVideo) {
                RCTLogError("Invalid view returned from registry, expecting RCTVideo, got: %@", String(describing: view))
            } else if let view = view as? RCTVideo {
                view.setLicenseResult(license as String)
            }
        })
    }

    @objc(setLicenseResultError:reactTag:)
    func setLicenseResultError(error: NSString, reactTag: NSNumber) -> Void {
        bridge.uiManager.prependUIBlock({_ , viewRegistry in
            let view = viewRegistry?[reactTag]
            if !(view is RCTVideo) {
                RCTLogError("Invalid view returned from registry, expecting RCTVideo, got: %@", String(describing: view))
            } else if let view = view as? RCTVideo {
                view.setLicenseResultError(error as String)
            }
        })
    }
    
    @objc(setPictureInPictureIos:reactTag:)
    func setPictureInPictureIos(pictureInPicture: Bool,reactTag: NSNumber){
        bridge.uiManager.prependUIBlock({_ , viewRegistry in
            let view = viewRegistry?[reactTag]
            if !(view is RCTVideo) {
                RCTLogError("Invalid view returned from registry, expecting RCTVideo, got: %@", String(describing: view))
            } else if let view = view as? RCTVideo {
                view.setPitureInPictureIos(true)
            }
        })
    }
    
    @objc(play_video:reactTag:)
    func play_video(paused: Bool,reactTag: NSNumber){
        bridge.uiManager.prependUIBlock({_ , viewRegistry in
            let view = viewRegistry?[reactTag]
            if !(view is RCTVideo) {
                RCTLogError("Invalid view returned from registry, expecting RCTVideo, got: %@", String(describing: view))
            } else if let view = view as? RCTVideo {
                view.play_video()
            }
        })
    }
    
    
    override func constantsToExport() -> [AnyHashable : Any]? {
        return [
            "ScaleNone": AVLayerVideoGravity.resizeAspect,
            "ScaleToFill": AVLayerVideoGravity.resize,
            "ScaleAspectFit": AVLayerVideoGravity.resizeAspect,
            "ScaleAspectFill": AVLayerVideoGravity.resizeAspectFill
        ]
    }

    override class func requiresMainQueueSetup() -> Bool {
        return true
    }
}

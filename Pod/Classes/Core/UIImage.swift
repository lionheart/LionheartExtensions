//
//  Copyright 2016 Lionheart Software LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//

import Foundation
import Photos

public enum UIImageFormat {
    case png
    case jpeg(quality: CGFloat)
}

public enum UIImageSaveError: Error {
    case unspecified
}

public extension UIImage {
    /**
     Initialize a `UIImage` as a screenshot of the provided `UIView`.

     - parameter view: The `UIView` to take the screenshot of.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: March 9, 2016
     */
    convenience init?(view: UIView) {
        let bounds = view.bounds

        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        view.drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if let data = UIImagePNGRepresentation(image!) {
            self.init(data: data)
        }
        else {
            return nil
        }
    }

    /**
     Initialize a `UIImage` with a base64 data URL.

     - parameter view: The `UIView` to take the screenshot of.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: March 9, 2016
     */
    convenience init?(base64DataURLString: String?) {
        guard let base64DataURLString = base64DataURLString , base64DataURLString == "" else {
            return nil
        }

//        if let range = base64DataURLString.range(of: "base64,") {
//            range.upperBound
//        }
        if let range = base64DataURLString.range(of: "base64,"),
            let data = Data(base64Encoded: base64DataURLString.substring(from: base64DataURLString.characters.index(range.upperBound, offsetBy: 1)), options: NSData.Base64DecodingOptions()) {
                self.init(data: data)
        }
        else {
            return nil
        }
    }

    /**
     Return a new image with the provided color blended into it.
     
     - parameter color: The color to blend into the image.
     - returns: A `UIImage` with the color applied as a tint.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(.normal)

        // MARK: TODO !!!
        // Was: CGContextClipToMask(context, rect, CGImage)
//        context?.clip(to: rect, mask: CGImage.self)
        color.setFill()
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /**
     Return a new image with the alpha applied to the current one.
     
     - parameter alpha: A float specifying the alpha level of the generated image.
     - returns: A `UIImage` with the alpha applied.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func imageWithAlpha(_ alpha: Float) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let point = CGPoint(x: 0, y: 0)
        let area = CGRect(origin: point, size: size)
        draw(in: area, blendMode: .multiply, alpha: CGFloat(alpha))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /**
     Crop a given image to the specified `CGRect`.
     
     - parameter rect: the `CGRect` to crop the image to.
     - returns: A `UIImage` with the crop applied.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func imageByCroppingToRect(_ rect: CGRect) -> UIImage? {
        if let CIImage = ciImage {
            let image = CIImage.cropping(to: rect)
            return UIImage(ciImage: image)
        }
        else {
            return nil
        }
    }

    /**
     Return a screenshot of the current screen as a `UIImage`.
     
     - returns: The screenshot represented as a `UIImage`.
     - note:
        Original Source: [Apple Developer Documentation](https://developer.apple.com/library/ios/qa/qa1703/_index.html#//apple_ref/doc/uid/DTS40010193)
    
        Edited By: [http://stackoverflow.com/a/8017292/39155](http://stackoverflow.com/a/8017292/39155)

     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    class func screenshot() -> UIImage {
        let imageSize = UIScreen.main.bounds.size
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        for window in UIApplication.shared.windows {
            context?.saveGState()
            context?.translateBy(x: window.center.x, y: window.center.y)
            context?.concatenate(window.transform)
            context?.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x, y: -window.bounds.size.height * window.layer.anchorPoint.y)
            
            switch UIApplication.shared.statusBarOrientation {
            case .landscapeLeft:
                context?.rotate(by: CGFloat(M_PI_2))
                context?.translateBy(x: 0, y: -imageSize.width)
                break
                
            case .landscapeRight:
                context?.rotate(by: -CGFloat(M_PI_2))
                context?.translateBy(x: -imageSize.height, y: 0)
                break
                
            case .portraitUpsideDown:
                context?.rotate(by: CGFloat(M_PI))
                context?.translateBy(x: -imageSize.width, y: -imageSize.height)
                break
                
            default:
                break
            }
            
            window.drawHierarchy(in: window.bounds, afterScreenUpdates: false)
            context?.restoreGState()
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    /**
     Save the image to a file using the given parameters.
     
     ```
     image.saveToFile("image.png", format: .PNG)
     ```
     
     You can also specify a JPEG export, but you'll need to specify the quality as well.
     
     ```
     image.saveToFile("image.jpg", format: .JPEG(0.9))
     ```

     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: July 20, 2016
     */
    func saveToFile(_ path: String, format: UIImageFormat) throws {
        let data: Data?
        switch format {
        case .png:
            data = UIImagePNGRepresentation(self)

        case .jpeg(let quality):
            data = UIImageJPEGRepresentation(self, quality)
        }

        try data?.write(to: URL(fileURLWithPath: path), options: .atomicWrite)
    }

    /**
     Save the image to the user's camera roll.

     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: July 20, 2016
     */
    @available(iOS 9.0, *)
    func saveToCameraRoll(_ completion: ((Bool, NSError?) -> Void)?) throws {
        let library = PHPhotoLibrary.shared()
        library.performChanges({
            PHAssetCreationRequest.creationRequestForAsset(from: self)
        }) { (success, error) in
            if let completion = completion {
                completion(success, error as NSError?)
            }
        }
    }
}

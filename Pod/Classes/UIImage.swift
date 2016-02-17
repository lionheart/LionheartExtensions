//
//  UIImage.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/16/16.
//
//

import Foundation

public extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, .Normal)
        CGContextClipToMask(context, rect, CGImage)
        color.setFill()
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func imageWithAlpha(alpha: Float) -> UIImage {
        let alpha = CGFloat(alpha)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        let area = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        CGContextScaleCTM(context, 1, -1)
        CGContextTranslateCTM(context, 0, -area.size.height)
        CGContextSetBlendMode(context, .Multiply)
        CGContextSetAlpha(context, alpha)
        CGContextDrawImage(context, area, CGImage)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func imageByCroppingToRect(rect: CGRect) -> UIImage? {
        if let CIImage = CIImage {
            let image = CIImage.imageByCroppingToRect(rect)
            return UIImage(CIImage: image)
        }
        else {
            return nil
        }
    }

    // Source: https://developer.apple.com/library/ios/qa/qa1703/_index.html#//apple_ref/doc/uid/DTS40010193
    // Edited by: http://stackoverflow.com/a/8017292/39155
    // With further modifications
    func screenshot() -> UIImage {
        let imageSize = UIScreen.mainScreen().bounds.size
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        for window in UIApplication.sharedApplication().windows {
            CGContextSaveGState(context)
            CGContextTranslateCTM(context, window.center.x, window.center.y)
            CGContextConcatCTM(context, window.transform)
            CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y)
            
            switch UIApplication.sharedApplication().statusBarOrientation {
            case .LandscapeLeft:
                CGContextRotateCTM(context, CGFloat(M_PI_2))
                CGContextTranslateCTM(context, 0, -imageSize.width)
                break
                
            case .LandscapeRight:
                CGContextRotateCTM(context, -CGFloat(M_PI_2))
                CGContextTranslateCTM(context, -imageSize.height, 0)
                break
                
            case .PortraitUpsideDown:
                CGContextRotateCTM(context, CGFloat(M_PI))
                CGContextTranslateCTM(context, -imageSize.width, -imageSize.height)
                break
                
            default:
                break
            }
            
            window.drawViewHierarchyInRect(window.bounds, afterScreenUpdates: false)
            CGContextRestoreGState(context)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
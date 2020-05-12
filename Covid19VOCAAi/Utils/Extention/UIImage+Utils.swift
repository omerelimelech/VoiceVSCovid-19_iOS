//
//  UIImage+Utils.swift
//  
//
//  Created by Omer Elimelech on 3/29/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    public func tintImageWith(tintColor: UIColor) -> UIImage {
        return self.tintedImageWithColor(tintColor: tintColor, blendMode: .destinationIn)
    }
    
    private func tintedImageWithColor(tintColor: UIColor, blendMode: CGBlendMode) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
        
        tintColor.setFill()
        
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        UIRectFill(bounds);
        
        self.draw(in: bounds, blendMode: blendMode, alpha: 1.0)
        
        if blendMode != .destinationIn {
            self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        }
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return tintedImage!;
    }
    
}

extension UIImage {
    
    func resizeWith(percentage: CGFloat) -> UIImage? {
        
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
        
    }
    
    func resizeWith(width: CGFloat) -> UIImage? {
        
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}

extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    var pngData: Data? { return self.pngData() }
    
    func jpegData(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
}

extension UIImage {
    
    func blur(radius: CGFloat) -> UIImage? {
        let ciContext = CIContext(options: nil)
        guard let cgImage = cgImage else { return self }
        let inputImage = CIImage(cgImage: cgImage)
        guard let ciFilter = CIFilter(name: "CIGaussianBlur") else { return self }
        ciFilter.setValue(inputImage, forKey: kCIInputImageKey)
        ciFilter.setValue(radius, forKey: "inputRadius")
        guard let resultImage = ciFilter.value(forKey: kCIOutputImageKey) as? CIImage else { return self }
        guard let cgImage2 = ciContext.createCGImage(resultImage, from: inputImage.extent) else { return self }
        return UIImage(cgImage: cgImage2)
    }
    
}

extension UIImage {
    
    func scale(with size: CGSize) -> UIImage? {
        
      var scaledImageRect = CGRect.zero
      
      let aspectWidth:CGFloat = size.width / self.size.width
      let aspectHeight:CGFloat = size.height / self.size.height
      let aspectRatio:CGFloat = min(aspectWidth, aspectHeight)
      
      scaledImageRect.size.width = self.size.width * aspectRatio
      scaledImageRect.size.height = self.size.height * aspectRatio
      scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
      scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0
      
      UIGraphicsBeginImageContextWithOptions(size, false, 0)
      
      self.draw(in: scaledImageRect)
      
      let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      return scaledImage
    }
}

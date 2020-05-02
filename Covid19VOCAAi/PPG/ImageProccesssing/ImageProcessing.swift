//
//  ImageProcessing.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 28/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

typealias rgbTup = (red: Int, green: Int, blue: Int)
public typealias rgbDoubleTup = (red: Double, green: Double, blue: Double)
public class ImageProcessing {
    
    private static func decodeYUV420PSToRBGSum(data: [UInt8]?, width: Int, height: Int, type: RGB) -> rgbTup{
        guard data != nil else {return (red: 0, green: 0, blue: 0)}
        let frameSize = height * width
        
        var sum = 0
        var sumr = 0
        var sumg = 0
        var sumb = 0
        
        var yp = 0
        for j in (0...height - 1){
            var uvp = frameSize + (j >> 1) * width
            var u = 0
            var v = 0
            
            for i in (0...width - 1) {
                yp += 1
                var y = Int(0xff & (data?[yp])!) - 16
                if y < 0 { y = 0 }
                if ((i & 1) == 0) {
                    v = Int((0xff & (data?[uvp + 1])!)) - 128
                    uvp += 1
                    u = Int((0xff & (data?[uvp + 1])!)) - 128
                    uvp += 1
                }
                
                let y1192 = 1192 * y
                var r = (y1192 + 1634 * v)
                var g = (y1192 - 833 * v - 400 * u)
                var b = (y1192 + 2066 * u)
                if r < 0 { r = 0 } else if r > 262143 { r = 262143 }
                if g < 0 { g = 0 } else if g > 262143 { g = 262143 }
                if b < 0 { b = 0 } else if b > 262143 { b = 262143 }
                
                let pixel = 0xff000000 | ((r << 6) & 0xff0000)
                let pix = pixel | ((g >> 2) & 0xff00)
                let p = pix  | ((b >> 10) & 0xff)
                let red = (p >> 16) & 0xff
                let green = (p >> 8) & 0xff
                let blue = p & 0xff
                
                sumr += red
                sumg += green
                sumb += blue
            }
        }
        return (red: sumr, green: sumg, blue: sumb)
    }
    
    
    public static func decodeYUV420PtoRGB(data: [UInt8]?, height: Int, width: Int, type: RGB) -> rgbDoubleTup{
        guard data != nil else {return (red: 0 , green: 0 , blue: 0)}
        let frameSize = width * height
        
        let sum = decodeYUV420PSToRBGSum(data: data, width: width, height: height, type: type)


        return (red: (Double(sum.red) / Double(frameSize)) , green: (Double(sum.green) / Double(frameSize)) , blue: (Double(sum.blue) / Double(frameSize)))
    }
    
}

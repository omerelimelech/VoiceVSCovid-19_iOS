//
//  FFT.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 28/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation



public class Fft {
    public static func FFT(in: [Double], size: Int, samplingFrequency: Double) -> Double{
        var temp: Double = 0
        var POMP: Double = 0
        var frequency: Double!
        var output: Array<Double> = Array(repeating: 0, count: 2*size)
        
        for i in (0...output.count - 1) {
            output[i] = 0
        }
        
        for x in 0...(size*2) - 1{
            output[x] = abs(output[x])
        }
        
        
        for p in (35...size - 1) {
            if temp < output[p] {
                temp = output[p]
            }
            POMP = Double(p)
        }
        if POMP < 35 {
            POMP = 0
        }
        
        frequency = POMP*samplingFrequency/(2*Double(size))
        return frequency
    }
}


public class Fft2 {
    public static func FFT(in: [Double], size: Int, samplingFrequency: Double) -> Double{
        var temp: Double = 0
        var POMP: Double = 0
        var frequency: Double!
        var output = [Double]()
        
        for i in (0...output.count) {
            output[i] = 0
        }
        
        for x in 0...size*2{
            output[x] = abs(output[x])
        }
        
        
        for p in (12...size - 1) {
            if temp < output[p] {
                temp = output[p]
            }
            POMP = Double(p)
        }
        if POMP < 35 {
            POMP = 0
        }
        
        frequency = POMP*samplingFrequency/(2*Double(size))
        return frequency
    }
}


//
//  OxymeterImpl.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 28/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit

public enum RGB {
    case red
    case green
    case blue
}

class OxymeterData {

    var heartRate: Int
    var red: [Double]
    var blue: [Double]
    var green: [Double]
    var timePoint: [Int]
    
    internal init(heartRate: Int, red: [Double], blue: [Double], green: [Double], timePoint: [Int]) {
           self.heartRate = heartRate
           self.red = red
           self.blue = blue
           self.green = green
           self.timePoint = timePoint
       }
   
}

public class OxymeterImpl: Oxymeter {

    private let TAG = "Oxymeter"
    
    private var samplingFreq: Int!
    
    private let WINDOW_TIME = 10
    private let FAILED_WINDOWS_MAX = 5
    
    private var failedWindows = 0
    private let SMA_SIZE = 10
    
    var redRollingAvg: SMA? = nil

    var peakBpmWindow: Array<Double> = Array(repeating: 0, count: 24)
    
    var redAvgArr: [Double] = [Double]()
    var greenAvgArr: [Double] = [Double]()
    var blueAvgArr: [Double] = [Double]()
    var timePoints = [Int]()
    
    var onInvalidData: (() -> Void)?
    var onUpdateView: ((_ heartRate: Int) -> Void)?
    var updateGraphView: ((_ frame: Int, _ point: Double) -> Void)?
    var onFingerRemove: (() -> Void)?
    
    private var frameCounter = 0
    //here callback functions will be called
    
    init(samplingFreq: Double) {
        self.samplingFreq = Int(samplingFreq)
    }
    func updateWithFrame(data: [UInt8]?, width: size_t, height: size_t, timePoint: Int) {
        let height = height
        let width = width
        
        
        let colorsAvg = self.getColorIntensities(data: data, height: Int(height), width: width, type: .red)
        if colorsAvg.red < 200, let fingerRemoveCallback = self.onFingerRemove {
            fingerRemoveCallback()
            return
        }
        self.timePoints.append(timePoint)
        self.redAvgArr.append(colorsAvg.red)
        self.greenAvgArr.append(colorsAvg.green)
        self.blueAvgArr.append(colorsAvg.blue)
        
        frameCounter += 1
        print (frameCounter)
        // we have at least 1 window and its a perfect window size
        if (frameCounter >= samplingFreq * WINDOW_TIME) && (frameCounter % samplingFreq == 0) {
            let windowIndex = (frameCounter / samplingFreq) - WINDOW_TIME
            
            let fromIndex = windowIndex * samplingFreq
            let toIndex = (windowIndex + WINDOW_TIME) * samplingFreq
            let relevantRed = Array(redAvgArr[fromIndex...toIndex - 1])
            let relevantBlue = Array(blueAvgArr[fromIndex...toIndex - 1])
            let results = calculateWindowSampleBPMAndO2(redArr: relevantRed, blueArr: relevantBlue, samplingFreq: Double(samplingFreq))
            
            peakBpmWindow[windowIndex] = results[0]
            
            failedWindows += Int(results[1])
            if failedWindows > FAILED_WINDOWS_MAX {
                //invalidateData()
                return
            }
            if let updateView = onUpdateView{
                updateView(Int(results[0]))
            }
            //print ("heart rate: \(results[0])")
        }
        if let update = updateGraphView{
            update(frameCounter, colorsAvg.red)
        }
    }
    
    func getFinalData() -> (red: [Double],blue: [Double], green: [Double], timePoint: [Int]) {
        return (red: redAvgArr, blue: blueAvgArr, green: greenAvgArr, timePoint: [Int]())
    }
    
    
    private func getColorIntensities(data: [UInt8]?, height: Int, width: Int, type: RGB) -> rgbDoubleTup{
        return ImageProcessing.decodeYUV420PtoRGB(data: data, height: height, width: width, type: type)
    }
    
    
    public func calculateSPO2(red: [Double], blue: [Double]) -> Double{
        var stdr: Double = 0
        var stdb: Double = 0
        let meanr = sumDouble(list: red) / Double(red.count)
        let meanb = sumDouble(list: blue) / Double(blue.count)
        
        for i in (0...red.count - 1) {
            let bufferb = blue[i]
            stdb = stdb + ((bufferb - meanb) * (bufferb - meanb))
            let bufferr = red[i]
            stdr = stdr + ((bufferr - meanr) * (bufferr - meanr))
        }
        let varr = sqrt(stdr / (Double(red.count) - 1))
        let varb = sqrt(stdb / (Double(blue.count) - 1))
        
        let R = (varr / meanr) / (varb / meanb)
        let spo2 = 100 - 5 * (R)
        
        return spo2
    }
    
    public func calculateMovingRedInWindowAverage(arr: [Double]) -> [Double] {
        var movAvgRed = [Double]()
        if redRollingAvg == nil {
            self.redRollingAvg = SMA(length: SMA_SIZE)
            let avg = sumDouble(list: arr) / Double(arr.count)
            
            for i in (0...arr.count - 1) {
                if i < SMA_SIZE {
                    let _ = redRollingAvg?.compute(value: avg)
                    movAvgRed.append(avg) // take a look if something is going wrong
                }else{
                    movAvgRed.append((redRollingAvg?.compute(value: arr[i]))!)
                }
            }
        }else{
            for i in (0...arr.count - 1){
                movAvgRed.append((redRollingAvg?.compute(value: arr[i]))!)
            }
        }
        
        
        
        return movAvgRed
    }
    
    private func findIntervalsAndCalculateBPM(peakPositionList: [Int], samplingFerq: Double) -> Double {
        //Calculating the intervals or distance between the peaks, between then storing the result in milliseconds into RR_List ArrayList

        var RR_list = [Double]()
        
        for i in (0...peakPositionList.count - 1) {
            if i < peakPositionList.count - 1{
            let RRInterval = peakPositionList[i + 1] - peakPositionList[i]
            let msDist: Double = ((Double(RRInterval) / samplingFerq) * 1000)
            RR_list.append(msDist)
            }
        }
        
        let avgRR = sumDouble(list: RR_list) / Double(RR_list.count)
        return 60000 / avgRR
        
    }
    
    private func calculateWindowSampleBPMAndO2(redArr: [Double], blueArr: [Double], samplingFreq: Double) -> [Double] {
        let redMoveAverage = calculateMovingRedInWindowAverage(arr: redArr)
        let peakList = createWindowToFindPeaks(movAvgRed: redMoveAverage, list: redArr)
        let peakBPM = findIntervalsAndCalculateBPM(peakPositionList: peakList, samplingFerq: samplingFreq)
        
        let peakBpmi = Int(peakBPM)
        if (!(peakBpmi < 45 || peakBpmi > 200)) { // if any of the measurements is bad, the windows is bad sample
            return [peakBPM, 0]
        }
        
        redRollingAvg = nil
        return [0,1]
    }
    
    
    private func createWindowToFindPeaks(movAvgRed: [Double], list: [Double]) -> [Int] {
        var peakPositionList = [Int]()
        var window = [Double]()
        
        var windowIndex: Double = 0
        
        for i in (0...list.count - 1) {
            if movAvgRed[i] > list[i] && window.isEmpty {
                continue
            }else if list[i] > movAvgRed[i] {
                window.append(windowIndex)
                windowIndex += 1
            }else {
                if window.isEmpty { continue }
                let max = window.max()
                let bearPotision = i - window.count + Int(window.first(where: {$0 == max})!)
                peakPositionList.append(bearPotision)
                window.removeAll()
                windowIndex = 0
            }
        }
        
        return peakPositionList
    }
    
    
    public func calculateAverageFourierBreathAndBPM(redList: [Double], greenList: [Double], samplingFreq: Double) -> Double{
        var bufferAvgB : Double = 0
        let hrFreq = Fft.FFT(in: greenList, size: greenList.count, samplingFrequency: samplingFreq)
        let bpmGreen = Int(ceil(hrFreq * 60))
        let hr1Freq = Fft.FFT(in: redList, size: redList.count, samplingFrequency: samplingFreq)
        let bpmRed = Int(ceil(hr1Freq))
        
        if (bpmGreen > 40 && bpmGreen < 200) {
            if (bpmRed > 40 && bpmRed < 200) {
                bufferAvgB = Double(bpmGreen + bpmRed) / 2
            } else {
                bufferAvgB = Double(bpmGreen)
            }
        } else if (bpmRed > 45 && bpmRed < 200) {
            bufferAvgB = Double(bpmRed)
        }
        return bufferAvgB
    }
    
    func finish(samplingFreq: Double) -> OxymeterData?{
        if failedWindows > FAILED_WINDOWS_MAX {
            return nil
        }
        let peakBpm = Int(sumDouble(list: peakBpmWindow) / Double((peakBpmWindow.count - failedWindows)))
        let beats = calculateAverageFourierBreathAndBPM(redList: redAvgArr, greenList: greenAvgArr, samplingFreq: samplingFreq)
        
        var heartRate: Int?
        if (!(peakBpm < 45 || peakBpm > 200) && !(beats < 45 || beats > 200) ) {
            let BpmAvg = Int(ceil(Double((Int(beats) + peakBpm) / 2)))
            heartRate = BpmAvg
        } else if ((beats < 45 || beats > 200) && !(peakBpm < 45 || peakBpm > 200)) {
            heartRate = peakBpm
        } else if (!(beats < 45 || beats > 200) && (peakBpm < 45 || peakBpm > 200)) {
            heartRate = Int(beats)
        } else {
            return nil;
        }
        guard heartRate != nil else { return nil}
        return OxymeterData(heartRate: heartRate!, red: redAvgArr, blue: blueAvgArr, green: greenAvgArr, timePoint: timePoints)
    }
    
    func setOnInvalidData(_ completion: @escaping () -> Void) {
        onInvalidData = completion
    }
    
    func setUpdateView(_ completion: @escaping (Int) -> Void) {
        onUpdateView = completion
    }
    
    func setUpdateGraphView(completion: @escaping (Int, Double) -> Void) {
        updateGraphView = completion
    }
    
    
    
    private func sumDouble(list: [Double]) -> Double{
        var sum: Double = 0;
        for i in list{
            sum += i
        }
        return sum;
    }
    
}


//struct Queue{
//
//    var items:[String] = []
//
//    mutating func enqueue(element: String)
//    {
//        items.append(element)
//    }
//
//    mutating func dequeue() -> String?
//    {
//
//        if items.isEmpty {
//            return nil
//        }
//        else{
//            let tempElement = items.first
//            items.remove(at: 0)
//            return tempElement
//        }
//    }
//
//}
//
public class LL<T> {
    var data: T
    var next: LL?
    public init(data: T){
        self.data = data
    }
}

public class Queue<T> {
    typealias LLNode = LL<T>
    var head: LLNode!
    public var isEmpty: Bool { return head == nil }
    var first: LLNode? { return head }
    var last: LLNode? {
        if var node = self.head {
            while case let next? = node.next {
                node = next
            }
            return node
        } else {
            return nil
        }
    }

    func enqueue(key: T) {
        let nextItem = LLNode(data: key)
        if let lastNode = last {
            lastNode.next = nextItem
        } else {
            head = nextItem
        }
    }
    func dequeue() -> T? {
        if self.head?.data == nil { return nil  }
        if let nextItem = self.head?.next {
            head = nextItem
        } else {
            head = nil
        }
        return head?.data
    }
}

public struct Deque<T> {
    private var items = [T]()
    
    mutating func enqueue(element: T) {
        items.append(element)
    }
    
    mutating func enqueueFront(element: T) {
        items.insert(element, at: 0)
    }
    
    mutating func dequeue() -> T?{
        if items.isEmpty {
            return nil
        } else {
            return items.removeFirst()
        }
    }
    
    mutating func dequeueBack() -> T? {
        if items.isEmpty {
            return nil
        } else {
            return items.removeLast()
        }
    }
}

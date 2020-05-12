////
////  OxymeterViewController.swift
////  Covid19VOCAAi
////
////  Created by Omer Elimelech on 28/04/2020.
////  Copyright © 2020 Omer Elimelech. All rights reserved.
////
//

import UIKit
import AVFoundation
import Accelerate
import SRCountdownTimer


class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureDataOutputSynchronizerDelegate, AVCaptureDepthDataOutputDelegate {

    @IBOutlet weak var finalHeartRateLabel: UILabel!
    
    
    @IBOutlet weak var testIdLabel: UILabel!
    
    
    var captureSession: AVCaptureSession?
    var dataOutput: AVCaptureVideoDataOutput?
    var customPreviewLayer: AVCaptureVideoPreviewLayer?
//var customPreviewLayer: AVCaptureVideoPreviewLayer?

    @IBOutlet weak var cameraView: UIView!
    
    var measurmentId: Int!
    @IBOutlet weak var heartRateLabel: UILabel!
    var oxymeter: OxymeterImpl = OxymeterImpl(samplingFreq: 15)
    private let sessionQueue = DispatchQueue(label: "session queue", attributes: [], autoreleaseFrequency: .workItem)
    
    var fingerOnCamera: Bool?{
        willSet {
            if newValue == true && fingerOnCamera == nil{
                countDownTimer.start(beginingValue: 500 / 15, interval: 1)
            }else{
                guard let new = newValue else {return}
                new ? countDownTimer.resume() : countDownTimer.pause()
            }
        }
    }
    
    
    var presenter: OxymeterPresetner?
  
    @IBOutlet weak var countDownTimer: SRCountdownTimer!
    
override func viewDidLoad() {
    super.viewDidLoad()
 
    self.presenter = OxymeterPresetner(delegate: self)
    setupCameraSession()
    
    self.captureSession?.startRunning()
    
    heartRateLabel.text = "calculating...."
    oxymeter.onUpdateView = { (hearRate) in
        DispatchQueue.main.async {
            self.heartRateLabel.text = "heart rate: \(hearRate)"
        }
    }
    
    oxymeter.onFingerRemove = {
        if self.fingerOnCamera != nil {
            self.fingerOnCamera = false
        }
    }
    
    oxymeter.updateGraphView = { (frameCounter, redAvg) in
        DispatchQueue.main.async {
            // do stuff...
        }
    }
}
  
    let inputDevice: AVCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)!
func setupCameraSession() {
    // Session
    
    self.captureSession = AVCaptureSession()
    self.captureSession!.sessionPreset = AVCaptureSession.Preset.low
    // Capture device
    
    var deviceInput: AVCaptureDeviceInput!
    
    inputDevice.set(frameRate: 600)
    
    // Device input
    //var deviceInput: AVCaptureDeviceInput? = AVCaptureDeviceInput.deviceInputWithDevice(inputDevice, error: error)
    do {
        deviceInput = try AVCaptureDeviceInput(device: inputDevice)
        

    } catch let error as NSError {
        // Handle errors
        print(error)
    }
    if self.captureSession!.canAddInput(deviceInput) {
        self.captureSession!.addInput(deviceInput)
    }
    // Preview
    customPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
    customPreviewLayer!.frame = cameraView.bounds
    customPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
    customPreviewLayer?.connection!.videoOrientation = AVCaptureVideoOrientation.portrait
    self.cameraView.layer.addSublayer(customPreviewLayer!)
    print("Cam layer added")

    self.dataOutput = AVCaptureVideoDataOutput()
    dataOutput!.connection(with: .video)?.isEnabled = true
    
    self.dataOutput!.videoSettings = [
        String(kCVPixelBufferPixelFormatTypeKey) : Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange),
    ]

    self.dataOutput!.alwaysDiscardsLateVideoFrames = true
    
    if self.captureSession!.canAddOutput(dataOutput!) {
        self.captureSession!.addOutput(dataOutput!)
    }
    
    let depthDataOutput = AVCaptureDepthDataOutput()
    let connection = depthDataOutput.connection(with: .depthData)
    connection?.isEnabled = true
    captureSession?.addOutput(depthDataOutput)
    
   

    depthDataOutput.setDelegate(self, callbackQueue: sessionQueue)
    
    let data = AVCameraCalibrationData.self
    print(data)
    
    
    self.captureSession!.commitConfiguration()
    let queue: DispatchQueue = DispatchQueue(label: "VideoQueue")
    //let delegate = VideoDelegate()
    self.dataOutput!.setSampleBufferDelegate(self, queue: queue)
    
    
    captureSession?.startRunning()
    
 
    
    didTouchFlashButton()
    
    
}
    
    

    func didTouchFlashButton() {
        

        // check if the device has torch
        if inputDevice.hasTorch {
            do {
               try inputDevice.lockForConfiguration()
            } catch {
                print("ERROR LOCKING DEVICE")
            }
            if inputDevice.isTorchActive {
                inputDevice.torchMode = .off
            } else {
                do {
                    try inputDevice.setTorchModeOn(level: 1.0)
                } catch {
                    print("FLASH ERROR")
                }
            }
            inputDevice.unlockForConfiguration()
        }
    }
    
    
    @IBAction func goBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    var timer: Timer!

    let framesToSend = 500
    var framesSent = 0
    
    func dataOutputSynchronizer(_ synchronizer: AVCaptureDataOutputSynchronizer, didOutput synchronizedDataCollection: AVCaptureSynchronizedDataCollection) {
        print (synchronizedDataCollection)
    }
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let imageBuffer: CVImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let width: size_t = CVPixelBufferGetWidthOfPlane(imageBuffer, 0)
        let height: size_t = CVPixelBufferGetHeightOfPlane(imageBuffer, 0)
        let data = bufferToUInt(sampleBuffer: sampleBuffer)
        let timePoint = Int(CMSampleBufferGetPresentationTimeStamp(sampleBuffer).value)
        if (!(fingerOnCamera ?? false)) {
            let red = ImageProcessing.decodeYUV420PtoRGB(data: data, height: height, width: width, type: .red).red
            if red > 200 {
                fingerOnCamera = true
            }
        }else{
            let concurrentQueue = DispatchQueue(label: "swiftlee.concurrent.queue", attributes: .concurrent)
            if framesSent < framesToSend{
                concurrentQueue.async {
                    self.oxymeter.updateWithFrame(data: data, width: width, height: height, timePoint: timePoint)
                    self.framesSent += 1
                }
            }else{
                captureSession?.stopRunning()
                let data = self.oxymeter.finish(samplingFreq: 15)
                DispatchQueue.main.async {
                       self.finalHeartRateLabel.text = "FINAL HEART RATE: \(data?.heartRate ?? 0)"
                    guard let d = data, let measureId = self.measurmentId else {
                                     self.testIdLabel.text = "ERROR GETTING DATA. TRY AGAIN"
                                     return
                                 }
                    self.presenter?.sendPPGData(red: d.red, blue: d.blue, green: d.green, timePoint: d.timePoint, measureId: measureId)
                }
            }
        }
        CVPixelBufferUnlockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
    }
    

    private func bufferToUInt(sampleBuffer: CMSampleBuffer) -> [UInt8] {
        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!

        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let byterPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        let srcBuff = CVPixelBufferGetBaseAddress(imageBuffer)
        
        let data = NSData(bytes: srcBuff, length: byterPerRow * height)
        CVPixelBufferUnlockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        return [UInt8](data as Data)
    }

}

extension AVCaptureDevice {
    func set(frameRate: Double) {
    guard let range = activeFormat.videoSupportedFrameRateRanges.first,
        range.minFrameRate...range.maxFrameRate ~= frameRate
        else {
            print("Requested FPS is not supported by the device's activeFormat !")
            return
    }

    do { try lockForConfiguration()
        activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: Int32(frameRate))
        activeVideoMaxFrameDuration = CMTimeMake(value: 1, timescale: Int32(frameRate))
        unlockForConfiguration()
    } catch {
        print("LockForConfiguration failed with error: \(error.localizedDescription)")
    }
  }
}


extension ViewController: OxymeterDelegate {
    func didReceiveMeasureId(id: Int){
        self.testIdLabel.text = "MEASURMENT ID: \(id)"
    }
}

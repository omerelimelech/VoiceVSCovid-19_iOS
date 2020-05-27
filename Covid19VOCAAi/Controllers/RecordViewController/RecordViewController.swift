//
//  RecordViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 05/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit
import AVFoundation
import SVProgressHUD
import PKHUD
import SoundWave
import Firebase


class RecordViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var buttonContainerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var buttonContainerWidth: NSLayoutConstraint!
    
    @IBOutlet weak var recordLineView: UIView!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var soundStackView: UIStackView!
    
    @IBOutlet weak var audioVisualization: AudioVisualizationView!
    
    var recording = false
    
    var recordNumber: Int = 1
    var instructions: RecordInstructions?
    
    var presenter: RecordPresenter?
    
    var timer: Timer!
    
    @IBOutlet weak var buttonContainer: GradientView!
    
    @IBOutlet weak var buttonSeperator: UIView!
    
    var recordButtonOriginalCenter: CGPoint!
    
    @IBOutlet weak var visualizeLeading: NSLayoutConstraint!
    
    @IBOutlet weak var visualizeTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var recordInstructionLabel: UILabel!
    
    @IBOutlet weak var preInstructionLabel: UILabel!
    @IBOutlet weak var recordContainer: UIView!
    
    
    @IBOutlet weak var continueButton: GradientButton!
    
    @IBOutlet weak var continueFlowInstructionLabel: UILabel!
    
    
    static func initialization(instructions: RecordInstructions, recordNumber: Int) -> RecordViewController?{
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecordViewController") as? RecordViewController else {return nil}
        vc.recordNumber = recordNumber
        vc.instructions = instructions
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.logEvent("record_view",parameters: nil)
        self.presenter = RecordPresenter(with: self)
        recordingSession = AVAudioSession.sharedInstance()
        try? recordingSession.setCategory(.playAndRecord)
        if let instructions = self.instructions {
                  self.setup(with: instructions)
              }else{
                  self.instructions = RecordInstructions(stage: .aaa)
                  self.setup(with: self.instructions!)
        }
        
        self.presenter?.setupMicrophon(session: recordingSession)
        buttonContainer.autoresizesSubviews = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.recordButtonOriginalCenter = self.buttonContainer.center
        
    }
    

    func setup(with instructions: RecordInstructions){
        let instruction = self.instructions?.instruction
        self.instructionLabel.text = instruction?.title.localized()
        self.descriptionLabel.text = instruction?.description.localized()
    }
    
    
    @IBAction func recordTapped(_ sender: UIButton) {
        if !recording{
            resetPlayer()
            self.presenter?.setupMicrophon(session: self.recordingSession)
            indicateIsRecording {
                self.startRecording()
            }
        }else{
            finishRecording(success: true)
        }
        recording = !recording
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        indicateIsStoppedRecord()
        self.audioVisualization.audioVisualizationMode = .read
        self.audioVisualization.meteringLevels = meterArr
        Analytics.logEvent("finished_record",parameters: [
        "record_number": recordNumber as NSObject])
        //HUD.show(.progress)
        
        //presenter?.sendRecord(with: instructions?.instruction.recordName ?? "")
    }
    
    var meterArr = [Float]()
    @objc func refreshAudioView(_:Timer) {
        if self.audioRecorder == nil {
            self.endTimer()

            return
        }
        audioRecorder.updateMeters()
        let peak = self.audioRecorder.peakPower(forChannel: 0)
        let floatPeak = 1 - Float(abs(peak) / 50)
        print (floatPeak)
        meterArr.append(floatPeak)
        self.audioVisualization.add(meteringLevel: floatPeak)
        
    }
    
    func endTimer(){
        self.timer.invalidate()
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        preparePlayer()
    }
    
    
    var player: AVAudioPlayer?
    func preparePlayer() {
        let url = getDocumentsDirectory().appendingPathComponent("\(instructions?.instruction.recordName ?? "").wav")

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            let audioTime = player.duration
            self.audioVisualization.play(for: audioTime)
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func resetPlayer(){
        self.player?.stop()
        self.player = nil
        
    }
    
    @IBAction func continueButtonTapped(_ sender: GradientButton) {
        if let nextStage = instructions?.nextStage {
            let instructions = RecordInstructions(stage: nextStage)
            navigate(.voiceRecording(instruction: instructions, number: recordNumber + 1))
        }else{
            Analytics.logEvent("record_flow_done",parameters: [
                   "number_of_records": recordNumber as NSObject])
            navigate(.finishRecordScreen)
        }
    }
    
    
}

extension RecordViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
 

extension RecordViewController: RecordDelegate{
    
    func recordPresenter(_ presenter: RecordPresenter, didPostRecordWith bucket: S3Model) {
        HUD.hide()
        recordButton.setImage(UIImage(named: "rec"), for: .normal)
        let record = getDocumentsDirectory().appendingPathComponent("\(instructions?.instruction.recordName ?? "").wav")
        guard let nextVC = ThankYouForRecordViewController.initialization(instruction: self.instructions!, recordNumber: self.recordNumber, prevRecordURL: record, bucket: bucket) else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func recordPresenter(_ presenter: RecordPresenter, didFailPostRecordWith error: Error) {
        HUD.hide()
        recordButton.setImage(UIImage(named: "rec"), for: .normal)
    }
    
    
}


extension RecordViewController {
    
    
    func startRecording() {
        audioVisualization.audioVisualizationMode = .write
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(instructions?.instruction.recordName ?? "").wav")
        guard let settings = self.presenter?.getRecorderSettings() else {return}
        audioRecorder = try? AVAudioRecorder(url: audioFilename, settings: settings)
        self.presenter?.startRecording(recorder: self.audioRecorder)
               self.timer = Timer.scheduledTimer(timeInterval: 0.0295, target: self, selector: #selector(refreshAudioView(_:)), userInfo: nil, repeats: true)
       }
    
}

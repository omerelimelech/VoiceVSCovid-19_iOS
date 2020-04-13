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

class RecordViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var recording = false
    
    var recordNumber: Int = 1
    var instructions: RecordInstructions?
    
    var presenter: RecordPresenter?
    
    static func initialization(instructions: RecordInstructions, recordNumber: Int) -> RecordViewController?{
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecordViewController") as? RecordViewController else {return nil}
        vc.recordNumber = recordNumber
        vc.instructions = instructions
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = RecordPresenter(with: self)
       recordingSession = AVAudioSession.sharedInstance()
        if let instructions = self.instructions {
                  self.setup(with: instructions)
              }else{
                  self.instructions = RecordInstructions(stage: .cough)
                  self.setup(with: self.instructions!)
              }
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print ("Allowed")
                    } else {
                        print ("now allowed")
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
    

    func setup(with instructions: RecordInstructions){
        let instruction = self.instructions?.instruction
        self.instructionLabel.text = instruction?.title.localized()
        self.descriptionLabel.text = instruction?.description.localized()
    }
    @IBAction func recordTapped(_ sender: UIButton) {
        if !recording{
            startRecording()
        }else{
            finishRecording(success: true)
        }
        recording = !recording
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(instructions?.instruction.recordName ?? "").wav")

            
             let settings = [
                   AVFormatIDKey: kAudioFormatLinearPCM,
                   AVSampleRateKey: 12000,
                   AVNumberOfChannelsKey: 1,
                   AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ] as [String : Any]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()

            recordButton.setImage(UIImage(named: "stop"), for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        presenter?.sendRecord(with: instructions?.instruction.recordName ?? "")
        HUD.show(.progress)
        recordButton.setTitle("Tap to Re-record", for: .normal)
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

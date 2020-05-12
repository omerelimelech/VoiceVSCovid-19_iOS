//
//  ThankYouForRecordViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 05/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit
import PKHUD
import AVFoundation
class ThankYouForRecordViewController: UIViewController {

    var nextRecordVC: RecordViewController?
    var recordNumber: Int?
    var prevRecordURL: URL?
    var instructions: RecordInstructions?
    
    var player: AVAudioPlayer?
    @IBOutlet weak var nextButton: UIButton!
    var bucket: S3Model?
    var presenter: ThankYouForRecordPresenter?
    @IBOutlet weak var recordingsLeftDescription: UILabel!
    static func initialization(instruction: RecordInstructions, recordNumber: Int, prevRecordURL: URL, bucket: S3Model) -> ThankYouForRecordViewController? {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThankYouForRecordViewController") as? ThankYouForRecordViewController else {return nil}
        vc.recordNumber = recordNumber
        vc.prevRecordURL = prevRecordURL
        vc.instructions = instruction
        vc.bucket = bucket
        vc.presenter = ThankYouForRecordPresenter(with: vc)
        return vc
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let recordNumber = recordNumber else {return}
        self.recordingsLeftDescription.text = String(format: "You have completed %d out of 6 tasks thus far!".localized(), recordNumber)
        if instructions?.nextStage == nil{
            nextButton.setTitle("End Session".localized(), for: .normal)
        }
        
    }
    

    @IBAction func playPrevTapped(_ sender: UIButton) {
            guard let url = self.prevRecordURL else {return}

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
        
    
    @IBAction func redoRecordTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextRecordTapped(_ sender: UIButton) {
        guard let record = prevRecordURL, let bucket = self.bucket, let name = self.instructions?.instruction.recordName else {return}
        self.presenter?.updateRecord(bucket: bucket, fileUrl: record, name: name)
        HUD.show(.progress)

    }
    

}
extension ThankYouForRecordViewController : ThankYouForRecordDelegate {
    func thankYouForRecordPreseneter(_ presenter: ThankYouForRecordPresenter, didFailUploadRecordWith error: Error) {
        //error handle
        HUD.show(.error)
        HUD.hide()
    }
    
    func thankYouForRecordPreseneterDidUploadRecord(_ presenter: ThankYouForRecordPresenter) {
        HUD.hide()
        guard let recordNumber = recordNumber,
            let nextStage = instructions?.nextStage,
            let nextVC = RecordViewController.initialization(instructions: RecordInstructions(stage: nextStage), recordNumber: recordNumber + 1)
            else { self.navigationController?.dismiss(animated: true, completion: nil); return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}

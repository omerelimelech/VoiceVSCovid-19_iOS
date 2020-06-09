//
//  RecordModel.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 07/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import AVFoundation


class RecordModel : NSObject {
    
    
    let recorderSettings = [
    AVFormatIDKey: kAudioFormatLinearPCM,
    AVSampleRateKey: 12000,
    AVNumberOfChannelsKey: 1,
    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
       ] as [String : Any]
    
    func sendRecord(recordName: String, completion: @escaping completion){
        APIManager.shared.submitRecord(submitId: GlobalData.shared.currentSubmissionId ?? "", recordName: recordName, completion: completion)
    }
    
    func postRecord(recordName: String) {
        
    }
}

struct VoiceRecordingDTO: Codable {
    var id: Int
    var recordingFile: String
    var recordingMetadata: String
    var measurement: Int
}

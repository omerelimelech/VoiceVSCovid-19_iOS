//
//  RecordInstructions.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 05/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation



struct RecordInstruction {
    
    var title: String
    var description: String
    var recordName: String
    init(title: RecordInstructions.Titles, desc: RecordInstructions.Descriptions, recordName: String){
        self.title = title.rawValue
        self.description = desc.rawValue
        self.recordName = recordName
    }
    
}


class RecordInstructions {
    
    enum Stage{
        case cough
        case count
        case aaa
        case eee
    }
    
    var instruction: RecordInstruction!{
        didSet{
            guard let _ = instruction else {return}
            switch stage{
            case .aaa:
                nextStage = .eee
            case .eee:
                nextStage = .count
            case .count:
                nextStage = .cough
            case .cough:
                nextStage = nil
            default:
                return
            }
        }
    }
    var nextStage: Stage?
    var stage: Stage?
    
    enum Titles : String{
        case cough = "שיעול 3 פעמים"
        case count = "ספירה באנגלית מ1 עד 10"
        case eee = "אייייי"
        case aaa = "אההההה"
    }
    
    enum Descriptions: String{
        case cough = ""
        case count = "בלי הפסקות, אם לא נוח באנגלית, אפשר גם בעברית"
        case eee = "כמו במילה אמא, ארוך בלי הפסקות עד שיגמר לך האוויר"
        case aaa = "כמו במילה אבא, ארוך בלי הספקות עד שיגמר לך האוויר"
        
    }
    
    init(stage: Stage){
        self.stage = stage
        switch stage{
        case .cough:
            instruction = RecordInstruction(title: .cough, desc: .cough, recordName: "cough")
            self.nextStage = nil
        case .count:
            instruction = RecordInstruction(title: .count, desc: .count, recordName: "count")
            self.nextStage = .cough
        case .eee:
            instruction = RecordInstruction(title: .eee, desc: .eee, recordName: "eee")
            self.nextStage = .count
        case .aaa:
            instruction = RecordInstruction(title: .aaa, desc: .aaa, recordName: "aaa")
            self.nextStage = .eee
            
        }
    }
    
    
}



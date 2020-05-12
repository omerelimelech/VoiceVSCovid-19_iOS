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
        case ABC
        case count
        case aaa
        case eee
        case ooo
    }
    
    var instruction: RecordInstruction!{
        didSet{
            guard let _ = instruction else {return}
            switch stage{
            case .cough:
                nextStage = .count
            case .count:
                
                nextStage = .ABC
            case .ABC:
                
                nextStage = .ooo
            case .ooo:
                
                nextStage = .eee
            case .eee:
                
                nextStage = .aaa
            case .aaa, .none:
                nextStage = nil

            }
        }
    }
    var nextStage: Stage?
    var stage: Stage?
    
    enum Titles : String{
        case cough = "Please cough three times"
        case count = "Count from 1 to 20"
        case ABC = "Please recite the alphabet:"
        case eee = "Say the vowel \"ee\" for as long ass you can : EEEE"
        case ooo = "Say the vowel \"o\" for as long ass you can : OOOO"
        case aaa = "Say the vowel \"a\" for as long ass you can : AAAA"
    }
    
    enum Descriptions: String{
        case cough = ""
        case count = " "
        case ABC = "A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z"
        case eee = "(as in the word \"cheese\")"
        case ooo = "(as in the word \"box\")"
        case aaa = "(as in the word \"sad\")"
        
    }
    
    init(stage: Stage){
        self.stage = stage
        switch stage{
        case .cough:
            instruction = RecordInstruction(title: .cough, desc: .cough, recordName: "cough")
            self.nextStage = .count
        case .count:
            instruction = RecordInstruction(title: .count, desc: .count, recordName: "count")
            self.nextStage = .ABC
        case .ABC:
            instruction = RecordInstruction(title: .ABC, desc: .ABC, recordName: "ABC")
            self.nextStage = .ooo
        case .ooo:
            instruction = RecordInstruction(title: .ooo, desc: .ooo, recordName: "ooo")
            self.nextStage = .eee
        case .eee:
            instruction = RecordInstruction(title: .eee, desc: .eee, recordName: "eee")
            self.nextStage = .aaa
        case .aaa:
            instruction = RecordInstruction(title: .aaa, desc: .aaa, recordName: "aaa")
            self.nextStage = nil
            
        }
    }
    
    
}



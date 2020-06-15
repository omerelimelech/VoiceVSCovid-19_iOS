//
//  LocalizationEnums.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 14/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


enum Gender: String, LocalizedEnum{
       static var allValues: [LocalizedEnum]{
           return [Gender.male, Gender.female, Gender.other]
       }

       case male = "Male"
       case female = "Female"
       case other = "Other"
       
       func localizedString() -> String{
           return self.rawValue.localized()
       }
       
       var englishValue: String{
           return self.rawValue
       }
       
   }

enum SmokeSatus: String, LocalizedEnum{
    
    case currentlySmoke = "I currently smoke"
    case usedToSmoke = "I used to smoke"
    case neverSmoked = "I've never smoked"
    func localizedString() -> String {
        return self.rawValue.localized()
    }
    static var allValues: [LocalizedEnum]{
        return [SmokeSatus.currentlySmoke, SmokeSatus.usedToSmoke, SmokeSatus.neverSmoked]
    }
    var englishValue: String{
        return self.rawValue
    }
}


enum Diagnoses : String, LocalizedEnum{
    case diabtes = "Diabetes"
    case hypertension = "Hypertension"
    case ischemicHeart = "Ischemic heart disease"
    case asthma = "Asthma"
    case allergies = "Allergies"
    case chronicLung = "Chronic lung disease"
    case chronicKidney = "Chronic kidney disease"
    case seasonalAllergies = "Seasonal allergies"
    
    func localizedString() -> String {
        return self.rawValue.localized()
    }
    
    static var allValues: [LocalizedEnum]{
        return [Diagnoses.diabtes,Diagnoses.hypertension,Diagnoses.ischemicHeart,Diagnoses.asthma,Diagnoses.allergies,Diagnoses.chronicLung,Diagnoses.chronicKidney,Diagnoses.seasonalAllergies]
    }
    var englishValue: String{
        return self.rawValue
    }
}


enum CurrentStatus : String, LocalizedEnum{
    case notIn = "Not in isolation"
    case hospitalized = "Hospitalized"
    case dueToCovid = "in isolation due to being diagnosed with respiratory disease"
    
    case dueToTravel = "in isolation due to recent international travel"
    case contactWithIndividual = "in isolation due to contact with an individual who was infected or an individual who recently"
    case dueToGovernment = "in isolation due to government regulations"
    
    func localizedString() -> String {
        return self.rawValue.localized()
    }
    static var allValues: [LocalizedEnum]{
        return [CurrentStatus.notIn, CurrentStatus.hospitalized, CurrentStatus.dueToCovid, CurrentStatus.dueToTravel,CurrentStatus.contactWithIndividual, CurrentStatus.dueToGovernment]
    }
    var englishValue: String{
        return self.rawValue
    }
}


enum YesNo : String, LocalizedEnum{
    case yes = "Yes"
    case no = "No"
    
    func localizedString() -> String {
        return self.rawValue.localized()
    }
    static var allValues: [LocalizedEnum]{
        return [YesNo.yes, YesNo.no]
    }
    var englishValue: String{
        return self.rawValue
    }
}

enum Sympthoms : String, LocalizedEnum {
    case feelWell = "I feel well"
    case fever = "I have a fever"
    case dryCough = "Dry cough"
    case coughWithSputum = "Cough with sputum production"
    case fatigue = "Fatigue"
    case muscleAches = "Muscle aches"
    case headache = "Headache"
    case soreThroat = "Sore throat"
    case sneezing = "Sneezing"
    case shortnessOfBreath = "Shortness of breath"
    case runnyNose = "Runny nose or Nasal congestion"
    case itching = "Itching (eyes or other)"
    case diarrhea = "Diarrhea"
    case nausea = "Nausea and/or vomiting"
    
    func localizedString() -> String {
        return self.rawValue.localized()
    }
    
    static var allValues: [LocalizedEnum]{
        return [Sympthoms.feelWell, Sympthoms.fever, Sympthoms.dryCough, Sympthoms.coughWithSputum, Sympthoms.fatigue, Sympthoms.muscleAches,Sympthoms.headache,Sympthoms.soreThroat, Sympthoms.sneezing,Sympthoms.shortnessOfBreath, Sympthoms.runnyNose, Sympthoms.itching,Sympthoms.diarrhea,Sympthoms.nausea]
    }
    var englishValue: String{
        return self.rawValue
    }
}


enum TempertureType : String, LocalizedEnum{
    case celsious = "Celsius"
    case fahrenheit = "Fahrenheit"
    
    func localizedString() -> String {
        return self.rawValue.localized()
    }
    static var allValues: [LocalizedEnum]{
        return [TempertureType.celsious, TempertureType.fahrenheit]
    }
    var englishValue: String{
        return self.rawValue
    }
}

enum HeightType : String, LocalizedEnum{
    case feet = "Feet"
    case centimeters = "Centimeters"
    
    func localizedString() -> String {
        return self.rawValue.localized()
    }
    static var allValues: [LocalizedEnum]{
        return [HeightType.centimeters, HeightType.feet]
    }
    var englishValue: String{
        return self.rawValue
    }
}

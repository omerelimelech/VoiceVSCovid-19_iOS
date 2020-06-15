//
//  MainViewContrller.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 07/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit



class MainViewController: UIViewController{
    
    
    @IBOutlet weak var topTextVIew: UITextView!
    
    
    @IBOutlet weak var bottomTextView: UITextView!
    
    
    @IBOutlet weak var summaryTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       setupTexts()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
        
        
        
    }
    @IBAction func goToForm(_ sender: UIButton) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FormNAV") as? UINavigationController else {return}
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func sendRequest(_ sender: UIButton) {
    }
    
}


func adjustUITextViewHeight(arg : UITextView)
 {
     arg.translatesAutoresizingMaskIntoConstraints = true
     arg.sizeToFit()
     arg.isScrollEnabled = false
      
 }


extension MainViewController {
    
    func setupTexts(){
        self.bottomTextView.text = "VocaApp is led by Dr. Shmuel Ur a renowned Israeli inventor and Dr. Alan Bekker, CTO & Co-founder at Voca.ai. The success of this project will have an immense impact on the health of our communities and prevent the spread of disease. We’re starting with global data collection. With this data, we will be able to identify and develop technologies to determine the probability of being infected with respiratory disease using voice analysis. The research and development effort is being conducted in collaboration with Professor Rita Singh from Carnegie Mellon University, and other researchers worldwide. Researchers will use this data to study and develop algorithms that will automatically detect respiratory diseases and related illnesses from voice. These will potentially serve as rapid tests that can be performed over a phone or computer, and aid in the diagnosis.".localized()
        
        self.topTextVIew.text = "The project was created for early diagnosis of respiratory disease. It combines recently developed AI and voice forensic technologies, finding specific patterns in voice, tone and other sounds that we produce as we speak, that relate to unique illnesses and other human factors.".localized()
        
        
        summaryTextView.text = "Following the success of the data collection phase, people will soon be able to determine the likelihood of contracting respiratory disease – with just one short voice recording\nNOW THAT SOUNDS REMARKABLE!!!".localized()
        
    }
}

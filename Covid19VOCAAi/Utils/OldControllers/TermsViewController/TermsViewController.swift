//
//  TermsViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 10/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var summeryTextView: UITextView!
    
    @IBOutlet weak var introductionLabel: UILabel!
    
    @IBOutlet weak var intoductionTextView: UITextView!
    
    @IBOutlet weak var researchTitleLabe: UILabel!
    
    @IBOutlet weak var researchTitleTextView: UITextView!
    
    @IBOutlet weak var benefitsAndRisksLabel: UILabel!
    
    @IBOutlet weak var researchDataAndFeedbackTextView: UITextView!
    @IBOutlet weak var confidentialityTextView: UITextView!
    @IBOutlet weak var beneditsAndRisksTextView: UITextView!
    
    @IBOutlet weak var researchDataAndFeedbackLabel: UILabel!
    @IBOutlet weak var confidentialityLabel: UILabel!
    
    
    @IBOutlet weak var youAuthorityLabel: UILabel!
    
    @IBOutlet weak var yourAuthorityTextView: UITextView!
    
    @IBOutlet weak var agreeButton: GradientButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Terms And Conditions".localized()
        self.titleLabel.text = self.titleLabel.text?.localized()
        self.summeryTextView.text = "The purpose of this venture is to collect data that is useful for diagnosis of COVID-19 patients based on voice analysis. If successful, we hope to use voice samples as a new screening method for early detection of COVID-19 infection. However, at this stage, we are simply collecting information to be made available for the research community and advance rapid new techniques for COVID-19 detection.\nYou will be shown a short questionnaire to collect demographic information, as well as an indication whether or not you have been tested positive for COVID-19. You will be asked to provide a voice sample. We may request that you log-on using your GOOGLE™ account, to enable provisioning of multiple samples over time.\nIf you are interested in learning more about this study, please continue to read below. ".localized()
        self.introductionLabel.text = self.introductionLabel.text?.localized()
        self.intoductionTextView.text = "Thank you for deciding to volunteer in our research project. We aim to study the ability of Deep Learning techniques and voice analysis to assist in diagnosis of COVID-19, and assist in stopping the pandemic. The research project will consist of you filling a short questionnaire and obtaining a recordation of your voice. All your data collected will be anonymized.\nPlease note that you have no obligation to participate and you may decide to terminate your participation at any time. Below is a description of the research project, and your consent to participate. Please read this information carefully.\nBy clicking the button, you are agreeing that you’ve had time to read and consider this consent waiver and are comfortable with what is being asked of you as a participant. ".localized()
        self.researchTitleLabe.text = self.researchTitleLabe.text?.localized()
        self.researchTitleTextView.text = self.researchTitleTextView.text?.localized()
        self.benefitsAndRisksLabel.text = self.benefitsAndRisksLabel.text?.localized()
        self.beneditsAndRisksTextView.text = "We hope to be able to assist in early and remote diagnosis of COVID-19 patients, to target suspected cases for expensive laboratory tests.\nWe have not identified any particular risk associated with your participation in this venture. ".localized()
        self.researchDataAndFeedbackLabel.text = self.researchDataAndFeedbackLabel.text?.localized()
        self.researchDataAndFeedbackTextView.text = self.researchDataAndFeedbackTextView.text?.localized()
        self.confidentialityLabel.text = self.confidentialityLabel.text?.localized()
        self.confidentialityTextView.text = "We will keep your information confidential and will not divulge any non-anonymized data. Anonymized dataset may be transferred to third parties. In particular, anonymized data may be transferred to third parties for COVID-19 related research purposes.\nIf you log-in using your GOOGLE™ identifier, we will not collect any information from your GOOGLE™ account other than your identifier. The identifier will be retained in a hashed manner, preventing us from being able to reconstruct your identifier, and being useful for the sole purpose of determining if a new identifier is identical to a previously retained one. ".localized()
        self.youAuthorityLabel.text = self.youAuthorityLabel.text?.localized()
        self.yourAuthorityTextView.text = "You represent that you have the full right and authority to sign this form.\nBy clicking the survey button, you confirm that you understand what the project is about and how and why it is being done. Should you have any questions concerning this project, please contact the supervising researchers:\n\nVoca.ai\nShmuel Ur at shmuel.ur@gmail.com\nPlease print this page for your records.\n\nWe thank you for your participation.".localized()
        
        agreeButton.setTitle("Agree & Continue".localized(), for: .normal) 
    }
    

    

    @IBAction func dismissTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func agreeButtonTapped(_ sender: UIButton) {
        GlobalData.shared.agreedToTerms = true
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FormViewController") as? FormViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)

    }
    

}

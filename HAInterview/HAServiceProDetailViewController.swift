//
//  HAServiceProDetailViewController.swift
//  HAInterview
//
//  Created by Pauga, Justin on 12/26/18.
//  Copyright © 2018 Pauga. All rights reserved.
//

import UIKit
import MessageUI

class HAServiceProDetailViewController: UIViewController {

    var servicePro: HAServicePro?
    
    @IBOutlet weak var proNameLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let pro = servicePro {
            proNameLabel.text = pro.companyName
            specialtyLabel.text = pro.specialty
            locationLabel.text = pro.primaryLocation
            servicesLabel.text = pro.servicesOffered
            overviewTextView.text = pro.companyOverview
            setupRatings()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //set the text view to start at the beginning of the text
        overviewTextView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func setupRatings() {
        guard let pro = servicePro else { return }
        if let ratingCountString = pro.ratingCount, let compositeRatingString = pro.compositeRating {
            let ratingCount = Int(ratingCountString)!
            let compositeRatings = Double(compositeRatingString)!
            
            if ratingCount == 0 {
                ratingLabel.text = "References Available"
                ratingLabel.textColor = .black
            } else {
                ratingLabel.text = "Rating: \(compositeRatings) | \(ratingCount) rating(s)"
                if compositeRatings < 3.0 {
                    ratingLabel.textColor = .red
                } else if compositeRatings >= 3.0 && compositeRatings < 4.0 {
                    ratingLabel.textColor = .orange
                } else {
                    ratingLabel.textColor = .green
                }
            }
        }
        
        
    }
    
    @IBAction func callButtonTapped(_ sender: Any) {
        if let phoneNumber = servicePro?.phoneNumber {
            print("phone = <phone number> \n\n\n\n\n\njust kidding \nphone = \(phoneNumber)")
            
           let formattedNumber = phoneNumber.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
            let phoneUrl = "tel://\(formattedNumber)"
            let url:NSURL = NSURL(string: phoneUrl)!
            UIApplication.shared.open(url as URL, completionHandler: nil)
        }
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        if let email = servicePro?.email {
            print("email = <email> \n\n\n\n\n\njust kidding \nemail = \(email)")
        }
        sendMail()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HAServiceProDetailViewController: MFMailComposeViewControllerDelegate {
    func sendMail() {
        if MFMailComposeViewController.canSendMail(), let email = servicePro?.email {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            
            present(mail, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}

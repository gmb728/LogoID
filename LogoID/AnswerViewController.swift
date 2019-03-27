//
//  AnswerViewController.swift
//  LogoID
//
//  Created by Chang Sophia on 3/26/19.
//  Copyright © 2019 Chang Sophia. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var nameImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!

var newNames: ArraySlice<String> = []
let names = ["BMW", "Burgerking", "Danone", "Estrella", "Jaguar", "Nescafe", "Nutella", "Pepsi", "Peugeot", "Porsche", "Snickers", "Volkswagen", "Knorr", "Nestea", "Nestle" ]
    
    @IBAction func checkButtonPressed(_ sender: Any) {
        newNames = names.shuffled()[0...1]
        let answerIndex = Int.random(in: 0...1)
         nameLabel.text = newNames[answerIndex]
        nameImageView.image = UIImage(named: newNames[answerIndex])
        
        
        
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

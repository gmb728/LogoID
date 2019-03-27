//
//  ViewController.swift
//  LogoID
//
//  Created by Chang Sophia on 2/27/19.
//  Copyright © 2019 Chang Sophia. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
   
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var answersButton: [UIButton]!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nextPage: UIButton!
    @IBOutlet weak var questionCountLabel: UILabel!
    
    
    var player: AVPlayer?
    var choices: [String] = [] //目前題目選項陣列
    var totalScore: Int = 0
    var mul: qna? //目前的題目物件
    var test: [Int] = [] //題庫的出題順序
    var timer = Timer()
    var count = 0
    var counter = 30//計時器，一開始30秒
    var questionCount = 0
    var number = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playAgain.clipsToBounds = true
        playAgain.layer.cornerRadius = 30
        playAgain.layer.masksToBounds = false
        playAgain.layer.shadowOffset = CGSize(width:-5,height:5)
        playAgain.layer.shadowColor = UIColor.darkGray.cgColor
        playAgain.layer.shadowOpacity = 0.8
        nextPage.clipsToBounds = true
        nextPage.layer.cornerRadius = 30
        nextPage.layer.masksToBounds = false
        nextPage.layer.shadowOffset = CGSize(width:-5,height:5)
        nextPage.layer.shadowColor = UIColor.darkGray.cgColor
        nextPage.layer.shadowOpacity = 0.8
        
        
        let number = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
        test = number.shuffled()
        timeLabel.text = "30"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRun), userInfo:nil, repeats: true)
        changeQuestion()
    
    
    
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        answersButton[0].setTitle(choices[0], for: .normal)
        answersButton[1].setTitle(choices[1], for: .normal)
        let number = answersButton.firstIndex(of: sender)
        if (answersButton[number!].currentTitle == mul!.answer){
            totalScore += 10
            gradeLabel.text = String(totalScore)
            if let url = Bundle.main.url(forResource: "correct", withExtension: "mp3"){
                player = AVPlayer(url: url)
                player?.play()
            }
        }
        else {
            if let url = Bundle.main.url(forResource: "incorrect", withExtension: "mp3"){
                player = AVPlayer(url: url)
                player?.play()
            }
        }
        count += 1
        if (count < 15) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.changeQuestion()
            }
            
        }
        else {
            finalScocre()
        }
    }

    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        questionCount = 0
        progressView.progress = 0
        commentLabel.text = ""
        let number = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
        test = number.shuffled()
        count = 0
        totalScore = 0
        gradeLabel.text = String(totalScore)
        counter = 30
        timeLabel.text = "30"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRun), userInfo:nil, repeats: true)
        for i in 0...1 {
            answersButton[i].isEnabled = true
        }
        playAgain.setTitle("Play Again",for: .normal)
        
        changeQuestion()
    }
    
    func changeQuestion(){
        questionCount = questionCount + 1
        progressView.progress += 0.067
        let question = multiples[number]
        questionCountLabel.text = "\(questionCount)"
        
        mul = multiples[test[count]]
        questionLabel.text = mul!.question
        choices = mul!.choices.shuffled()
        answersButton[0].setBackgroundImage(UIImage(named: choices[0]), for: .normal)
        answersButton[1].setBackgroundImage(UIImage(named: choices[1]), for: .normal)
        
        let speech = AVSpeechUtterance(string: questionLabel.text!)
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speech)
    }

    func finalScocre(){
       timer.invalidate()
        for i in 0...1 {
            answersButton[i].isEnabled = false
            if totalScore > 120 {
                commentLabel.text = "厲害!平常是閃靈刷手吧?!"
            }else if totalScore > 80 &&  totalScore < 120{
                commentLabel.text = "我知道你還差一部馬莎拉蒂!"
            }else {
                commentLabel.text = "沒關係, 勤儉持家也很好"
            }
        }
            playAgain.setTitle("Play Again", for: .normal)
    }
    
    @objc func timerRun() {
        counter -= 1
        let countSec: Int = counter % 60
        let countMin: Int = counter / 60
        timeLabel.text = String(countMin) + String(format: "%02d", countSec)
        if (counter > 0) {
        }
        else {
            finalScocre()
        }
    }
   
    override func viewDidDisappear(_ animated: Bool) {
        if timer != nil {
            timer.invalidate()
        }
    }


}

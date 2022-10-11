//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Mehmet Mustafa Kılıç on 28.07.2022.
//

import UIKit

class ViewController: UIViewController {

    //Views
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var highLable: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!

    //Variables
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var highScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        //scoreLable.text = "Score: \(score)"
        scoreLable.text = String(score)

        //High Score Check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")

        //images
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true

        let recognize1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognize2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognize3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognize4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognize5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognize6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognize7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognize8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognize9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recognize1)
        kenny2.addGestureRecognizer(recognize2)
        kenny3.addGestureRecognizer(recognize3)
        kenny4.addGestureRecognizer(recognize4)
        kenny5.addGestureRecognizer(recognize5)
        kenny6.addGestureRecognizer(recognize6)
        kenny7.addGestureRecognizer(recognize7)
        kenny8.addGestureRecognizer(recognize8)
        kenny9.addGestureRecognizer(recognize9)
        
         kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]

        //Timers
        counter = 10
        timeLable.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        hideKenny()

    }
    
    @objc func hideKenny (){
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
    }
    
    @objc func countDown(){
        counter -= 1
        timeLable.text = String(counter)
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            //High Score
            
            if self.score > self.highScore{
                self.highScore = self.score
                highLable.text = "High Score: \(self.highScore)"
                UserDefaults.standard.set( self.highScore, forKey: "highScore")
                
            }

            //Alert

            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title:"Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //Replay function
                self.score = 0
                self.scoreLable.text = "Score \(self.score)"
                self.counter = 10
                self.timeLable.text = String(self.counter)
                
                self.timeLable.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                

            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    @objc func increaseScore(){
        score += 1
        scoreLable.text = "Score: \(score)"
        
    }

}


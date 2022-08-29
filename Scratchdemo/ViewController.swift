//
//  ViewController.swift
//  Scratchdemo
//
//  Created by Mac on 06/05/22.
//

import UIKit
import SRScratchView

class ViewController: UIViewController,SRScratchViewDelegate {

    @IBOutlet weak var scratchCard: UIView!
    @IBOutlet weak var scratchImageView: SRScratchView!
    
    @IBOutlet weak var scratchImageView1: SRScratchView!
    @IBOutlet weak var scratchImageView2: SRScratchView!
    @IBOutlet weak var scratchImageView3: SRScratchView!
    @IBOutlet weak var scratchImageView4: SRScratchView!
    @IBOutlet weak var scratchImageView5: SRScratchView!
    @IBOutlet weak var scratchImageView6: SRScratchView!
    @IBOutlet weak var winningLbl1: UILabel!
    @IBOutlet weak var winningLbl2: UILabel!
    @IBOutlet weak var winningLbl3: UILabel!
    @IBOutlet weak var winningLbl4: UILabel!
    @IBOutlet weak var winningLbl5: UILabel!
    @IBOutlet weak var winningLbl6: UILabel!
    
    var winningSequence:[UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winningSequence = [winningLbl1,winningLbl2,winningLbl3,winningLbl4,winningLbl5,winningLbl6]
        
        for sequenceNumber in winningSequence{
            let n = Int.random(in: 1...49)
            sequenceNumber.text = "\(n)"
        }
        self.scratchImageView1.roundCorners()
        self.scratchImageView2.roundCorners()
        self.scratchImageView3.roundCorners()
        self.scratchImageView4.roundCorners()
        self.scratchImageView5.roundCorners()
        self.scratchImageView6.roundCorners()
//        scratchImageView1.lineWidth = 40.0
//        self.scratchImageView1.delegate = self
//        self.scratchImageView1.layer.cornerRadius = scratchImageView1.frame.size.height/2
//        self.scratchImageView1.layer.masksToBounds = true
    }
    
    func scratchCardEraseProgress(eraseProgress: Float) {
        print(eraseProgress)
        if eraseProgress > 90.0{
            UIView.animate(withDuration: 0.5, animations: {
                self.scratchImageView.alpha = 0.0
            })
            
        }
    }
}

extension SRScratchView{
    func roundCorners(){
        self.lineWidth = 40.0
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
    }
}
  
extension UIView{
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [#colorLiteral(red: 1, green: 0.2431372549, blue: 0.2274509804, alpha: 1).cgColor, #colorLiteral(red: 0.9294117647, green: 0.4078431373, blue: 0.2352941176, alpha: 1).cgColor, #colorLiteral(red: 0.9529411765, green: 0.5647058824, blue: 0.2470588235, alpha: 1).cgColor]
        gradientLayer.locations = [0, 0.5,1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

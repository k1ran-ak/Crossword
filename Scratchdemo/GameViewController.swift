//
//  GameViewController.swift
//  Scratchdemo
//
//  Created by Mac on 16/05/22.
//

import UIKit
import SRScratchView

class GameViewController: UIViewController,SRScratchViewDelegate {

    @IBOutlet weak var winningNumber: UIView!
    @IBOutlet weak var winningNumberBaseView: UIView!
    @IBOutlet weak var yourNumber: UIView!
    @IBOutlet weak var yourNumberBaseView: UIView!
    
    @IBOutlet weak var yourNumber1: UILabel!
    @IBOutlet weak var yourNumber2: UILabel!
    @IBOutlet weak var yourNumber3: UILabel!
    @IBOutlet weak var yourNumber4: UILabel!
    @IBOutlet weak var yourNumber5: UILabel!
    
    @IBOutlet weak var yourNumberView1: UIView!
    @IBOutlet weak var yourNumberView2: UIView!
    @IBOutlet weak var yourNumberView3: UIView!
    @IBOutlet weak var yourNumberView4: UIView!
    @IBOutlet weak var yourNumberView5: UIView!
    
    @IBOutlet weak var winningLbl1: UILabel!
    @IBOutlet weak var winningLbl2: UILabel!
    @IBOutlet weak var winningLbl3: UILabel!
    @IBOutlet weak var winningLbl4: UILabel!
    @IBOutlet weak var winningLbl5: UILabel!
    @IBOutlet weak var winningLbl6: UILabel!
    @IBOutlet weak var winningLbl7: UILabel!
    @IBOutlet weak var winningLbl8: UILabel!
    @IBOutlet weak var winningLbl9: UILabel!
    @IBOutlet weak var winningLbl10: UILabel!
    @IBOutlet weak var winningLbl11: UILabel!
    @IBOutlet weak var winningLbl12: UILabel!
    
    @IBOutlet weak var winningView1: UIView!
    @IBOutlet weak var winningView2: UIView!
    @IBOutlet weak var winningView3: UIView!
    @IBOutlet weak var winningView4: UIView!
    @IBOutlet weak var winningView5: UIView!
    @IBOutlet weak var winningView6: UIView!
    @IBOutlet weak var winningView7: UIView!
    @IBOutlet weak var winningView8: UIView!
    @IBOutlet weak var winningView9: UIView!
    @IBOutlet weak var winningView10: UIView!
    @IBOutlet weak var winningView11: UIView!
    @IBOutlet weak var winningView12: UIView!
    
    @IBOutlet weak var winningLblamt1: UILabel!
    @IBOutlet weak var winningLblamt2: UILabel!
    @IBOutlet weak var winningLblamt3: UILabel!
    @IBOutlet weak var winningLblamt4: UILabel!
    @IBOutlet weak var winningLblamt5: UILabel!
    @IBOutlet weak var winningLblamt6: UILabel!
    @IBOutlet weak var winningLblamt7: UILabel!
    @IBOutlet weak var winningLblamt8: UILabel!
    @IBOutlet weak var winningLblamt9: UILabel!
    @IBOutlet weak var winningLblamt10: UILabel!
    @IBOutlet weak var winningLblamt11: UILabel!
    @IBOutlet weak var winningLblamt12: UILabel!
    
    @IBOutlet weak var winningscratchImageView: SRScratchView!
    @IBOutlet weak var scratchImageView: SRScratchView!
    
    var winning:[UILabel] = []
    var winningamount:[UILabel] = []
    var yourNumberLbl:[UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winningscratchImageView.lineWidth = 20.0
        winningscratchImageView.lineType = .square
        scratchImageView.lineWidth = 20.0
        scratchImageView.lineType = .square
        winningscratchImageView.delegate = self
        scratchImageView.delegate = self
        winning = [winningLbl1,winningLbl2,winningLbl3,winningLbl4,winningLbl5,winningLbl6,winningLbl7,winningLbl8,winningLbl9,winningLbl10,winningLbl11,winningLbl12]
        winningamount = [winningLblamt1,winningLblamt2,winningLblamt3,winningLblamt4,winningLblamt5,winningLblamt6,winningLblamt7,winningLblamt8,winningLblamt9,winningLblamt10,winningLblamt11,winningLblamt12]
        yourNumberLbl = [yourNumber1,yourNumber2,yourNumber3,yourNumber4,yourNumber5]
        for sequenceNumber in winning {
            let n = Int.random(in: 1...49)
            sequenceNumber.text = "\(n)"
        }
        for sequenceNumber in yourNumberLbl {
            let n = Int.random(in: 1...49)
            sequenceNumber.text = "\(n)"
        }
        for sequenceNumber in winningamount {
            let n = Int.random(in: 50...100)
            sequenceNumber.text = "\(n)K"
        }
        winningNumber.layer.borderColor = UIColor.orange.cgColor
        winningNumber.layer.borderWidth = 1.0
        winningNumberBaseView.layer.borderColor = UIColor.orange.cgColor
        winningNumberBaseView.layer.borderWidth = 1.0
        yourNumber.layer.borderColor = UIColor.orange.cgColor
        yourNumber.layer.borderWidth = 1.0
        yourNumberBaseView.layer.borderColor = UIColor.orange.cgColor
        yourNumberBaseView.layer.borderWidth = 1.0
    }

    func scratchCardEraseProgress(eraseProgress: Float) {
        if eraseProgress > 90.0 {
            winning.forEach { your in
                yourNumberLbl.forEach { winning in
                    if your.text == winning.text{
                        winning.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.5)
                        your.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.5)
                    }
                }
            }
        }
    }
}

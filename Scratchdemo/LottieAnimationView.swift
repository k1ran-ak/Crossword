//
//  AnimationView.swift
//  Scratchdemo
//
//  Created by Mac on 25/05/22.
//

import UIKit
import Lottie

class LottieAnimationView: UIView {
   
    @IBOutlet weak var baseView: UIView!
    var animatedView = AnimationView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loaderAnimation()
//        self.animatedView = AnimationView(name: "9651-winner")
//        self.animatedView.contentMode = .scaleAspectFill
//        self.animatedView.center
//        self.animatedView.frame = CGRect(x: 0, y: 0, width: baseView.frame.size.width, height: baseView.frame.size.height)
//        self.baseView.addSubview(animatedView)
//        self.animatedView.loopMode = .playOnce
//        self.animatedView.play(){ (finished) in
//
//        }
    }
    
    func loaderAnimation() {
        self.animatedView = AnimationView(name: "9651-winner")
        self.animatedView.contentMode = .scaleAspectFit
        self.animatedView.frame = CGRect(x: 0, y: 0, width: baseView.frame.size.width, height: baseView.frame.size.height)
        self.animatedView.loopMode = .playOnce
        self.baseView.addSubview(self.animatedView)
        self.animatedView.play{ (finished) in
            self.removeFromSuperview()
          }
        }
    
    class func instanceFromNib() -> UIView {
        let animation = UINib(nibName: "LottieAnimationView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LottieAnimationView
        return animation
     }
    
}



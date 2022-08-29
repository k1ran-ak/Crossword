//
//  CrossWordViewController.swift
//  Scratchdemo
//
//  Created by Mac on 18/05/22.
//

import UIKit
import CrosswordsGenerator
import SRScratchView
import Lottie


class CrossWordCell:UICollectionViewCell{
    @IBOutlet weak var crossWordLbl:UILabel!
    @IBOutlet weak var crossWordView:UIView!
}

class CrossWordViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,SRScratchViewDelegate {
    
    var gridSize: CGFloat = 10
    var words:[String] = ["BEIJING", "HAVANA", "ROME", "PARIS", "AMSTERDAM"]
    var wordMap:[String:String] = [:]
    var selecteItem:[Int] = []
    lazy fileprivate var gridGenerator: WordGridGenerator = {
        return WordGridGenerator(words: words, row: nRow, column: nCol)
    }()
    fileprivate let nRow = 10
    fileprivate let nCol = 10
    fileprivate var grid: Grid = Grid()
 
    @IBOutlet weak var scratchView: SRScratchView!
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    @IBOutlet weak var scratchheightConstant: NSLayoutConstraint!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var wordLbl:UILabel!
    private let fireworkController = ClassicFireworkController()
    var animatedView = AnimationView()
    var isLoad:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        generateCrossWord()
        let layout = UICollectionViewFlowLayout()
               layout.minimumInteritemSpacing = 1
               layout.minimumLineSpacing = 1
        collectionView.dataSource = self
               collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setGradient()
        scratchView.delegate = self
        let size = (view.frame.width - 32) / gridSize
        self.heightConstant.constant = size * gridSize
        self.scratchheightConstant.constant = size * gridSize
        self.collectionView.addBorder(toSide: .Bottom, withColor: UIColor.red.cgColor, andThickness: 0.5)
        self.collectionView.addBorder(toSide: .Right, withColor: UIColor.red.cgColor, andThickness: 0.5)
    }
    
    
    func generateCrossWord(){
        DispatchQueue.global().async { [self] in
            if let grid = self.gridGenerator.generate() {
                self.wordMap = self.gridGenerator.wordsMap
                let start:[String] = self.wordMap.first?.key.components(separatedBy:":") ?? []
                let key = WordGridGenerator.wordKey(for: Position(row: Int(start[0])!, col: Int(start[1])!), and: Position(row: Int(start[2])!, col: Int(start[3])!))
                if let word = self.gridGenerator.wordsMap[key] {
                    DispatchQueue.main.async {
                        self.wordLbl.text = word
                    }
                }
                self.grid = grid
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func loaderAnimation() {
        self.isLoad = true
        self.animatedView = AnimationView(name: "9651-winner")
        self.animatedView.contentMode = .scaleAspectFit
        self.animatedView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.animatedView.loopMode = .playOnce
        self.view.addSubview(self.animatedView)
        self.animatedView.play{ (finished) in
            self.isLoad = false
            self.animatedView.removeFromSuperview()
          }
        }
    
    private func position(from index: Int) -> Position {
        return Position(row: index / nRow, col: index % nCol)
    }
    
    private func getCell(_ row: Int,_ column:Int) -> Int {
        return (row * nRow)+column
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return Int(pow(Double(gridSize), 2))
       }

       func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CrossWordCell", for: indexPath) as! CrossWordCell
           cell.crossWordLbl.text = "\(indexPath.item)"
           cell.crossWordView.addBorder(toSide: .Left, withColor: UIColor.white.cgColor, andThickness: 0.5)
           cell.crossWordView.addBorder(toSide: .Top, withColor: UIColor.white.cgColor, andThickness: 0.5)
           let pos = position(from: indexPath.row)
           cell.crossWordLbl.text = String(grid[pos.row][pos.col])
           if selecteItem.contains(indexPath.item) {
               cell.crossWordView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.5)
           }
           if ("\(indexPath.item)".contains("9")) {
               cell.crossWordView.addBorder(toSide: .Right, withColor: UIColor.white.cgColor, andThickness: 0.5)
               cell.crossWordView.addBorder(toSide: .Bottom, withColor: UIColor.white.cgColor, andThickness: 0.5)
           }
           return cell
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let size = (view.frame.width - 32) / gridSize
           return CGSize(width: size, height: size)
       }
    
//    @objc func panHandling(gestureRecognizer: UIPanGestureRecognizer) {
//        let point = gestureRecognizer.location(in: gridCollectionView)
//        guard let indexPath = gridCollectionView.indexPathForItem(at: point) else {
//            return
//        }
//        let pos = position(from: indexPath.row)
//
//        switch gestureRecognizer.state {
//        case .began:
//            overlayView.addTempLine(at: pos)
//            // Select item to animate the cell
//            // Since we set the collection view `selection mode` to single
//            // This means only one letter is animated at a time.
//            // So in `.ended` event, we just need to deselect one cell.
//            gridCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
//        case .changed:
//            if overlayView.moveTempLine(to: pos) {
//                gridCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
//            }
//        case .ended:
//            // Stop animation
//            gridCollectionView.deselectItem(at: indexPath, animated: true)
//            guard let startPos = overlayView.tempLine?.startPos else {
//                return
//            }
//            // Get the word from the pre-computed map
//            let key = WordGridGenerator.wordKey(for: startPos, and: pos)
//            if let word = gridGenerator.wordsMap[key] {
//                overlayView.acceptLastLine()
//                wordListCollectionView.select(word: word)
//                if overlayView.permanentLines.count == gridGenerator.words.count {
//                    // Pause the time because user has won the game.
//                    timer?.invalidate()
//                }
//            }
//            // Remove the temp line
//            overlayView.removeTempLine()
//        default: break
//        }
//    }
    
    func scratchCardEraseProgress(eraseProgress: Float) {
        if eraseProgress > 90.0 {
            UIView.animate(withDuration: 1.0, animations: {
                self.scratchView.alpha = 0.0
                if !self.isLoad {
                    self.loaderAnimation()
                }
                
            })
            let start:[String] = wordMap.first?.key.components(separatedBy:":") ?? []
            if selecteItem.count < 1 {
                collectionView.drawLineFrom(from: IndexPath(item: getCell(Int(start[0])!,  Int(start[1])!), section:0), to: IndexPath(item: getCell(Int(start[2])!,  Int(start[3])!), section:0))
            }
        }
    }
    
}

extension UICollectionView {

    func drawLineFrom(
        from: IndexPath,
        to: IndexPath,
        lineWidth: CGFloat = 2,
        strokeColor: UIColor = UIColor.systemGreen.withAlphaComponent(0.5)
    ) {
        guard
            let fromPoint = cellForItem(at: from)?.center,
            let toPoint = cellForItem(at: to)?.center
        else {
            return
        }
        let path = UIBezierPath()
        path.move(to: convert(fromPoint, to: self))
        path.addLine(to: convert(toPoint, to: self))
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = lineWidth
        layer.strokeColor = strokeColor.cgColor

        self.layer.addSublayer(layer)
    }
}


extension UIView {

    enum ViewSide {
        case Left, Right, Top, Bottom
    }

    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color

        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }

        layer.addSublayer(border)
    }
}


//
//  TestViewController.swift
//  poc
//
//  Created by Boominadha Prakash on 21/12/17.
//  Copyright © 2017 Truway. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var questionCollectionView: UICollectionView!{didSet{
        let nib = UINib(nibName: TestCell.reuseIdentifier(), bundle: nil)
        questionCollectionView.register(nib, forCellWithReuseIdentifier: TestCell.reuseIdentifier())
        questionCollectionView.isPagingEnabled = true
        questionCollectionView.showsHorizontalScrollIndicator = false
        questionCollectionView.showsVerticalScrollIndicator = false
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        }}
    var questions:[QuestionMeta] = [QuestionMeta]()
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.url(forResource: "response", withExtension: "json") {
            do {
                let data = try Data.init(contentsOf: path)
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any]
                if let json = jsonObj{
                    for i in 0..<json.count {
                        questions.append(QuestionMeta.init(resp: json[i] as! Dictionary<String, Any>))
                    }
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.questionCollectionView.reloadData()
    }
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParentViewController) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
    func canRotate() -> Void {}
    
    @objc fileprivate func optionSelectedAct(_ sender:UIButton) {
        if let cell = sender.superview?.superview?.superview as? TestCell {
            if let indexPath = self.questionCollectionView.indexPath(for: cell) {
                sender.isSelected = !sender.isSelected
                let questionModel = questions[indexPath.item]
                questionModel.options[sender.tag-1].isSelected = sender.isSelected
            }
        }
    }
}

extension TestViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCell.reuseIdentifier(), for: indexPath) as! TestCell
        cell.option1Btn.addTarget(self, action: #selector(optionSelectedAct(_:)), for: .touchUpInside)
        cell.option2Btn.addTarget(self, action: #selector(optionSelectedAct(_:)), for: .touchUpInside)
        cell.option3Btn.addTarget(self, action: #selector(optionSelectedAct(_:)), for: .touchUpInside)
        cell.option4Btn.addTarget(self, action: #selector(optionSelectedAct(_:)), for: .touchUpInside)
        cell.question = questions[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = self.questionCollectionView.frame.width
        let cellHeight = self.questionCollectionView.frame.height
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            topConstraint.constant = 100
            bottomConstraint.constant = 100
            return CGSize(width: cellWidth, height: cellHeight*0.6)
        }else {
            topConstraint.constant = 8
            bottomConstraint.constant = 8
            return CGSize(width: cellWidth, height: cellHeight*1.5)
        }
    }
    
}

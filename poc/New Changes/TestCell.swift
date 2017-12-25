//
//  TestCell.swift
//  poc
//
//  Created by Boominadha Prakash on 21/12/17.
//  Copyright © 2017 Truway. All rights reserved.
//

import UIKit

class TestCell: UICollectionViewCell {
    
    @IBOutlet weak var questionView: UIView!{didSet{
        questionView.backgroundColor = .clear
        }}
    @IBOutlet weak var questionName: UILabel!{didSet{
        questionName.font = customFont.fontValue
        }}
    @IBOutlet weak var optionsView: UIView!{didSet{
        optionsView.backgroundColor = .clear
        }}
    @IBOutlet weak var option1Btn: UIButton!{didSet{
        option1Btn.tag = 1
        }}
    @IBOutlet weak var option1Lbl: UILabel!{didSet{
        option1Lbl.font = customFont.fontValue
        }}
    @IBOutlet weak var option2Btn: UIButton!{didSet{
        option2Btn.tag = 2
        }}
    @IBOutlet weak var option2Lbl: UILabel!{didSet{
        option2Lbl.font = customFont.fontValue
        }}
    @IBOutlet weak var option3Btn: UIButton!{didSet{
        option3Btn.tag = 3
        }}
    @IBOutlet weak var option3Lbl: UILabel!{didSet{
        option3Lbl.font = customFont.fontValue
        }}
    @IBOutlet weak var option4Btn: UIButton!{didSet{
        option4Btn.tag = 4
        }}
    @IBOutlet weak var option4Lbl: UILabel!{didSet{
        option4Lbl.font = customFont.fontValue
        }}
    @IBOutlet weak var submitBtn: UIButton!{didSet{
        submitBtn.backgroundColor = .red
        submitBtn.layer.cornerRadius = 4.0
        submitBtn.layer.masksToBounds = true
        submitBtn.titleLabel?.font = customFont.fontValue
        submitBtn.setTitleColor(.white, for: .normal)
        submitBtn.setTitle("SUBMIT", for: .normal)
        }}
    var model:QuestionsModel?{didSet{
        if let m = model {
            questionName.text = m.mcqQuestion as? String
            if m.options.count > 0 {
                let option_1 = m.getOption(with: 0)
                let option_2 = m.getOption(with: 1)
                let option_3 = m.getOption(with: 2)
                
                option1Lbl.text = option_1.option
                option2Lbl.text = option_2.option
                option3Lbl.text = option_3.option
                //                    if let option4 = m.option4?.Option {
                //                        if option4 == "" {
                //                            ShowOrHideOption4Objects(true)
                //                        }else {
                //                            ShowOrHideOption4Objects(false)
                //                            option4Lbl.text = m.option4?.Option
                //                        }
                //                    }
                
                print(m.selectedOptions, m.selectedOptions.count)
                
            }
        }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)
    }
    override func prepareForReuse() {
        resetOptionButtons()
    }
    
    private func resetOptionButtons() {
        option1Btn.isSelected = false
        option2Btn.isSelected = false
        option3Btn.isSelected = false
        option4Btn.isSelected = false
    }
    private func ShowOrHideOption4Objects(_ status:Bool) {
        option4Btn.isHidden = status
        option4Lbl.isHidden = status
    }
    public class func reuseIdentifier() -> String {
        return "TestCell"
    }
}

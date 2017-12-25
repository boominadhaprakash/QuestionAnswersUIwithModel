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
        questionName.font = MyFonts.Helvetica_14Font
        }}
    @IBOutlet weak var optionsView: UIView!{didSet{
        optionsView.backgroundColor = .clear
        }}
    @IBOutlet weak var option1Btn: UIButton!{didSet{
        option1Btn.tag = 1
        }}
    @IBOutlet weak var option1Lbl: UILabel!{didSet{
        option1Lbl.font = MyFonts.Helvetica_14Font
        }}
    @IBOutlet weak var option2Btn: UIButton!{didSet{
        option2Btn.tag = 2
        }}
    @IBOutlet weak var option2Lbl: UILabel!{didSet{
        option2Lbl.font = MyFonts.Helvetica_14Font
        }}
    @IBOutlet weak var option3Btn: UIButton!{didSet{
        option3Btn.tag = 3
        }}
    @IBOutlet weak var option3Lbl: UILabel!{didSet{
        option3Lbl.font = MyFonts.Helvetica_14Font
        }}
    @IBOutlet weak var option4Btn: UIButton!{didSet{
        option4Btn.tag = 4
        }}
    @IBOutlet weak var option4Lbl: UILabel!{didSet{
        option4Lbl.font = MyFonts.Helvetica_14Font
        }}
    @IBOutlet weak var submitBtn: UIButton!{didSet{
        submitBtn.backgroundColor = .red
        submitBtn.layer.cornerRadius = 4.0
        submitBtn.layer.masksToBounds = true
        submitBtn.titleLabel?.font = MyFonts.Helvetica_14Font
        submitBtn.setTitleColor(.white, for: .normal)
        submitBtn.setTitle("SUBMIT", for: .normal)
        }}
    var question:QuestionMeta?{
        didSet{
            if let m = question {
                questionName.text = m.mcqQuestion as? String
                if m.options.count > 0 {
                    if let option_1 = m.getOption(with: IndexingOptionsSet.set_1.rawValue),
                        let option_2 = m.getOption(with: IndexingOptionsSet.set_2.rawValue),
                        let option_3 = m.getOption(with: IndexingOptionsSet.set_3.rawValue) {
                        option1Lbl.text = option_1.option
                        option1Btn.isSelected = option_1.isSelected
                        
                        option2Lbl.text = option_2.option
                        option2Btn.isSelected = option_2.isSelected
                        
                        option3Lbl.text = option_3.option
                        option3Btn.isSelected = option_3.isSelected
                        
                        option4Btn.isHidden = true
                        option4Lbl.isHidden = true
                        
                        if let option_4 = m.getOption(with: IndexingOptionsSet.set_4.rawValue) {
                            option4Lbl.text = option_4.option
                            option4Btn.isSelected = option_4.isSelected
                            option4Btn.isHidden = false
                            option4Lbl.isHidden = false
                        }
                    }
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
    
    public class func reuseIdentifier() -> String {
        return "TestCell"
    }
}

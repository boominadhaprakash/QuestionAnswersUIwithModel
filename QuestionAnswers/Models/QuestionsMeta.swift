//
//  Model.swift
//  poc
//
//  Created by Boominadha Prakash on 21/12/17.
//  Copyright © 2017 Truway. All rights reserved.
//

import Foundation

enum questionType {
    case mcq
    case tf
}
class QuestionMeta {
    fileprivate struct SerializeableKeys {
        //common keys for both tf and mcq
        static let kQuestionIdKey:String = "ID"
        static let kQuestionNameKey = "NAME"
        static let kTypeKey = "TYPE"
        static let kSectionQuestionID = "SECTION_QUESTION_ID"
        
        //keys for mcq
        static let kmcqIdKey:String = "MCQ_ID"
        static let kmcqQuestionKey = "MCQ_QUESTION"
        static let kmcqAttemptPreviousKey:String = "MCQ_ATTEMPT_PREVIOUS"
        static let kmcqSelectedOptionsKey = "MCQ_SELECTED_OPTIONS"
        static let kOptionCountKey = "OPTION_COUNT"
        static let kOption1Key = "OPTIONS1"
        static let kOption2Key = "OPTIONS2"
        static let kOption3Key = "OPTIONS3"
        static let kOption4Key = "OPTIONS4"
        
        //keys for tf
        static let ktf_Id = "TF_ID"
        static let ktfQuestionkey = "TF_QUESTION"
        static let ktfAnswerKey = "TF_ANSWER"
        static let ktfAttemptPreviousKey = "TF_ATTEMPT_PREVIOUS"
        static let ktfCorrectKey = "TF_CORRECT"
    }
    let questionID, mcqAttemptPrevious, mcq_tq_Id, mcq_tq_Question, QuestionName, OptionCount, SectionQuestionId, mcqSelectedOptions, type:Any?
    let tfAnswer,tfAttemptPrevious,tfCorrect:Any?
    let questionType:questionType?
    var options:[OptionsMeta] = []
    let response:Dictionary<String,Any>
    init(resp:Dictionary<String,Any>) {
        response = resp
        self.questionID = resp[SerializeableKeys.kQuestionIdKey] as Any
        self.QuestionName = resp[SerializeableKeys.kQuestionNameKey] as Any
        self.SectionQuestionId = resp[SerializeableKeys.kSectionQuestionID] as Any
        self.type = resp[SerializeableKeys.kTypeKey] as Any
        var optionsSerializableEnums:[SerializeableOptionKeys] = [SerializeableOptionKeys]()
        
        if let mcq_id = resp[SerializeableKeys.kmcqIdKey] {
            self.mcq_tq_Id = mcq_id as Any
            self.mcq_tq_Question = resp[SerializeableKeys.kmcqQuestionKey] as Any
            self.mcqAttemptPrevious = resp[SerializeableKeys.kmcqAttemptPreviousKey] as Any
            self.OptionCount = resp[SerializeableKeys.kOptionCountKey] as Any
            self.mcqSelectedOptions = resp[SerializeableKeys.kmcqSelectedOptionsKey] as Any
            self.questionType = .mcq
            let _option1SerialiableKeys = SerializeableOptionKeys.builderValues(rootKey: SerializeableKeys.kOption1Key, subKey: "OPTION1", id: "OPTION_ID1", answer: "OPTION_ANSWER1")
            let _option2SerialiableKeys = SerializeableOptionKeys.builderValues(rootKey: SerializeableKeys.kOption2Key, subKey: "OPTION2", id: "OPTION_ID2", answer: "OPTION_ANSWER2")
            let _option3SerialiableKeys = SerializeableOptionKeys.builderValues(rootKey: SerializeableKeys.kOption3Key, subKey: "OPTION3", id: "OPTION_ID3", answer: "OPTION_ANSWER3")
            optionsSerializableEnums = [_option1SerialiableKeys,_option2SerialiableKeys,_option3SerialiableKeys]
            if resp[SerializeableKeys.kOption4Key] != nil {
                let _option4SerialiableKeys = SerializeableOptionKeys.builderValues(rootKey: SerializeableKeys.kOption4Key, subKey: "OPTION4", id: "OPTION_ID4", answer: "OPTION_ANSWER4")
                optionsSerializableEnums.append(_option4SerialiableKeys)
            }
            for i in 0..<optionsSerializableEnums.count {
                let indexedEnum = optionsSerializableEnums[i]
                if case let SerializeableOptionKeys.builderValues(rootKey, _,_,_) = indexedEnum {
                    self.options.append(OptionsMeta.init(resp: resp[rootKey] as! Dictionary<String, Any>, serializeableKeys: indexedEnum)!)
                }
            }
            self.tfAnswer = "" as Any
            self.tfAttemptPrevious = "" as Any
            self.tfCorrect = "" as Any
        }
        else {
            self.mcq_tq_Id = resp[SerializeableKeys.ktf_Id] as Any
            self.mcq_tq_Question = resp[SerializeableKeys.ktfQuestionkey] as Any
            self.mcqAttemptPrevious = "" as Any
            self.OptionCount = "2" as Any
            self.mcqSelectedOptions = "" as Any
            self.tfAnswer = resp[SerializeableKeys.ktfAnswerKey] as Any
            self.tfAttemptPrevious = resp[SerializeableKeys.ktfAttemptPreviousKey] as Any
            self.tfCorrect = resp[SerializeableKeys.ktfCorrectKey] as Any
            self.questionType = .tf
            let options_model = ["OPTIONS1":["OPTION1":"True","OPTION_ID1":"","OPTION_ANSWER1": (resp[SerializeableKeys.ktfAnswerKey] as! String == "1") ? resp[SerializeableKeys.ktfAnswerKey] : "0"],
                                 "OPTIONS2":["OPTION2":"False","OPTION_ID2":"","OPTION_ANSWER2": (resp[SerializeableKeys.ktfAnswerKey] as! String == "1") ? resp[SerializeableKeys.ktfAnswerKey] : "0"]] as [String:Any]
            let _option1SerialiableKeys = SerializeableOptionKeys.builderValues(rootKey: SerializeableKeys.kOption1Key, subKey: "OPTION1", id: "OPTION_ID1", answer: "OPTION_ANSWER1")
            let _option2SerialiableKeys = SerializeableOptionKeys.builderValues(rootKey: SerializeableKeys.kOption2Key, subKey: "OPTION2", id: "OPTION_ID2", answer: "OPTION_ANSWER2")
            optionsSerializableEnums = [_option1SerialiableKeys,_option2SerialiableKeys]
            for i in 0..<optionsSerializableEnums.count {
                let indexedEnum = optionsSerializableEnums[i]
                if case let SerializeableOptionKeys.builderValues(rootKey, _,_,_) = indexedEnum {
                    self.options.append(OptionsMeta.init(resp: options_model[rootKey] as! Dictionary<String, Any>, serializeableKeys: indexedEnum)!)
                }
            }
        }
    }
    public func getOption(with index:Int)->OptionsMeta? {
        return index < options.count ? options[index] : nil
    }
    
}

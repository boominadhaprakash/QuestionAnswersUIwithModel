//
//  Model.swift
//  poc
//
//  Created by Boominadha Prakash on 21/12/17.
//  Copyright © 2017 Truway. All rights reserved.
//

import Foundation

struct QuestionsModel {
    fileprivate struct Keys {
        static let kQuestionIdKey:String = "ID"
        static let kmcqAttemptPreviousKey:String = "MCQ_ATTEMPT_PREVIOUS"
        static let kmcqIdKey:String = "MCQ_ID"
        static let kmcqQuestionKey = "MCQ_QUESTION"
        static let kQuestionNameKey = "NAME"
        static let kmcqSelectedOptionsKey = "MCQ_SELECTED_OPTIONS"
        static let kOptionCountKey = "OPTION_COUNT"
        static let kSelectedQuestionID = "SECTION_QUESTION_ID"
        static let kTypeKey = "TYPE"
        static let kOption1Key = "OPTIONS1"
        static let kOption2Key = "OPTIONS2"
        static let kOption3Key = "OPTIONS3"
        static let kOption4Key = "OPTIONS4"
    }
    let questionID, mcqAttemptPrevious, mcqId, mcqQuestion, QuestionName, OptionCount, SelectedQuestionId, mcqSelectedOptions, type:Any
    var options:[OptionsMeta] = []
    var selectedOptions:[String] = [String]()
    let response:Dictionary<String,Any>
    init(resp:Dictionary<String,Any>) {
        response = resp
        self.questionID = resp[Keys.kQuestionIdKey] as Any
        self.mcqAttemptPrevious = resp[Keys.kmcqAttemptPreviousKey] as Any
        self.mcqId = resp[Keys.kmcqIdKey] as Any
        self.mcqQuestion = resp[Keys.kmcqQuestionKey] as Any
        self.QuestionName = resp[Keys.kQuestionNameKey] as Any
        self.OptionCount = resp[Keys.kOptionCountKey] as Any
        self.SelectedQuestionId = resp[Keys.kSelectedQuestionID] as Any
        self.mcqSelectedOptions = resp[Keys.kmcqSelectedOptionsKey] as Any
        self.type = resp[Keys.kTypeKey] as Any
        
        var optionsSerializableEnums:[SerializeableOptionKeys] = [SerializeableOptionKeys]()
        let _option1SerialiableKeys = SerializeableOptionKeys.builderValues(rootKey: Keys.kOption1Key, subKey: "OPTION1", id: "OPTION_ID1", answer: "OPTION_ANSWER1")
        let _option2SerialiableKeys = SerializeableOptionKeys.builderValues(rootKey: Keys.kOption2Key, subKey: "OPTION2", id: "OPTION_ID2", answer: "OPTION_ANSWER2")
        let _option3SerialiableKeys = SerializeableOptionKeys.builderValues(rootKey: Keys.kOption3Key, subKey: "OPTION3", id: "OPTION_ID3", answer: "OPTION_ANSWER3")
        optionsSerializableEnums = [_option1SerialiableKeys,_option2SerialiableKeys,_option3SerialiableKeys]
        for i in 0..<optionsSerializableEnums.count {
            let indexedEnum = optionsSerializableEnums[i]
            if case let SerializeableOptionKeys.builderValues(rootKey, _,_,_) = indexedEnum {
                self.options.append(OptionsMeta.init(resp: resp[rootKey] as! Dictionary<String, Any>, serializeableKeys: indexedEnum)!)
            }
        }
    }
    
    public func getOption(with index:Int)->OptionsMeta {
        return self.options[index]
    }
    
}

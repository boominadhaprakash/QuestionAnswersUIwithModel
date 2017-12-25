import Foundation

enum SerializeableOptionKeys {
    case builderValues(rootKey:String, subKey:String, id:String, answer:String)
}

struct OptionsMeta {
    let response:Dictionary<String,Any>
    let option:String
    let internalIdentifier:String
    let answer:String
    
    init?(resp:Dictionary<String,Any>,serializeableKeys:SerializeableOptionKeys) {
        if case let SerializeableOptionKeys.builderValues(_, subKey: _subKey, id: _id, answer: _answer) = serializeableKeys {
            self.response = resp
            self.option = resp[_subKey]! as! String
            self.internalIdentifier = resp[_id]! as! String
            self.answer = resp[_answer]! as! String
        }else {
            return nil
        }
    }
}

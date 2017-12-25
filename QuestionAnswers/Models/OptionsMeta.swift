import Foundation

enum SerializeableOptionKeys {
    case builderValues(rootKey:String, subKey:String, id:String, answer:String)
}
enum IndexingOptionsSet:Int {
    case set_1 = 0,set_2,set_3,set_4
}

class OptionsMeta:NSObject {
    let response:Dictionary<String,Any>
    let option:String
    let internalIdentifier:String
    let answer:String
    var isSelected:Bool = false
    
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

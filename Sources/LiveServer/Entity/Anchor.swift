//
//  Anchor.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/22.
//
//


struct Anchor {
    
    let id: Int
    var uid = 0
    var roomId = 0
    var type = 0
    var name = ""
    var isLive = false
    var push = 0
    var focus = 0
    var pic51 = ""
    var pic74 = ""
    var created: String = ""
    var modified: String?
    
    init() {
        id = 0
    }

}

extension Anchor: FieldMappable {
    
    init?(fields: [String: Any]) {
        
        if let fieldId = fields["id"] {
            id = Int(fieldId as! String)!
        } else {
            return nil
        }

        if let fieldUid = fields["uid"] {
            uid = Int(fieldUid as! String)!
        } else {
            return nil
        }

        if let fieldRoomId = fields["room_id"] {
            roomId = Int(fieldRoomId as! String)!
        } else {
            return nil
        }
        
        if let fieldType = fields["type"] {
            type = Int(fieldType as! String)!
        } else {
            return nil
        }
        
        if let fieldPush = fields["push"] {
            push = Int(fieldPush as! String)!
        } else {
            return nil
        }

        name = fields["name"] as? String ?? ""
        
        if let fieldIsLive = fields["is_live"] {
            isLive = Bool(fieldIsLive as! String) ?? false
        } else {
            isLive = false
        }
        
        if let fieldFocus = fields["focus"] {
            focus = Int(fieldFocus as! String)!
        } else {
            focus = 0
        }
        
        pic51 = fields["pic51"] as? String ?? ""
        pic74 = fields["pic51"] as? String ?? ""

        if let fieldCreated = fields["created"] as? String {
            created = fieldCreated
        } else {
            return nil
        }
        
        modified = fields["modified"] as? String
        
    }
    
}

extension Anchor: DictionaryConvertible {
    
    var dictionary: [String: Any] {
        var items = [String: Any]()
        
        items["id"] = id
        items["uid"] = uid
        items["roomId"] = roomId
        items["type"] = type
        items["name"] = name
        items["isLive"] = isLive
        items["focus"] = focus
        items["pic51"] = pic51
        items["pic74"] = pic74
        items["created"] = created

        if let modified = modified {
            items["modified"] = modified
        }
        
        return items
    }
}

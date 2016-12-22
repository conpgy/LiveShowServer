//
//  Anchor.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/22.
//
//


struct Anchor {
    
    let id: Int
    let uid: Int
    let roomId: Int
    let type: Int
    let name: String
    let isLive: Bool
    let focus: Int
    let pic51: String
    let pic74: String
    let created: Int?
    let modified: Int?

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

        if let fieldRoomId = fields["roomId"] {
            roomId = Int(fieldRoomId as! String)!
        } else {
            return nil
        }
        
        if let fieldType = fields["type"] {
            type = Int(fieldType as! String)!
        } else {
            return nil
        }

        name = fields["name"] as? String ?? ""
        
        if let fieldIsLive = fields["isLive"] {
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
            created = Int(fieldCreated)!
        } else {
            created = nil
        }
        
        if let fieldModified = fields["modified"] as? String {
            modified = Int(fieldModified)!
        } else {
            modified = nil
        }
        
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
        
        if let created = created {
            items["created"] = created
        }
        if let modified = modified {
            items["modified"] = modified
        }
        
        return items
    }
}

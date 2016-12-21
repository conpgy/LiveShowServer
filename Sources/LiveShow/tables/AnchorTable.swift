//
//  AnchorTable.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/21.
//
//

import SwiftKuery


final class AnchorTable: Table {
    
    let tableName = "tbl_anchor"
    
    let id = Column("id")
    let uid = Column("uid")
    let roomId = Column("room_id")
    let type = Column("type")
    let name = Column("name")
    let isLive = Column("is_live")
    let focus = Column("focus")
    let pic51 = Column("pic51")
    let pic74 = Column("pic74")
    let created = Column("created")
    let modified = Column("modified")
    
}

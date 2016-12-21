//
//  LiveUrlTable.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/21.
//
//

import SwiftKuery

final class LiveUrlTable: Table {
    
    let tableName = "tbl_live_url"
    
    let id = Column("id")
    let roomId = Column("room_id")
    let url = Column("url")
    let created = Column("created")
    
}

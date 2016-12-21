//
//  UserTable.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/21.
//
//

import SwiftKuery

final class UserTable: Table {
    
    let tableName = "tbl_user"
    
    let id = Column("id")
    let nickName = Column("nickname")
    let email = Column("email")
    let password = Column("password")
    let mobile = Column("mobile")
    let gender = Column("gender")
    let city = Column("city")
    let created = Column("created")
}

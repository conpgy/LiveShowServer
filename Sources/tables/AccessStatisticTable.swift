//
//  AccessStatisticTable.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/19.
//
//

import SwiftKuery

final class AccessStatisticTable: Table {
    
    let tableName = "tbl_access_statistic"
    
    let id = Column("id")
    let pv = Column("pv")
    
}

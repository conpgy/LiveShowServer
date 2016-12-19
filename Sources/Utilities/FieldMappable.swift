/**
 Copyright IBM Corporation 2016
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import SwiftKuery

public typealias Fields = [String: Any]

public protocol FieldMappable {

    init?( fields: Fields )

}

func resultToRows(resultSet: ResultSet) -> [Fields] {
    
    
    let t = resultSet.rows.map { zip(resultSet.titles, $0) }
   
    let y: [Fields] = t.map {
        var dicts = [String: Any]()
        
        $0.forEach {
            let (title, value) = $0
            dicts[title] = value
        }
        
        return dicts
    }
    
    return y
    
}

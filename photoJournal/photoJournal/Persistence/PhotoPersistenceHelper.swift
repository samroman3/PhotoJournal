//
//  SlothHelper.swift
//  sloth-app
//
//  Created by David Rifkin on 9/30/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct PhotoPersistenceHelper {
    
    private static var pictures = [Picture]()
    
    static let manager = PhotoPersistenceHelper()

    func save(newPhoto: Picture) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }

    func getPhoto() throws -> [Picture] {
        return try persistenceHelper.getObjects()
    }
    
    func delete(picArray: [Picture], index: Int) throws {
        return try persistenceHelper.deleteAtIndex(newArray: picArray, index: index)
        
}

    
    private let persistenceHelper = PersistenceHelper<Picture>(fileName: "journal.plist")

    private init() {}
}

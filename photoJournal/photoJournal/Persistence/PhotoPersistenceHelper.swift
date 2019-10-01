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
    
    static func delete(picArray: [Picture], index: Int) -> [Picture] {
        var newArr = picArray
        newArr.remove(at: index)
        return newArr
        
}

    
    private let persistenceHelper = PersistenceHelper<Picture>(fileName: "journal.plist")

    private init() {}
}

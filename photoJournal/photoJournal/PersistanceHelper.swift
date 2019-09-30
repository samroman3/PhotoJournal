//
//  PersistanceManager.swift
//  photoJournal
//
//  Created by Sam Roman on 9/30/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct PersistenceHelper<T: Codable> {
    func getObjects() throws -> [T] {
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }

    func save(newElement: T) throws {
        var elements = try getObjects()
        elements.append(newElement)
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }

    init(fileName: String) {
        self.fileName = fileName
    }

    private let fileName: String

    private var url: URL {
        return filePathFromDocumentsDirectory(filename: fileName)
    }

    private func documentsDirectory() -> URL {
       return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
     }

     private func filePathFromDocumentsDirectory(filename: String) -> URL {
       return documentsDirectory().appendingPathComponent(filename)
     }
}

struct PicturePersistenceHelper {
    static let manager = PicturePersistenceHelper()

    func save(newPicture: Picture) throws {
        try persistenceHelper.save(newElement: newPicture)
    }

    func getPictures() throws -> [Picture] {
        return try persistenceHelper.getObjects()
    }

    private let persistenceHelper = PersistenceHelper<Picture>(fileName: "pictures.plist")

    private init() {}
}

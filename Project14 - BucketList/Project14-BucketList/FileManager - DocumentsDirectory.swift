//
//  FileManager - DocumentsDirectory.swift
//  Project14-BucketList
//
//  Created by roberts.kursitis on 06/12/2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

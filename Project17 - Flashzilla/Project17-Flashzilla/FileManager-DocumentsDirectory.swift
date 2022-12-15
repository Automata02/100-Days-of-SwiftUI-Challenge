//
//  FileManager-DocumentsDirectory.swift
//  Project17-Flashzilla
//
//  Created by roberts.kursitis on 14/12/2022.
//

import Foundation
import SwiftUI

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

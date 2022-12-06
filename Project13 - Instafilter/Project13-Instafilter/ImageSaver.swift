//
//  ImageSaver.swift
//  Project13-Instafilter
//
//  Created by roberts.kursitis on 05/12/2022.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
        
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}

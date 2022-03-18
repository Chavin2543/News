//
//  CacheManager.swift
//  News
//
//  Created by chavin Panicharoen on 19/3/2565 BE.
//

import Foundation

class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveData(_ url:String,_ imageData:Data) {
            
        // Save the imageData aloong with the URL
        imageDictionary[url] = imageData
        
    }
    
    static func retrieveData(_ url:String) -> Data? {
        
        return imageDictionary[url]
        
    }
    
}

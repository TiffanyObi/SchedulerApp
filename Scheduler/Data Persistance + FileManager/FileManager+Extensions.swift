//
//  FileManager+Extensions.swift
//  Scheduler
//
//  Created by Tiffany Obi on 1/17/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

extension FileManager {
    
    //function get url path to documents directory
//     we access  its through FileManager.getDocumentsDirectory
    //this is a type method because we use it is on the type.
    
//    let fileManager = FileManager()
//    fileManager.getDocumentsDirectory - instance method.
    
    static func getDocumentsDirectory() -> URL {
//        first argument asks you what directory u want.
//        second argument is the users documments directory.
//        note that this gives us an array of urls and we only need one. and we use "0" because its the first and only one.
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
//   similar to doing - documents/schedule.plist "schedules.plist" in finder. 
    static func pathToDocumentsDirectory(with fileName: String) -> URL {
        
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
}

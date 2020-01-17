//
//  PersistenceHelper.swift
//  Scheduler
//
//  Created by Tiffany Obi on 1/17/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

enum DataPersistenceError: Error { //conforming too the Error protocol
    case savingError(Error) //associated value
    case fileDoesNotExsist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistenceHelper {
    
    //CRUD - create , read, update, delete
    
    
    
    // array of events
    private static var events = [Event]()
    
    // create a file name
    private static var fileName = "schedules.plist"
    
    
    
    //    MARK:- SAVING AN ITEM TO DOC. DIR.
    //create - save item
    static func save(event: Event) throws {
        //        get url path to the file that the Event will saved to
        events.append(event)
        
        //        events array will be object that is being converted to data. we wil then use that data object and write (save) it to documemts directory.
        
        //we'll start with a do/catch because it can throw an error
        do {
       try saveItem()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    private static func saveItem() throws {
        
        let url = FileManager.pathToDocumentsDirectory(with: fileName)
        
        do {
            
            let data = try PropertyListEncoder().encode(events)
            
            // atomic means write all at once
            try data.write(to: url,options: .atomic)
            
        } catch {
            
            throw DataPersistenceError.savingError(error)
        }
        
    }
    
    
    //     MARK:- RETRIEVING AN ITEM FROM Doc.Dir.
    //read - load item or retrieve items from documents directory
    static func loadevents() throws -> [Event]  {
        
        let url = FileManager.pathToDocumentsDirectory(with: fileName)
        
        //        check if file exsists
        //        to convert Url to string we use .path on URl
        if FileManager.default.fileExists(atPath: url.path) {
            
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    events = try PropertyListDecoder().decode([Event].self, from: data)
                } catch {
                    throw DataPersistenceError.decodingError(error)
                }
                
            } else {
                
                throw DataPersistenceError.noData
                
            }
        } else {
            
            throw DataPersistenceError.fileDoesNotExsist("file \"\(fileName)\" does not exist")
        }
        return events
    }
    
    
    
    
    
    //      MARK:-
    // update -
    
    
    //      MARK:-
    // delete - remove item from documents directory
    
    static func delete(event index: Int) throws {
        events.remove(at: index)
        
        
        // save out events arrat to the documents directory
        
        do {
            try saveItem()
        } catch {
        throw DataPersistenceError.deletingError(error)
        }
    }
}

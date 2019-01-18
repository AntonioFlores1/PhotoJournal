//
//  PhotoItem.swift
//  PhotoJournal
//
//  Created by Pursuit on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class PhotoModel {
    private static let fileName = "PhotoHolder.plist"
    private static var items = [Item]()

    static func getItems() -> [Item] {
        let path = DataPersistenceManager.filepathToDocumentDirectory(filename: fileName).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    items = try PropertyListDecoder().decode([Item].self, from: data)
                } catch {
                    print("Property list decoding erroe: \(error)")
                }
            } else {
                print("data is nil")
            }
        } else {
            print("\(fileName) doesn't exist")
        }
        items = items.sorted{$0.date < $1.date}
        return items
    }
    static func addItem(item: Item) {
        //Append to array of items
        items.append(item)
        save()
    }
    
    static func delete(item: Item, atIndex index: Int) {
        items.remove(at: index)
        save()
    }
    static func save() {
        // path
        let path = DataPersistenceManager.filepathToDocumentDirectory(filename: fileName)
        do {
            let data = try PropertyListEncoder().encode(items)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("Property list encoding error: \(error)")
        }
    }
    
}

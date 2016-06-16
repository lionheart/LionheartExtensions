//
//  Array.swift
//  Pods
//
//  Created by Daniel Loewenherz on 5/2/16.
//
//

import Foundation

public extension Array {
    func chunks(_ size: Int) -> AnyIterator<[Element]> {
        let indices = startIndex.stride(to: count, by: size)
        var generator = indices.makeIterator()

        return AnyIterator {
            if let i = generator.next() {
                let j = i.advancedBy(size, limit: self.endIndex)
                return self[i..<j].map { $0 }
            }

            return nil
        }
    }
}

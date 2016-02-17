//
//  NSURLSession.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/17/16.
//
//

import Foundation

public extension NSURLSession {
    func cancelAllTasks(completion: () -> Void) {
        getAllTasksWithCompletionHandler { tasks in
            for task in tasks {
                task.cancel()
            }
            
            completion()
        }
    }
}
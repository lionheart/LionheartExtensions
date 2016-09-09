//
//  Copyright 2016 Lionheart Software LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//

import Foundation

public func async(_ queue: DispatchQueue, delay: Double = 0, callback: @escaping (Void) -> Void) {
    if delay > 0 {
        queue.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(delay * Double(NSEC_PER_MSEC))) / Double(NSEC_PER_SEC)) {
            callback()
        }
    }
    else {
        queue.async {
            callback()
        }
    }
}

public func async_main(delay: Double = 0, callback: @escaping (Void) -> Void) {
    async(DispatchQueue.main, delay: delay) {
        callback()
    }
}

public func async_default(delay: Double = 0, callback: @escaping (Void) -> Void) {
    async(DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default), delay: delay) {
        callback()
    }
}

public func async_background(delay: Double = 0, callback: @escaping (Void) -> Void) {
    async(DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background), delay: delay) {
        callback()
    }
}

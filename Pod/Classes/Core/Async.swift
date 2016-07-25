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

public func async(queue: dispatch_queue_t, delay: Double = 0, callback: Void -> Void) {
    if delay > 0 {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(delay * Double(NSEC_PER_MSEC))), queue) {
            callback()
        }
    }
    else {
        dispatch_async(queue) {
            callback()
        }
    }
}

public func async_main(delay delay: Double = 0, callback: Void -> Void) {
    async(dispatch_get_main_queue(), delay: delay) {
        callback()
    }
}

public func async_default(delay delay: Double = 0, callback: Void -> Void) {
    async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), delay: delay) {
        callback()
    }
}

public func async_background(delay delay: Double = 0, callback: Void -> Void) {
    async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), delay: delay) {
        callback()
    }
}

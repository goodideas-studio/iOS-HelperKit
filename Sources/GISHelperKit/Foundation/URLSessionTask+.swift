//
//  URLSessionTask+.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/11/10.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation
import Weak

extension URLSessionTask {

    /// Store  the task in set, in order to foreach to cancel
    /// - Parameter set: mutatable set to store Task
   public func store(in container: TaskContainer) {
    container.add(task: self)
    }
}

open
class TaskContainer {
	public
	typealias TaskList = Array<Weak<URLSessionTask>>
	public var taskList: TaskList = []
    public init() {}

    public func add(task: URLSessionTask) {
        let weak = Weak(task)
        taskList.append(weak)
    }

    public func cancelAll() {
        taskList.forEach { $0.object?.cancel() }
        taskList.removeAll()
    }

    deinit {
        taskList.forEach { $0.object?.cancel() }
    }
}

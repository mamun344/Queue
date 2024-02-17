//
//  main.swift
//  DSA Queue
//
//  Created by Mamun on 17/2/24.
//

import Foundation


func block(_ title: String, execution: ()->()){
    print("\n --- \(title) ---")
    execution()
}


protocol Queue {
    associatedtype Element
        
    mutating func enqueue(_ element: Element)
    
    mutating func dequeue()->Element?
    
    var isEmpty: Bool { get }
    
    var peek: Element? { get }
}


struct QueueArray<T>: Queue {
   private var array: [T] = []
    
    init(){ }
        
    var isEmpty: Bool { array.isEmpty }
    
    var peek: T? { array.first }
    
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    mutating func dequeue()->T? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    var description: String {
        "--- queue start ---\n" + array.map { "\($0)" }.joined(separator: " -> ") + "\n--- queue end ---"
    }
}

var queue = QueueArray<Int>()
queue.enqueue(5)
queue.enqueue(7)
queue.enqueue(9)
queue.enqueue(11)

print(queue.description)
print(queue.peek)

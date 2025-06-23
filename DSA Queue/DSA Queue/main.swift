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
        
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var peek: T? {
        array.first
    }
    
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    @discardableResult
    mutating func dequeue()->T? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    var description: String {
        "Queue : " + array.map { "\($0)" }.joined(separator: " -> ")
    }
}



struct QueueStack<T>: Queue {
   private var leftStack: [T] = [] //actually an array
    private var rightStack: [T] = []//actually an array

    init(){ }
        
    var isEmpty: Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }
    
    var peek: T? { 
        leftStack.isEmpty ? rightStack.first : leftStack.last
    }
    
    mutating func enqueue(_ element: T) {
        rightStack.append(element)
    }
    
    @discardableResult
    mutating func dequeue()->T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        
        return leftStack.popLast()
    }
}

extension QueueStack: CustomStringConvertible {
    var description: String {
        "Queue : " + (leftStack.reversed() + rightStack).map { "\($0)" }.joined(separator: " -> ")
    }
}


//https://www.javatpoint.com/circular-queue

struct QueueRing<T>: Queue {
    private var items: [T?]
    private var headIndex = -1
    private var tailIndex = -1
    private let size: Int
    
    init(size: Int) {
        self.size = size
        self.items = [T?](repeating: nil, count: size)
    }
    
    mutating func enqueue(_ item: T) {
        guard isFull == false else {
            print("Queue is Full")
            return
        }
        
        if isEmpty {
            headIndex = 0
            tailIndex = 0
        }
        else {
            tailIndex = (tailIndex + 1) % size
        }
        
        items[tailIndex] = item
    }
    
    @discardableResult
    mutating func dequeue()->T? {
        guard isEmpty == false else {
            print("Queue is Empty")
            return nil
        }
        
        let item = items[headIndex]
        
        if headIndex == tailIndex { // all items dequed just now. Reset the queue
            headIndex = -1
            tailIndex = -1
        }
        else {
            headIndex = (headIndex + 1) % size
        }
        
        return item
    }
    
    var isEmpty: Bool {
        headIndex == -1
    }
    
    var isFull: Bool {
        (tailIndex+1)%size == headIndex
    }
    
    var peek: T? {
        isEmpty ? nil : items[headIndex]
    }
}


extension QueueRing: CustomStringConvertible {
    var description: String {
        "Queue : " + items.map { $0 == nil ? "nil" : "\($0!)" }.joined(separator: " -> ") + "\nEmpty: \(isEmpty)\tFull: \(isFull)\n" + "Head: \(headIndex)\tTail: \(tailIndex)\n"
    }
}


block("With Ring") {
    var ring = QueueRing<Int>(size: 5)
    print(ring)
    
    ring.enqueue(10)
    print(ring)
    
    ring.enqueue(20)
    print(ring)

    ring.enqueue(30)
    print(ring)

    ring.enqueue(40)
    print(ring)
    
    print(ring.enqueue(50))
    print(ring)
    
    print(String(describing: ring.dequeue())) //10
    print(ring)
    
    print(String(describing: ring.dequeue())) //20
    print(ring)
    
    ring.enqueue(60)
    print(ring)
    
    ring.enqueue(70)
    print(ring)
    
    ring.enqueue(80)
    print(ring)

    /*
    ring.enqueue(123)
    print(ring)
    
    ring.enqueue(456)
    print(ring)

    ring.enqueue(789)
    print(ring)

    ring.enqueue(666)
    print(ring)
    
    print(ring.enqueue(100))
    print(ring)
    
    print(ring.enqueue(110))
    print(ring)

    print(String(describing: ring.dequeue()))   // 123
    print(ring)
    
    print(String(describing: ring.dequeue()))   // 456
    print(ring)
    
               
    print(String(describing: ring.dequeue()))   // 789
    print(ring)
    
    print(String(describing: ring.dequeue()))   // 666
    print(ring)
    
    print(String(describing: ring.dequeue()))   // 100
    print(ring)
    
                     
    print(String(describing: ring.enqueue(333)))
    print(ring)
                          
    print(ring.enqueue(555))
    print(ring)
                                
    print(String(describing: ring.dequeue()))   // 666
    print(ring)
                                        
    print(String(describing: ring.dequeue()))   // 333
    print(ring)
                                             
    print(String(describing: ring.dequeue()))   // 555
    print(ring)
                                                    
    print(String(describing: ring.dequeue()))   // nil
    print(ring)
    */
}


block("With Array") {
    var queue = QueueArray<Int>()
    queue.enqueue(5)
    queue.enqueue(7)
    queue.enqueue(9)
    queue.enqueue(11)

    queue.dequeue()
//  queue.dequeue()

    print(queue.description)
    print(queue.peek)
}


block("With Stack") {
    var queue = QueueStack<Int>()
    queue.enqueue(5)
    queue.enqueue(7)
    queue.enqueue(9)
    queue.enqueue(11)

    queue.dequeue()
//    queue.dequeue()

    print(queue.description)
    print(queue.peek)
}


block("Reverse A Queue") {
    
    var queue = QueueArray<Int>()
    queue.enqueue(5)
    queue.enqueue(10)
    queue.enqueue(15)
    queue.enqueue(20)
    queue.enqueue(25)
    
    print(queue)

    var array = [Int]()

    
    while let item = queue.dequeue() {
        array.append(item)
    }
    
    while let item = array.popLast() {
        queue.enqueue(item)
    }

    print(queue)
}




public struct Heap<Elemnent: Equatable>{
    public var elements: [Elemnent] = []
    
    public let sort: (Elemnent, Elemnent) -> Bool
    // > : 최대힙 , < : 최소힙
    public init(sort: @escaping (Elemnent, Elemnent) -> Bool, elements: [Elemnent] = []){
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty{
            for i in stride(from: elements.count/2 - 1, through: 0, by: -1){
                print("부모 노드 \(i)초기화")
                sink(from: i)
            }
        }
        print("heap 구조 정렬 완료!")
    }
    
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public var count : Int{
        return elements.count
    }
    
    public func peek() ->Elemnent?{
        return elements.first
    }
    
    func leftChildIndex(ofParent Index: Int) -> Int{
        return (Index*2) + 1
    }
    
    func rightChildIndex(ofParent Index: Int) -> Int{
        return (Index*2) + 2
    }
    
    func parentIndex(ofChild Index: Int) -> Int{
        return (Index - 1) / 2
    }
    
    public mutating func remove() -> Elemnent?{
        guard !isEmpty else{
            return nil
        }
        print("루트 노드와 맨마지막 노드의 위치를 바꿈")
        elements.swapAt(0, count - 1)
        print("위치바꿈 완룍")
        
        defer {
            print("sink를 호출해서 반환 후 힙을 다시 재정렬함")
            sink(from: 0)
        }
        
        return elements.removeLast()
        
        
        
    }
    
    
    public mutating func sink(from index: Int){
        // 파라미터롤 받아온 index를 기준으로 점점 아래로 내려가면서 정력하는것
        var parent = index
        print("index: \(index), parent:\(parent), element: \(elements)")
        
        while true {
            let left = leftChildIndex(ofParent: parent)
            let right = rightChildIndex(ofParent: parent)
            print("현재 노드의 lett: \(left), right: \(right)")
            // 정렬의 기준이 되는 후보자에 부모노드 추가!
            var candidate = parent
            
            if left < count && sort(elements[left], elements[candidate]){
                // 왼쪽 자식이 부모 노드를 비교
                candidate = left
            }
            if right < count && sort(elements[right], elements[candidate]){
                // 오른쪽 자식과 부모 노드를 비교
                candidate = right
            }
            if candidate == parent{
                return
            }
            
            elements.swapAt(parent, candidate)
            parent = candidate
    
        }
    }
    
    public mutating func swim(from index : Int){
        // 파라미터롤 받은 index를 자식노드로 삼은뒤 그것을 기준으로
        // 점점 위로 올라가면서 정렬를 하는 로직이다
        var child = index
        var parent = parentIndex(ofChild: child)
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChild: child)
        }
        
    }
    
    public mutating func insert(_ element: Elemnent){
        elements.append(element)
        swim(from: elements.count - 1)
    }
    
    public mutating func remove(at index : Int) -> Elemnent?{
        guard index < elements.count else {
            return nil
        }
        if index == elements.count - 1{
            return elements.removeLast()
        } else{
            elements.swapAt(index, elements.count - 1)
            
            defer{
                sink(from: index)
                swim(from: index)
            }
            
            return elements.removeLast()
            
        }
    }
}



public struct PriorityQueue<Element: Equatable>{
    // 힙 구조를 이용해서 큐를 만드는것이다
    private var heap: Heap<Element>
    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []){
        heap = Heap<Element>(sort: sort , elements: elements)
    }
    
    public var isEmpty: Bool{
        return heap.isEmpty
    }
    
    public var peek: Element?{
        return heap.peek()
    }
    
    public mutating func enqueue(_ element: Element) -> Bool{
        heap.insert(element)
        return true
    }
    
    public mutating func dequeue()-> Bool{
        heap.remove()
        return true
    }
    
}



var priorityQueue = PriorityQueue<Int>(sort: <, elements: [10,22,3,1,44])



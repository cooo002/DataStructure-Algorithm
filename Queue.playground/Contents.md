# 큐 구현  

```
public struct Queue<T>{
    private var data = [T]()
    
    public init(){}
    
    public mutating func dequeue() -> T?{
        return self.data.removeFirst()
        
    }
    
    public mutating func peek() -> T? {
        return self.data.first
    }
    
    public mutating func enqueue(element : T){
        self.data.append(element)
    }
    
    public mutating func clear(){
        self.data.removeAll()
    }
    
    public var count : Int{
        return self.data.count
    }
    
    public var capacity : Int{
        get{
        return self.data.capacity
    }
        set
        {
            self.data.reserveCapacity(newValue)
        }
    
    }
    public func isFull() -> Bool{
        if  data.count == data.capacity{
            return true
        }
        else{
            return false
        }
    }
    
    public func isEmpty() -> Bool {
        return data.isEmpty
    }
}
```
    

var queueEx = Queue<Int>()

queueEx.enqueue(element: 10)
queueEx.enqueue(element: 3)
queueEx.enqueue(element: 4)
queueEx.enqueue(element: 6)

queueEx.peek()






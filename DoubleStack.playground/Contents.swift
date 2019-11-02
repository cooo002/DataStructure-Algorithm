public struct QueueDoubleStack<T>{
    private var leftStack = Array<T>()//enqueue를 담당하는 왼쪽 스택
    private var rightStack = Array<T>()//dequeue를 담당하는 오른쪽 스택
    
    public mutating func enQueue(_ element: T )-> Bool{
        // enQueue 스택에 데이터르를 추각하는 로직이다!
        leftStack.append(element)
        return true
    }
    
    public mutating func deQueue() -> T?{
        if rightStack.isEmpty{
            // dequeue스택이 비어있다면 enqueue스택에서 역순으로 값을 가져와서 저장하고
            // dequeue 스택이 차있다면 이 조건문은 실행되지 않는다!
            rightStack = leftStack.reversed()
            // enqueue 스택에서 역순으로 뽑아오는 과정이다
            leftStack.removeAll()
            //enqueue스택은 값이 dequeue스택에 저장된고 나면 기존에 가지고 있던
            //데이터는 모두 삭제하고 새로운 데이터를 받아들일 준비를 한다
            
        }
        return rightStack.popLast()
        
    }
    
    public var isEmpty: Bool{
        return leftStack.isEmpty && rightStack.isEmpty
    }
}

extension QueueDoubleStack: CustomStringConvertible{
    public var description: String {
        return "enQueue스택: " + String(describing: leftStack) + "\ndeQueue스택: " + String(describing: rightStack)
    }
    
    
}

var doublestack = QueueDoubleStack<Int>()

doublestack.enQueue(10)
doublestack.enQueue(2)
doublestack.enQueue(4)
doublestack.enQueue(5)
print(doublestack)


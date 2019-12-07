//Todo:  init BST

public class BinayTreeNode<T: Comparable>{
    public var value:T
    public var leftChild:BinayTreeNode?
    public var rightChild:BinayTreeNode?
    public weak var parent:BinayTreeNode?

    //Initialization
    public convenience init(value: T) {
        self.init(value: value, left: nil, right: nil, parent:nil)
    }

    public init(value:T, left:BinayTreeNode?, right:BinayTreeNode?, parent:BinayTreeNode?) {
        self.value = value
        self.leftChild = left
        self.rightChild = right
        self.parent = parent
    }

    public func inserNodeFromRoot(value:T) {
        //To mantain the binary search tree property, we must ensure that we run the insertNode process from the root node
        if let _ = self.parent {
            // If parent exists, it is not the root node of the tree
            print("You can only add new nodes from the root node of the tree");
            return
        }
        self.addNode(value: value)
    }

//    check: BTS에 값을 추가할 때 무조건 inserNodeFromRoot로 추가할 수 있게 해주기 위해 여기서 addNode는
//     접근지정자를 prvate설정해준다!
    private func addNode(value: T){
        if value < self.value{
            // todo: 추가하려는값이 현재 노드의 value 보다 작은 경우 실행되는 로직이다!
            if let leftChild = leftChild{
                //todo: 현재 왼쪽자식노드가 있는 경우 해당 자식노드에세 현재 value를 추가하는 로직이다!
                leftChild.addNode(value: value)
            }else{
                //todo: 현재 노드에 자식노드가 없느 경우 실행되는 로직이다!
                let newNode = BinayTreeNode(value: value)
                newNode.parent = self
                leftChild = newNode
            }
        }else{
            //todo: 현재 추가되는 데이터가 노드가 가지고 있는 데이터 보다 큰 경우 실행되는 로직이다!
            if let rightChild = rightChild{
                rightChild.addNode(value: value)
            }else{
                let newNode = BinayTreeNode(value: value)
                newNode.parent = self
                rightChild = newNode
            }
        }
    }


    public class func traverseInOrder(node: BinayTreeNode?){
        // todo: 이진검색트리를 전부 순회하면셔 트리 내부에 있는 데이터를 전부 오름차순으로 뽄아주는 로직을 실행한다.
        guard let node = node else {
            return
        }
        
        BinayTreeNode.traverseInOrder(node: node.leftChild)
        print(node.value)
        BinayTreeNode.traverseInOrder(node: node.rightChild)
    }

    
    public class func traversePreOrder(node:BinayTreeNode?){
//      todo: 루트 노드 -> 죄측 자식노드 -> 우측 자식 노드 순으로 출력하는것이다
        
        guard let node = node else {
            return
        }
        
        
        print(node.value)
        BinayTreeNode.traversePreOrder(node: node.leftChild)
        BinayTreeNode.traversePreOrder(node: node.rightChild)
    }

    public class func traversePostOrder(node:BinayTreeNode?){
//        todo: 좌측 -> 우측 -> 루트 순으로 순회하는 메소드이다!
        guard let node = node else {
            return
        }
        BinayTreeNode.traversePostOrder(node: node.leftChild)
        BinayTreeNode.traversePostOrder(node: node.rightChild)
        print(node.value)
        
    }
    
//    todo: BST에서 특정 데이터를 가지고 있다면 그 값을 검색하는 로직이다!
    public func search(value: T) -> BinayTreeNode?{
        if value == self.value{
//            todo: 검색하려는 값을 찾은 경우이다!!
            return self
        }
        
        if value < self.value{
            guard let left = leftChild else {
                return nil
            }
            return left.search(value: value)
        }
        else{
            guard let right = rightChild else {
                return nil
            }
            return right.search(value: value)
        }
    }

    public func delete(){
        // todo:루트노드와 직접적으로 연결된 노드만 삭제하느 로직이다!!
        // 검색을 통해 특정 값을 삭제하는 로직을 만들고싶다면 내가 해당 로직을 수행하는
        // 메소드를 직접 만들어주자!
        if let left = leftChild{
            if let _ = rightChild{
                //todo: 왼쪽,오른쪽 둘 다 자식노드를 가지고있느 경우 실행되는 로직이다!
                self.exchangeWithSuccerssor()
            }else{
                //todo: 왼쪽 자식 노드를 가지고 있는 경우에 실행되는 로직이다!
                self.connectParentTo(child: left)
            }
        }else if let right = rightChild{
            // todo: 오른쪽 자식 노드만 가지고 있는 경우에 실행되는 로직이다!
            self.connectParentTo(child: right)
        }else{
//           todo: 자식노드가 아예 없는 경우에 실행되는 로직이다!
            self.connectParentTo(child: nil)
        }

        //삭제하려는 노드를 BST에서 아예 없애주기 위해 참조를 다 끊어주는 로직이다!(어차피 참조로 이어져있기 때문에 그냥
//         참조 자체를 끊어주면 트리에서 삭제되는 것이다!)
        self.parent = nil
        self.leftChild = nil
        self.rightChild = nil
    }

    private func exchangeWithSuccerssor(){
        guard let right = self.rightChild, let left = self.leftChild else {
                return
        }
        let succerssor = right.minimum()
        succerssor.delete()

        succerssor.leftChild = left
        left.parent = succerssor

        if right !== succerssor{
            succerssor.rightChild = right
            right.parent = succerssor
        }else{
            succerssor.rightChild = nil
        }
        self.connectParentTo(child: succerssor)
    }

    private func connectParentTo(child: BinayTreeNode?){
        guard let parent = self.parent else {
            child?.parent = self.parent
            return
        }
        if parent.leftChild === self{
            parent.leftChild = child
            child?.parent = parent
        }
        else if parent.rightChild === self{
            parent.rightChild = child
            child?.parent = parent
        }
    }

    public func minimum() -> BinayTreeNode{
        if let left = leftChild{
            return left.minimum()
        }else{
            return self
        }
    }

}



var node = BinayTreeNode(value: 90)
node.inserNodeFromRoot(value: 33)
node.inserNodeFromRoot(value: 123)
node.inserNodeFromRoot(value: 3322)
node.inserNodeFromRoot(value: 331)
node.inserNodeFromRoot(value: 1)
node.inserNodeFromRoot(value: 3)

BinayTreeNode.traverseInOrder(node:node)



var result = node.search(value: 123)
node.leftChild?.delete()
//result: 루트노드의 왼쪽노드가 삭제된다!!

print(result?.value)

BinayTreeNode.traverseInOrder(node:node)




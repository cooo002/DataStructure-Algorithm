
var a = [10,2,3,21, 4]
public func insrtionSort<t: Comparable>(_ list: inout [t]){
    if list.count <= 1{
        return
    }
    
    for i in 1..<list.count{
        let x = list[i] // 정렬의 기준이 되는 요소!
        var j = i
        while j > 0 && list[j - 1] > x {
            list[j] = list[j - 1]
            j -= 1
        }
        list[j] = x
    }
    print(list)
    
}


insrtionSort(&a)


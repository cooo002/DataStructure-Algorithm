//note: 병합 알고리즘(array로 구현하기 )
//BaseCase 까지 나누고 그 다음 merge 하자!!
func mergeSort<T: Comparable>(_ array: [T]) -> [T]{
    // 일단 탈츨조건을 만들자
    guard array.count > 1 else {
        // note: 크기가 1이라면 굳이 정렬을 할 필요가 없다!
        return array
    }
    let middleIndex = array.count / 2
    
    let leftArray = mergeSort(Array(array[0..<middleIndex]))
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
    
    return merge(leftArray, rightArray)
}


func merge<T: Comparable>( _ left: [T], _ right: [T]) -> [T]{
    // note: 왼쪽과 오른쪽 2개의 배열을 받아와서 이 두개를 병합하는 로직을 작섬할 것이다
    var leftIndex = 0
    var rightIndex = 0
    
    var orderedArr:[T] = []
    while leftIndex < left.count && rightIndex < right.count {
        
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]
        //note: 해당 인덱스에 속하는 데이터를 저장해두는 것이다 이렇게 하지 않으면 조건문에 들어가서
        // left[leftIndex] 와 같이 일일히 적어줘야한다.
        if leftElement < rightElement{
            orderedArr.append(leftElement)
            leftIndex += 1
        }
        else if leftElement > rightElement{
            orderedArr.append(rightElement)
            rightIndex += 1
        }
        else{
            //note: 비교하는 두 값이 같은 경우에 실행되는 로직이다 .
            orderedArr.append(leftElement)
            leftIndex += 1
            orderedArr.append(rightElement)
            rightIndex += 1
        }
    }
    
    while leftIndex < left.count {
        orderedArr.append(left[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < right.count {
        orderedArr.append(right[rightIndex])
        rightIndex += 1
    }
    
    return orderedArr
    
}

var testArr = [33,4,1,44,13]

var result = mergeSort(testArr)

print(result)




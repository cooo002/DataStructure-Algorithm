func quicksort<T: Comparable>(_ a: [T]) -> [T]{
    if a.count < 1 {
        return a
    }
    
    let pivot = a[a.count / 2]
    let less = a.filter{$0 < pivot}
    let equal = a.filter{$0 == pivot}
    let greater = a.filter{$0 > pivot}
    
    return quicksort(less) + equal + quicksort(greater)
    
}

var arr = [33,56,11,43,1,36]

var result = quicksort(arr)

print(result)

//
//  main.swift
//  l2_AntonMakhankov
//
//  Created by Anton Makhankov on 02/03/2019.
//  Copyright © 2019 Anton Makhankov. All rights reserved.
//

import Foundation


// 1. Написать функцию, которая определяет, четное число или нет.

func evenOdd(_ number : Int) -> Bool {
    if number % 2 == 0 {
        return true
    } else {
        return false
    }
}

print("1. Введите число, чтобы проверить его на чет/нечет")
var number = Int(readLine()!)
if evenOdd(number!) {
    print("Введенное число четное")
} else {
    print("Введенное число нечетное")
}

// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func divisionThree(_ number2 : Int) -> Bool {
    if number2 % 3 == 0 {
        return true
    } else {
        return false
    }
}

print("2. Введите число, чтобы проверить, делится ли оно на 3")
var number2 = Int(readLine()!)
if divisionThree(number2!) {
    print("Введенное число делится на 3 без остатка")
} else {
    print("Введенное число делится на 3 с остатком")
}

// 3. Создать возрастающий массив из 100 чисел.

print("3. Создать возрастающий массив из 100 чисел")
var firstArray : Array<Int> = []
for i in 1...100 {
    firstArray.append(i)
}
print(firstArray)

// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

print("4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3")
firstArray.removeAll(where: {evenOdd($0) || divisionThree($0)})

print(firstArray)

// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.

print("5. Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов")
func fibonacci(array : Array<UInt>) -> UInt {
    if(array.count >= 2) {
        return array[array.count - 1] + array[array.count - 2]
    } else if(array.count == 1){
        return 1
    } else {
        return 0
    }
}

var secondArray : Array<UInt> = []
for _ in 1...94 {
    secondArray.append(fibonacci(array: secondArray))
}

print(secondArray)

// 6. * Заполнить массив из 100 элементов различными простыми числами.

print("6. Заполнить массив из 100 элементов различными простыми числами.")
func naturalNumbers(_ array : Array<UInt>) -> UInt {
    if(array.count > 0) {
        var i : UInt = array[array.count-1]
        repeat { i += 1 } while (i%2 == 0 && i != 2) || (i%3 == 0 && i != 3) || (i%4 == 0 && i != 4) || (i%5 == 0 && i != 5) || (i%6 == 0 && i != 6) || (i%7 == 0 && i != 7) || (i%8 == 0 && i != 8) || (i%9 == 0 && i != 9)
        return i
    } else {
        return 2
    }
    
}

var thirdArray : Array<UInt> = []
for _ in 1...100 {
    thirdArray.append(naturalNumbers(thirdArray))
}
print(thirdArray)

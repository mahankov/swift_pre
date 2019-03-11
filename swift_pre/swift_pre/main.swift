//
//  main.swift
//  swift_pre
//
//  Created by Anton Makhankov on 02/03/2019.
//  Copyright © 2019 Anton Makhankov. All rights reserved.
//

import Foundation


print("1. Решить квадратное уравнение. (15 − 2x − x2 = 0)")

let a : Int = -1
let b : Int = -2
let c : Int = 15

var d : Int = (b * b - 4 * a * c)

var result1 : Double
var result2 : Double

if d < 0 {
    print("У данного уровнения нет корней")
} else if d == 0 {
    print("У данного уровнения 1 корень")
    result1 = (-Double(b) + sqrt(Double(d))) / 2 * Double(a)
    print("X = "+String(result1))
} else {
    print("У данного уровнения 2 корня")
    result1 = (-Double(b) + sqrt(Double(d))) / 2 * Double(a)
    result2 = (-Double(b) - sqrt(Double(d))) / 2 * Double(a)
    print("X1 = "+String(result1))
    print("X2 = "+String(result2))
}

print("---")
print("2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.")

let trA : Float = 10
let trB : Float = 15

var trG : Float

trG = sqrt(trA * trA + trB * trB)

print("Площадь треугольника равна "+String((trA + trB) / 2))
print("Гипотенуза треугольника равна "+String(trG))
print("Периметр треугольника равен "+String(trA + trB + trG))

print("---")
print("3. Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.")

var sum : Float = 10000
let percent : Float = 10
let time : Int = 5

for _ in 1...time {
    sum += sum / 100 * percent
}
print("Сумма вклада через 5 лет составит "+String(sum)+" руб")

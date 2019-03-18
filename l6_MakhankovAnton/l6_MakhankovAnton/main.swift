//
//  main.swift
//  l6_MakhankovAnton
//
//  Created by Anton Makhankov on 18/03/2019.
//  Copyright © 2019 Anton Makhankov. All rights reserved.
//

import Foundation

/*
 
 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
 
 */

enum Gender {
    case male
    case female
}

protocol Identy {
    var name: String { get set }
    var gender: Gender { get set }
    var age: Int { get set }
}

class Person:Identy {
    var name: String
    var gender: Gender
    var age: Int
    init(name: String, gender: Gender, age: Int) {
        self.name = name
        self.gender = gender
        self.age = age
    }
}

struct Queue<T:Identy> {
    private var people: [T] = []
    mutating func new(_ person: T) {
        people.append(person)
    }
    mutating func next() {
        if people.count > 0 {
            print("Сейчас проходит на прием \(people[0].name)")
            people.removeFirst()
        }
    }
    func children() {
        if people.count > 0 {
            let children = people.filter({$0.age < 18})
            for child in children {
                print("\(child.name), возраст: \(child.age)")
            }
        } else {
            print("В очереди нет детей")
        }
    }
    subscript(position:Int) -> T? {
        if position >= 0 && position < people.count {
            return people[position]
        } else {
            return nil
        }
    }
}

var hospital = Queue<Person>()

hospital.new(Person(name: "Антон", gender: .male,   age: 32))
hospital.new(Person(name: "Яна",  gender: .female, age: 27))
hospital.new(Person(name: "Марк",  gender: .male,   age: 1))

hospital.next()
hospital.children()

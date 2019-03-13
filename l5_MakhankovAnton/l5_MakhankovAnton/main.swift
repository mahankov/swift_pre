//
//  main.swift
//  l5_MakhankovAnton
//
//  Created by Anton Makhankov on 12/03/2019.
//  Copyright © 2019 Anton Makhankov. All rights reserved.
//

import Foundation

/*

 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести сами объекты в консоль.
 
*/



enum CarTypes {
    case compact
    case crossover
    case minivans
    case luxury
    case sportCar
    case offRoaders
    case commercial
}

enum Doors {
    case driver
    case frontRight
    case rearLeft
    case rearRight
}

protocol Car {
    var mark: String { get }
    var model: String { get }
    var type: CarTypes { get }
    var engine: Bool { get }
    var windows: Bool { get }
    var trunk: Bool { get }
    var doors: [Bool] { get }
    func door(_ door: Doors)
}

extension Car {
    func engine() {}
    func windows() {}
    func trunk() {}
}

class TrunkCar: Car {
    var mark: String
    var model: String
    var type: CarTypes
    var engine: Bool
    var windows: Bool
    var trunk: Bool
    var doors: [Bool]
    init(mark: String, model: String, type: CarTypes) {
        self.mark = mark
        self.model = model
        self.type = type
        self.engine = false
        self.windows = false
        self.trunk = false
        self.doors = [false,false,false,false]
    }
    func door(_ door: Doors) {
        switch door {
            case .driver:
                self.doors[0] = self.doors[0] ? false : true
            case .frontRight:
                self.doors[1] = self.doors[1] ? false : true
            case .rearLeft:
                self.doors[2] = self.doors[2] ? false : true
            case .rearRight:
                self.doors[3] = self.doors[3] ? false : true
        }
    }
}

class SportСar: Car {
    var mark: String
    var model: String
    var type: CarTypes
    var engine: Bool
    var windows: Bool
    var trunk: Bool
    var doors: [Bool]
    init(mark: String, model: String, type: CarTypes) {
        self.mark = mark
        self.model = model
        self.type = type
        self.engine = false
        self.windows = false
        self.trunk = false
        self.doors = [false,false,false,false]
    }
    func door(_ door: Doors) {
        switch door {
        case .driver:
            self.doors[0] = self.doors[0] ? false : true
        case .frontRight:
            self.doors[1] = self.doors[1] ? false : true
        case .rearLeft:
            self.doors[2] = self.doors[2] ? false : true
        case .rearRight:
            self.doors[3] = self.doors[3] ? false : true
        }
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "\(mark) \(model) (\(type))"
    }
}

extension SportСar: CustomStringConvertible {
    var description: String {
        return "\(mark) \(model) (\(type))"
    }
}

var bugatti = SportСar(mark: "Bugatti", model: "Veyron", type: .sportCar)
var kamaz = TrunkCar(mark: "Kamaz", model: "A123", type: .commercial)

print(bugatti)
print(kamaz)

 



/*

protocol CarIdentificator { // Идентификация автомобиля по марке и модели
    var mark: String { get }
    var model: String { get }
    var vin: Int { get }
}

protocol CarUnits {
    var engineStatus: Bool { get }
    var windowsStatus: [Bool] { get }
    var doorsStatus: [Bool] { get }
}

protocol CarAlarmSystem {
    var hasAlarm: Bool { get }
    var alarmSerial: Int? { get }
    var alarmStatus: Bool? { get }
    func alarm(_ serial: Int)
}

protocol CarActions {
    func engine()
    func windows(_ side: CarSides)
    func doors(_ side: CarSides)
}

enum CarSides: Int {
    case frontLeft
    case frontRight
    case rearLeft
    case rearRight
}

class Car: CarIdentificator, CarActions, CarUnits, CarAlarmSystem {
    static var vinCur: Int = 100000000
    static var count: Int = 0
    var mark: String
    var model: String
    var vin: Int
    var hasAlarm: Bool
    var alarmSerial: Int?
    var alarmStatus: Bool?
    var engineStatus: Bool
    var doorsStatus: [Bool]
    var windowsStatus: [Bool]
    
    init(mark: String, model: String, hasAlarm: Bool) {
        Car.vinCur += 1
        Car.count += 1
        self.mark = mark
        self.model = model
        self.vin = Car.vinCur
        self.hasAlarm = hasAlarm
        if hasAlarm {
            self.alarmStatus = true
            self.alarmSerial = Int.random(in: 1000000..<9999999)
        }
        self.engineStatus = false
        self.windowsStatus = [Bool](repeating: false, count: 4)
        self.doorsStatus = [Bool](repeating: false, count: 4)
        print("Вы купили автомобиль \(mark) \(model) (VIN \(vin))")
        if hasAlarm {
            print("Серийный номер сигнализации: \(alarmSerial!). Используйте его для постановки/снятия автомобиля с охраны")
        }
    }
    
    func engine() {
        if engineStatus {
            engineStatus = false
            print("Двигатель заглушен")
        } else {
            engineStatus = true
            print("Двигатель запущен")
        }
    }
    
    func windows(_ side: CarSides) {
        if !alarmStatus! {
            windowsStatus[side.rawValue] = windowsStatus[side.rawValue] ? false : true
        } else {
            print("Невозможно управлять окнами, пока автомобиль стоит на сигнализации")
        }
    }
    
    func doors(_ side: CarSides) {
        if !alarmStatus! {
            doorsStatus[side.rawValue] = doorsStatus[side.rawValue] ? false : true
        } else {
            if doorsStatus[side.rawValue] {
                doorsStatus[side.rawValue] = false
            } else {
                print("Невозможно открыть дверь, пока автомобиль стоит на сигнализации")
            }
        }
    }
    
    func alarm(_ serial: Int) {
        if hasAlarm {
            if serial == alarmSerial {
                if alarmStatus! {
                    alarmStatus = false
                } else {
                    if doorsStatus.contains(true) {
                        print("Невозможно поставить на охрану:")
                        for i in 0..<doorsStatus.count {
                            if doorsStatus[i] {
                                print("У вас не закрыта дверь (\(CarSides.init(rawValue: i)!))")
                            }
                        }
                    } else {
                        for i in 0..<windowsStatus.count {
                            windowsStatus[i] = true
                        }
                        alarmStatus = true
                    }
                }
            }
        } else {
            print("На вашем автомобиле нет сигнализации")
        }
    }
    func info() {
        print("Ваш автомобиль: \(mark) \(model)")
    }
    
    func status() {
        if hasAlarm {
            if alarmStatus! {
                print("Ваш автомобиль стоит на охране")
            } else {
                print("Ваш автомобиль снят с охраны")
            }
        } else {
            print("На вашем автомобиле нет сигнализации")
        }
        var j = 0
        for i in 0..<doorsStatus.count {
            if doorsStatus[i] {
                print("У вас открыта дверь (\(CarSides.init(rawValue: i)!))")
                j += 1
            }
        }
        if j == 0 {
            print("Все двери закрыты")
        }
        var k = 0
        for i in 0..<windowsStatus.count {
            if windowsStatus[i] {
                print("У вас открыто окно (\(CarSides.init(rawValue: i)!))")
                k += 1
            }
        }
        if k == 0 {
            print("Все окна закрыты")
        }
    }
}

extension Car: CustomStringConvertible {
    var description: String {
        return "\(mark) \(model)"
    }
}

//var a = Car(mark: "Audi", model: "A8", hasAlarm: true)
//var b = Car(mark: "Audi", model: "A8", hasAlarm: false)

var soldCars = [Car]()

// ! Почему-то в readLine() попадают символы, которые были стерты бэкспейсом

print("Добро пожаловать в авто салон.\nМы продаем автомобили любых моделей и марок по фиксированной цене.\nКакую марку автомобиля вы ищите?")
var myMark: String? = readLine()!
while myMark == nil {
    print("Вы неверно указали марку. Повторите ввод")
    myMark = readLine()
}
print("Какая модель вас интересует?")
var myModel: String? = readLine()
while myModel == nil {
    print("Вы неверно указали модель. Повторите ввод")
    myMark = readLine()
}
print("Вы хотите поставить на нее сигнализацию? Ответьте \"Да\" или \"Нет\"")
var myAlarm: Bool?
if readLine() == "Да" {
    myAlarm = true
} else if readLine() == "Нет" {
    myAlarm = false
}

soldCars.append(Car(mark: myMark!, model: myModel!, hasAlarm: myAlarm!))

let myCar = soldCars[0]

print("Вы можете использовать следующие команды:\nсигнализация ([серийный номер]), статус, инфо, двигатель, окно (пп, пл, зп, зл), дверь (пп, пл, зп, зл)")
print("сигнализация (\(myCar.alarmSerial!))")

var command: String?
while true {
    command = readLine()?.lowercased()
    switch command {
    case "сигнализация (\(myCar.alarmSerial!))":
            myCar.alarm(myCar.alarmSerial!)
        case "двигатель":
            myCar.engine()
        case "окно пл":
            myCar.windows(.frontLeft)
        case "окно пп":
            myCar.windows(.frontRight)
        case "окно зл":
            myCar.windows(.rearLeft)
        case "окно зп":
            myCar.windows(.rearRight)
        case "дверь пл":
            myCar.doors(.frontLeft)
        case "дверь пп":
            myCar.doors(.frontRight)
        case "дверь зл":
            myCar.doors(.rearLeft)
        case "дверь зп":
            myCar.doors(.rearRight)
        case "статус":
            myCar.status()
        case "инфо":
            myCar.info()
        default:
            print("Вы ввели неизвестную команду")
    }
}

 */

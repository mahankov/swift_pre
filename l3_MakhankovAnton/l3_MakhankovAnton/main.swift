//
//  main.swift
//  l3_MakhankovAnton
//
//  Created by Anton Makhankov on 05/03/2019.
//  Copyright © 2019 Anton Makhankov. All rights reserved.
//

import Foundation

// 1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
// 2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
// 3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
// 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
// 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
// 6. Вывести значения свойств экземпляров в консоль.

enum CarActions {
    case engine
    case trunc
    case windows
}

enum Transmission {
    case at
    case mt
}

struct Car {
    var mark            : String
    var model           : String
    var transmission    : Transmission
    var year            : UInt
    var trunkVol        : UInt // Объем багажника/кузова
    var engineStatus    : Bool // Статус двигателя
    var windowsStatus   : Bool // Статус окон
    var alarmStatus     : Bool // Статус сигнализации
    var trunkVolCur     : UInt // Текущий занятый объем багажника/кузова
    private var alarmSerial : String // Для проверки приватных данных, добавил серийный номер сигнализации, которую нельзя получить у экземпляра класса, но она нужна, чтобы снять автомобиль с сигнализации
    
    init(mark: String, model: String, transmission: Transmission, year: UInt, trunkVol: UInt, alarmSerial: String) {
        self.mark           = mark
        self.model          = model
        self.transmission   = transmission
        self.year           = year
        self.trunkVol       = trunkVol
        self.alarmSerial    = alarmSerial
        self.engineStatus   = false
        self.windowsStatus  = false
        self.alarmStatus    = true
        self.trunkVolCur    = 0
    }
    
    mutating func alarm(_ value: String) {
        if(value == alarmSerial) {
            alarmStatus = false
        } else {
            print("Вы попытались снять автомобиль с чужого брелка")
        }
    }
    
    mutating func engineOn() {
        if alarmStatus {
            print("Вы не можете запустить двигатель, пока машина стоит на сигнализации")
        } else {
            if engineStatus {
                print("Машина уже запущена")
            } else {
                engineStatus = true
            }
        }
    }
    
    mutating func engineOff() {
        if engineStatus {
            engineStatus = false
        } else {
            print("Машина уже заглушена")
        }
    }
    
    mutating func trunkLoad(_ value: UInt) {
        if alarmStatus {
            print("Вы не можете загружать автомобиль, пока он стоит на сигнализации")
        } else {
            if value <= trunkVol - trunkVolCur {
                trunkVolCur += value
            } else {
                print("Вы пытаетесь загрузить слишком большой объем груза. Свободный объем: \(trunkVol - trunkVolCur)")
            }
        }
    }
    
    mutating func trunkUnload() {
        if alarmStatus {
            print("Вы не можете разгружать автомобиль, пока он стоит на сигнализации")
        } else {
            trunkVolCur = 0
        }
    }
    
    func carStatus() {
        print(alarmStatus ? "Автомобиль на сигнализации" : "Автомобиль снят с охраны")
        print(engineStatus ? "Двигатель запущен" : "Двигатель заглушен")
        print(windowsStatus ? "Окна открыты" : "Окна закрыты")
        print(trunkVolCur > 0 ? "Вы загружены на \(UInt(Float(trunkVolCur) / Float(trunkVol) * 100))%" : "Машина не загружена")
    }
    
    mutating func easyAccess(_ value: CarActions) {
        if alarmStatus {
            print("Сначала необходимо снять автомобиль с охраны")
        } else {
            switch value {
                case .engine:
                    engineStatus = engineStatus ? false : true
                case .trunc:
                    windowsStatus = windowsStatus ? false : true
                case .windows:
                    trunkVolCur = 0
            }
        }
    }
}

var freelander  = Car(mark: "Land Rover", model: "Freelander", transmission: .at, year: 2018, trunkVol: 1670, alarmSerial: "qwerty")
var kamaz6520   = Car(mark: "KamAZ", model: "6520", transmission: .mt, year: 2019, trunkVol: 66000, alarmSerial: "asdfgh")


/*
 .engineOn() – включение двигателя, параметры не передаются
 .engineOff() – выключение двигателя, параметры не передаются
 .alarm(String) – постановка/снятие с охраны, передается серийный номер, сохраненный при добавлении экземпляра
 .trunkLoad(UInt) – загрузка багажника/кузова, передается объем груза
 .trunkUnload() – разгрузка багажника/кузова, ничего не передается
 .carStatus() – вывод статуса автомобиля, ничего не передается
 .easyAccess(CarActions) – быстрая смена статуса того или иного агрегата. Передается название агрегата (engine, trunk, windows)
 
*/


// Попытаемся снять автомобиль с охраны с подложным серийным номером
freelander.alarm("asdfg")
// Попытаемся снять автомобиль с охраны с правильным серийным номером
freelander.alarm("qwerty")
// Проверим окна
print(freelander.windowsStatus)
// Проверим, сколько груза в машине
print(freelander.trunkVolCur)
// Загрузим машину
freelander.trunkLoad(1000)
// Попробуем загрузить еще
freelander.trunkLoad(1000)
// Вторая загрузка превышает объем багажника/кузова, так что вторую загрузку не производим
print(freelander.trunkVolCur)
// Выведем основные статусы автомобиля
freelander.carStatus()
// Попытаемся заглушить уже заглушенную машину
freelander.engineOff()
// Быстрые команды автомобилью (перечисления по действиям с авто)
freelander.easyAccess(.engine)
// Снова получим статус автомобиля
freelander.carStatus()

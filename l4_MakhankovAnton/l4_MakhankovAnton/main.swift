//
//  main.swift
//  l4_MakhankovAnton
//
//  Created by Anton Makhankov on 10/03/2019.
//  Copyright © 2019 Anton Makhankov. All rights reserved.
//

import Foundation

/*
1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
5. Создать несколько объектов каждого класса. Применить к ним различные действия.
6. Вывести значения свойств экземпляров в консоль.
*/

enum Actions {
    case engine
    case windows
    case trunk
}

enum Transmission {
    case at
    case mt
}

enum TruksTypes {
    case tipper
    case carTransporter
    case concreteMixer
    case chiller
    case boxTruck
}

class Car {
    var mark: String
    var model: String
    var transmission: Transmission
    var engine: Bool
    var windows: Bool
    var trunk: Bool
    init(mark: String, model: String, transmission: Transmission) {
        self.mark = mark
        self.model = model
        self.transmission = transmission
        self.engine = false
        self.windows = false
        self.trunk = false
    }
    func actions(_ action: Actions) {
        switch action {
            case .engine:
                engine = engine ? false : true
            case .trunk:
                trunk = trunk ? false : true
            case .windows:
                windows = windows ? false : true
        }
    }
}

class TrunkCar : Car {
    var trukType: TruksTypes
    var trunkVol: Int
    var trunkCur: Int
    init(mark: String, model: String, transmission: Transmission, trukType: TruksTypes, trunkVol: Int) {
        self.trukType = trukType
        self.trunkVol = trunkVol
        self.trunkCur = 0
        super.init(mark: mark, model: model, transmission: transmission)
    }
    override func actions(_ action: Actions) {
        switch action {
            case .engine:
                if engine {
                    engine = false
                    print("Двигатель заглушен")
                } else {
                    print("Двигатель запущен")
                }
            case .trunk:
                if trunkCur > 0 {
                    trunkCur = 0
                    print("Груз выгружен")
                } else {
                    print("Вы не загружены")
                }
            case .windows:
                if windows {
                    windows = false
                    print("Окна закрыты")
                } else {
                    print("Окна открыты")
                }
        }
    }
}

class SportСar : Car {
    var up100: Float // Разгон до 100
    var spoiler: Bool
    init(mark: String, model: String, transmission: Transmission, up100: Float) {
        self.up100 = up100
        self.spoiler = false
        super.init(mark: mark, model: model, transmission: transmission)
    }
    override func actions(_ action: Actions) {
        switch action {
            case .engine:
                if engine {
                    engine = false
                    print("Двигатель заглушен")
                    spoiler = false
                    print("Спойлер убран")
                } else {
                    engine = false
                    print("Двигатель запущен")
                    spoiler = false
                    print("Спойлер выдвинут")
                }
            case .trunk:
                trunk = trunk ? false : true
            case .windows:
                if windows {
                    windows = false
                    print("Окна закрыты")
                } else {
                    print("Окна открыты")
                }
        }
    }
}

var kamaz = TrunkCar(mark: "Kamaz", model: "A123", transmission: .mt, trukType: .boxTruck, trunkVol: 50000)
var bugatti = SportСar(mark: "Bugatti", model: "Veyron", transmission: .at, up100: 2.2)

// Запустим двигатель Камаза
kamaz.actions(.engine) 

// Попробуем выгрузить пустой кузов
kamaz.actions(.trunk)

// Откроем окна в Камазе
kamaz.actions(.windows)

// Запустим Бугатти
bugatti.actions(.engine)

// Время разгона до 100 км/ч
print(bugatti.up100)

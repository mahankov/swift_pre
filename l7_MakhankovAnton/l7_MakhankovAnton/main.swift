//
//  main.swift
//  l7_MakhankovAnton
//
//  Created by Anton Makhankov on 19/03/2019.
//  Copyright © 2019 Anton Makhankov. All rights reserved.
//

import Foundation


/*
1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
*/

protocol BankCardIdenty {
    var userName: String { get set }
    var userPassport: UInt { get set }
    var cardNumber: UInt { get set }
}

enum TransactionsErrors: Error {
    case notEnoughtMoney
    case yourCardBlocked
    case personCardBlocked
}

class Card: BankCardIdenty {
    var userName: String
    var userPassport: UInt
    var cardNumber: UInt
    var cardBlocked: Bool
    private var money: Float = 0
    init(userName: String, userPassport: UInt, cardNumber: UInt) {
        self.userName = userName
        self.userPassport = userPassport
        self.cardNumber = cardNumber
        self.cardBlocked = false
    }
    func myCardNumber() {
        let digits = String(cardNumber).compactMap { Int(String($0)) }
        let rank: UInt = 4
        var string: String = ""
        var count: UInt = 0
        for digit in digits {
            if count == rank {
                string += " "
                count = 0
            }
            string += String(digit)
            count += 1
        }
        print(string)
    }
    func addMoney(_ sum: UInt) throws -> (sum: UInt, balance: Float) {
        guard !cardBlocked else {
            throw TransactionsErrors.yourCardBlocked
        }
        money += Float(sum)
        return (sum, money)
    }
    func withdrawMoney(_ sum: UInt) throws -> (sum: UInt, balance: Float) {
        guard !cardBlocked else {
            throw TransactionsErrors.yourCardBlocked
        }
        guard money >= Float(sum) else {
            throw TransactionsErrors.notEnoughtMoney
        }
            money -= Float(sum)
            return (sum,money)
    }
    func balance() {
        print("На вашем счете \(money) руб.")
    }
    func sendMoney(_ user: Card, _ sum: UInt) throws -> (sum: UInt, user: String) {
        guard !cardBlocked else {
            throw TransactionsErrors.yourCardBlocked
        }
        guard money >= Float(sum) else {
            throw TransactionsErrors.notEnoughtMoney
        }
        guard !user.cardBlocked else {
            throw TransactionsErrors.personCardBlocked
        }
        money -= Float(sum)
        user.money += Float(sum)
        return (sum, user.userName)
    }
    func blockCard() {
        cardBlocked = true
        print("Ваша карта заблокирована")
    }
}

var myCard = Card(userName: "Anton", userPassport: 1234567890, cardNumber: 1234123412345678)
var herCard = Card(userName: "Yana", userPassport: 2345676767, cardNumber: 2345234567896789)

// Мой номер банковской карты
myCard.myCardNumber()
// Добавить денег на карту
do {
    let addMoney = try myCard.addMoney(100000)
    print("Карта пополнена на \(addMoney.sum) руб. Баланс: \(addMoney.balance)")
} catch TransactionsErrors.yourCardBlocked {
    print("Ваша карта заблокирована")
} catch let error {
    print("Произошла непредвиденная ошибка \(error.localizedDescription)")
}
// Пробуем снять деньги с карты
do {
    let withdrawMoney = try myCard.withdrawMoney(50000)
    print("Сумма в размере \(withdrawMoney.sum) руб. выдана. Остаток \(withdrawMoney.balance) руб")
} catch TransactionsErrors.notEnoughtMoney {
    print("У вас недостаточно денег")
} catch TransactionsErrors.yourCardBlocked {
    print("Ваша карта заблокирована")
} catch let error {
    print("Произошла непредвиденная ошибка \(error.localizedDescription)")
}
// Баланс карты
myCard.balance()
// Попробуем отправить деньги на другую карту (успешно)
do {
    let transfer = try myCard.sendMoney(herCard, 2000)
    print("Перевод \(transfer.sum) для клиента \(transfer.user) успешно совершен")
} catch TransactionsErrors.notEnoughtMoney {
    print("У вас недостаточно денег")
} catch TransactionsErrors.yourCardBlocked {
    print("Ваша карта заблокирована")
} catch TransactionsErrors.personCardBlocked {
    print("Карта получателя денежных средств заблокирована")
} catch let error {
    print("Произошла непредвиденная ошибка \(error.localizedDescription)")
}
// Заблокируем вторую карту
herCard.blockCard()
// Попробуем отправить деньги на заблокированную карту (ошибка)
do {
    let transfer = try myCard.sendMoney(herCard, 2000)
    print("Перевод \(transfer.sum) для клиента \(transfer.user) успешно совершен")
} catch TransactionsErrors.notEnoughtMoney {
    print("У вас недостаточно денег")
} catch TransactionsErrors.yourCardBlocked {
    print("Ваша карта заблокирована")
} catch TransactionsErrors.personCardBlocked {
    print("Карта получателя денежных средств заблокирована")
} catch let error{
    print("Произошла непредвиденная ошибка \(error.localizedDescription)")
}
// Посмотрим баланс второй карты
herCard.balance()
// Попробуем положить деньги на вторую карту
do {
    let addMoney = try herCard.addMoney(10000)
    print("Карта пополнена на \(addMoney.sum) руб. Баланс: \(addMoney.balance)")
} catch TransactionsErrors.yourCardBlocked {
    print("Ваша карта заблокирована")
} catch let error {
    print("Произошла непредвиденная ошибка \(error.localizedDescription)")
}


/*
2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.
*/

print ("\n---------------------------------\n")

enum GameErrors: Error {
    case moneyIsOver
    case toMuchWins
    case didntPlayYet
}



class Blackjack {
    static var bet: UInt = 100
    private static var cardsValues = [1,2,3,4,5,6,7,8,9,10]
    var balance: UInt
    init(balance: UInt) {
        self.balance = balance
        print("Добро пожаловать в игру Blackjack. Ставка на игру составляет \(Blackjack.bet) руб.")
    }
    func letsplay(_ count: UInt) -> (balance: UInt?, GameErrors?) {
        var games: UInt = 0
        while balance >= 0 && games <= count {
            guard balance >= Blackjack.bet else {
                return (nil,GameErrors.moneyIsOver)
            }
            games += 1
            let userFirstCard   = Int.random(in: 0..<Blackjack.cardsValues.count)
            let userSecondCard  = Int.random(in: 0..<Blackjack.cardsValues.count)
            let botFirstCard    = Int.random(in: 0..<Blackjack.cardsValues.count)
            let botSecondCard   = Int.random(in: 0..<Blackjack.cardsValues.count)
            
            if userFirstCard + userSecondCard > botFirstCard + botSecondCard {
                balance += Blackjack.bet
            } else if userFirstCard + userSecondCard < botFirstCard + botSecondCard {
                balance -= Blackjack.bet
            }
            
            guard balance < balance * 10 else {
                return (nil,GameErrors.toMuchWins)
            }
        }
        return(balance,nil)
    }
}

// Создадим игру с балансом 1000 руб и сыграем 100 раз
let newGame = Blackjack(balance: 1000)
let game1 = newGame.letsplay(100)
if let myGame = game1.balance {
    print("Игра закончена с балансом \(myGame) руб.")
} else if let error = game1.1 {
    print("Сегодня не ваш день. Ошибка:  \(error.localizedDescription)")
}

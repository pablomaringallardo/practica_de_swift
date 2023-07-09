import Foundation

// Mark: Struct

struct Client {
    var name: String
    var age: Int
    var height: Int
}

struct Reservation {
    let id: String
    var hotelName: String
    var clientList: [Client]
    var days: Int
    var price: Double
    var breakfast: Bool
}

enum ReservationError: Error {
    case idDuplicate
    case reservationFound
    case reservationNotFound
    case clientDuplicate
}

// Mark: Class

class HotelReservationManager {
    var reservations: [Reservation] = []
    var reservationIndex: Int = 0
    
    func addReservation(clients: [Client], days: Int, breakfeast: Bool) throws -> Reservation{
        
        // Comprobación de ID duplicado
        
        if reservations.contains(where: { $0.id == String(reservationIndex) }) {
            throw ReservationError.idDuplicate
        }
    
        // Comprobación de reserva con el mismo cliente
        
        for client in clients {
            if reservations.contains(where: { $0.clientList.contains(where: { $0.name == client.name })}) {
                throw ReservationError.clientDuplicate
            }
        }
        
        let priceBase: Double = 20
        let priceBreakfast: Double = breakfeast ? 1.25 : 1
        let totalPrice = Double(clients.count) * priceBase * Double(days) * priceBreakfast
        
        
        let reservation = Reservation(id: String(reservationIndex), hotelName: "Mitra", clientList: clients, days: days, price: totalPrice, breakfast: breakfeast)
        
        reservations.append(reservation)
        reservationIndex += 1
        return reservation
    }
    
    func deleteReservation(id: String) throws -> String{
        if reservations.contains(where: {$0.id == id}) {
            reservations.removeAll(where: {$0.id == id})
            return "Reserva cancelada"
        }else {
            throw ReservationError.reservationNotFound
        }
    }
    
    func reservationList() {
        for reservation in reservations {
            print("Reserva número \(reservation.id) a nombre de \(reservation.clientList[0].name)")
        }
    }
}

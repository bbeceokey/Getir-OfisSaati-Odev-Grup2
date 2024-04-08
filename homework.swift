import UIKit
import Foundation

let g = 10.0

class Oyuncu {
    var takmaAd: String
    var puan: Int = 0
    
    init(takmaAd: String) {
        self.takmaAd = takmaAd
    }
    
    func puanArttir() {
        puan += 1
    }
}


class Topatar {
    var yerlesimAcisi: Double = 0.0
    var firlatmaHizi: Double = 0.0
    
    func menzilHesapla() -> Double {
        let radyanAcisi = yerlesimAcisi * .pi / 180
        return (firlatmaHizi * firlatmaHizi) * sin(2 * radyanAcisi) / g
    }
    
    func yerlesimAcisiAyarla(yeniAcisi: Double) {
        guard yeniAcisi >= 0, yeniAcisi <= 90 else {
            print("Yerleşim açısı 0 ile 90 derece arasında olmalıdır.")
            return
        }
        self.yerlesimAcisi = yeniAcisi
    }
    
    func firlatmaHiziAyarla(yeniHiz: Double) {
        guard yeniHiz >= 0, yeniHiz <= 100 else {
            print("Fırlatma hızı 0 ile 100 m/s arasında olmalıdır.")
            return
        }
        self.firlatmaHizi = yeniHiz
    }
}


class Sise {
    var konum: Double
    var delta: Double
    var durum: Bool = true
    
    init(konum: Double, delta: Double) {
        self.konum = konum
        self.delta = delta
    }
    
    func vurulduMu(menzil: Double) -> Bool {
        if (konum - delta) <= menzil && menzil <= (konum + delta) {
            durum = false
            return true
        }
        return false
    }
    
    func konumAyarla(yeniKonum: Double) {
        guard yeniKonum >= 0, yeniKonum <= 1500 else {
            print("Konum 0 ile 1500 metre arasında olmalıdır.")
            return
        }
        self.konum = yeniKonum
    }
    
    func deltaAyarla(yeniDelta: Double) {
        guard yeniDelta >= 0.1, yeniDelta <= 1 else {
            print("Delta 0.1 ile 1 metre arasında olmalıdır.")
            return
        }
        self.delta = yeniDelta
    }
}

class Oyun {
    var oyuncu: Oyuncu
    var topatar: Topatar
    var sise: Sise
    
    init(oyuncu: Oyuncu, topatar: Topatar, sise: Sise) {
        self.oyuncu = oyuncu
        self.topatar = topatar
        self.sise = sise
    }
    
    func oyuncuTakmaAdGir(takmaAd: String) {
        oyuncu.takmaAd = takmaAd
    }
    
    func siseKonumGir(konum: Double, delta: Double) {
        sise.konumAyarla(yeniKonum: konum)
        sise.deltaAyarla(yeniDelta: delta)
    }
    
    func topAtisAyarlariniGir(yerlesimAcisi: Double, firlatmaHizi: Double) {
        topatar.yerlesimAcisiAyarla(yeniAcisi: yerlesimAcisi)
        topatar.firlatmaHiziAyarla(yeniHiz: firlatmaHizi)
    }
    
    func firlatmaYap() -> String {
        let menzil = topatar.menzilHesapla()
        if sise.vurulduMu(menzil: menzil) {
            oyuncu.puanArttir()
            return "İsabet \(oyuncu.takmaAd) puanı: \(oyuncu.puan)"
        } else {
            return "Kaçırdınız \(oyuncu.takmaAd) puanı: \(oyuncu.puan)"
        }
    }
}

func oyunuOynat() {
    let oyuncu = Oyuncu(takmaAd: "Player1")
    let topatar = Topatar()
    let sise = Sise(konum: 1000, delta: 0.5)
    let oyun = Oyun(oyuncu: oyuncu, topatar: topatar, sise: sise)

    oyun.oyuncuTakmaAdGir(takmaAd: "Player2")
    oyun.siseKonumGir(konum: 350, delta: 10)
    oyun.topAtisAyarlariniGir(yerlesimAcisi: 45, firlatmaHizi: 60)
    
    let sonuc = oyun.firlatmaYap()
    print(sonuc)
}

oyunuOynat()
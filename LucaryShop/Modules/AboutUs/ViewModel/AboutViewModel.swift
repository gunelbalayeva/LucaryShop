//
//  AboutViewModel.swift
//  LucaryShop
//
//  Created by User on 29.06.25.
//
import Foundation
import CoreLocation
final class AboutViewModel{
    private let coordinator:AboutCoordinator
    
    init(coordinator: AboutCoordinator) {
        self.coordinator = coordinator
    }
    
    let aboutText: String = """
    İncəsənətin Sehirli Dünyasına Xoş Gəlmisiniz!
    Yeni onlayn platformamız – Lucary.com artıq aktivdir!
    
    Bizim üçün böyük bir həyəcanla təqdim edirik: Lucary.com – yaradıcılıq və sənətin qovuşduğu yeni ünvan!
    
    Lucary nədir?
    Lucary.com – əl işləri və sənət əsərləri ilə məşğul olan sənətkarlar, dizaynerlər və yaradıcı şəxslər üçün qurulmuş onlayn bazar platformasıdır.
    
    Burada:
    • Yüzlərlə unikal məhsul birbaşa sənətkarlardan təqdim olunur
    • Hər bir məhsul sevgi və zəhmətlə hazırlanır
    • Əməkdaş sənətkarlarımız öz işlərini geniş auditoriyaya təqdim edə bilirlər
    
    Platformamızda nə var?
    • Əl işləri
    • Dekorativ məhsullar
    • Sənət əsərləri
    • Bəzək əşyaları
    • Geyim və aksesuarlar
    • və daha çox!
    
    Məqsədimiz:
    • Yaradıcılığı təşviq etmək
    • Ənənəvi və müasir sənəti bir araya gətirmək
    • Sənətkarların səsini dünyaya çatdırmaq
    • Müştərilərə keyfiyyətli və orijinal məhsullar təqdim etmək
    """
    
    let contactInfoText: String = """
    📞 Telefon: +994103210916
    
    🌐 Veb sayt: https://lucary.com
    
    🏢 Sektor: Texnologiya, İnformasiya və İnternet
    
    👥 Komanda: 11–50 nəfər
    
    📍 Qurulub: 2022 – Bakı, Azərbaycan
    """
    
    
    var videoURL: URL? {
        if let path = Bundle.main.path(forResource: "About", ofType: "mp4") {
            return URL(fileURLWithPath: path)
        }
        return nil
    }
    
    var imageName: String {
        return "AboutImage"
    }
    
    let location = CLLocationCoordinate2D(latitude: 40.4093, longitude: 49.8671)
}

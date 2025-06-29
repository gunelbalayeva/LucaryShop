//
//  TermsViewModel.swift
//  LucaryShop
//
//  Created by User on 29.06.25.
//

import Foundation
final class TermsViewModel {
    private let coordinator:TermsCoordinator
    
    init(coordinator: TermsCoordinator) {
        self.coordinator = coordinator
    }
    
    var termsText: String {
        return """
Son yeniləmə: 9 Mart 2025

1. İstifadə Şərtləri
Lucary platformasından istifadə etməklə siz platformanın bütün qayda və şərtlərini qəbul etmiş olursunuz. Bu, istifadəçilər üçün təhlükəsiz və ədalətli bir mühit yaradılmasına xidmət edir.

1.1 İstifadəçi Razılaşması
İstifadəçilər Lucary istifadə zamanı Azərbaycan Respublikasının qüvvədə olan qanunvericiliyinə və beynəlxalq hüquq normalarına riayət etməlidirlər. Qaydaların pozulması hesabın bloklanmasına səbəb ola bilər.

1.2 E-ticarət Şərtləri
Bütün ödəniş əməliyyatları aşağıdakı qaydalara tabedir:
- Yalnız platforma tərəfindən təsdiq olunmuş ödəniş sistemlərindən istifadə oluna bilər.

1.3 Vergi Öhdəlikləri
Lucary, Azərbaycan Respublikasının Vergi Məcəlləsinə uyğun olaraq avtomatik şəkildə vergi tutulmalarını həyata keçirir.

2. Platforma Qaydaları
Təhlükəsiz və hörmətli bir istifadəçi mühiti üçün:
- Nifrət nitqi və zorakılıq qadağandır.
- Saxta və ya qeyri-qanuni məhsulların satışı qəti qadağandır.
- Süni intellekt tərəfindən yaradılmış kontent aydın şəkildə qeyd olunmalıdır.

2.1 Süni İntellekt
AI alətlərindən istifadə zamanı:
- Məlumat toplanması "Şəxsi Məlumatların Mühafizəsi Qanunu"na uyğun olmalıdır.
- AI ilə yaradılmış kontentə müəllif hüquqları istifadəçiyə məxsusdur.
- Həssas mövzulu kontent yaradılması qadağandır.
- AI nəticələri müəllif hüquqlarını pozmamalıdır.

2.2 Marketplace Davranış Qaydaları
Satıcı məsuliyyətləri:
- Lüks məhsulların orijinallığına zəmanət verilməlidir.
- AI ilə yaradılmış sənət əsərləri aydın şəkildə qeyd olunmalıdır.
- Qadağan olunmuş maddələrin satışı yolverilməzdir.
- Beynəlxalq göndəriş qaydalarına əməl olunmalıdır.

3. Lisenziyalar və Əqli Mülkiyyət Hüquqları
Platformada yerləşdirilən bütün kontent müəllif hüquqları və əqli mülkiyyət qanunları ilə qorunur.

3.1 Kontent Lisenziyası
İstifadəçilər Lucary platformasına yüklədikləri kontenti istifadə etmək üçün qeyri-eksklüziv lisenziya təqdim edirlər.

3.2 Sənət Əsərlərinin Lisenziyası
Rəqəmsal sənət əsərlərinin satışı məhdud kommersiya hüquqları ilə həyata keçirilir. Tam hüquqlar üçün əlavə müqavilə tələb olunur.
"""
    }
}

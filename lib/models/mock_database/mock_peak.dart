import 'package:bach_thes/models/peak.dart';

mixin MockPeak implements Peak {
  static final List<Peak> peaks = [
    Peak(
        latitude: "1.1.1",
        longitude: "1.2.1",
        altitude: 2684,
        id: 1,
        isPeak: true,
        name: "Triglav",
        description: "Najvišji vrh v Sloveniji",
        region: "Gorenjska",
        possiblePaths: [],
        mountainRange: "Julijske alpe",
        urlThumbnail:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Triglav.jpg/1200px-Triglav.jpg"),
    Peak(
        latitude: "1.3.1",
        longitude: "1.4.1",
        altitude: 1678,
        id: 2,
        isPeak: true,
        name: "Kofce",
        description: "Najboljši štruklji v Sloveniji",
        region: "Gorenjska",
        possiblePaths: [],
        mountainRange: "Julijske alpe",
        urlThumbnail:
            "https://n1info.si/wp-content/uploads/2022/03/10/1646898149-20220309_104030-750x563.jpg"),
    Peak(
        latitude: "1.5.1",
        longitude: "1.6.1",
        altitude: 1990,
        id: 3,
        isPeak: true,
        name: "Dom na Komni",
        description: "Najlepši razgled v Sloveniji",
        region: "Gorenjska",
        possiblePaths: [],
        mountainRange: "Julijske alpe",
        urlThumbnail:
            "https://kraji.eu/PICTURES/gorenjska/bohinj_z_okolico/dom_na_komni_koca_pod_bogatinom/IMG_4590_koca_pod_bogatinom.jpg")
  ];

  static List<Peak> FetchAll() {
    return MockPeak.peaks;
  }
}

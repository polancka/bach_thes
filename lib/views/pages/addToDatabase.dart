import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:flutter/material.dart';

class UpdateDatabase extends StatefulWidget {
  const UpdateDatabase({super.key});

  @override
  State<UpdateDatabase> createState() => _UpdateDatabaseState();
}

class _UpdateDatabaseState extends State<UpdateDatabase> {
  /* doUpdate() {
    //add peaks
    addNewPeak(
        11,
        "Vrtača",
        2181,
        "Vrtača je 2181 m visok vrh, ki se nahaja vzhodno od Stola. Z vrha na katerem stoji velik klin se nam odpre lep razgled na del Julijskih Alp, Karavanke, Visoke in Nizke Ture, Kamniško Savinjske Alpe in del Gorenjske. Vrh ima vpisno skrinjico.",
        "https://www.hribi.net/Gora/p1300051vtf28resized8dc.jpg",
        "46,43992°N",
        "14,21226°E",
        "Karawanks",
        "vrtaca");
    addNewPeak(
        13,
        "Kepa",
        2143,
        "Kepa, tudi Jepa, oz. po nemško Mittagskogel je razgledna gora v zahodnih Karavankah, ki se nahaja na mejnem grebenu med Slovenijo in Avstrijo. Z vrha, na katerem se nahaja križ (nekoliko pod vrhom, na avstrijski strani se nahaja še en) in pod njim vpisna skrinjica z žigom, se nam odpre lep razgled, ki seže vse od bližnjih Julijskih Alp, prek Karnijskih Alp do Visokih in Nizkih Tur v Avstriji.",
        "https://www.hribi.net/Gora/p1010213mediumjz3.jpg",
        "46,50679°N",
        "13,95249°E",
        "Karawanks",
        "kepa");
    addNewPeak(
        14,
        "Ojstrc",
        2139,
        "Ojstrc (Hochobir) je najvišji vrh manjšega pogorja imenovanega Obir. Nahaja se zahodno od Železne Kaple (Eisenkappel) na avstrijski strani Karavank. Z razglednega vrha na katerem je postavljen križ in meteorološka postaja je lep razgled na severna ostenja Košute, del Kamniških in Savinjskih Alp, proti severu pa se vidi Mali Obir (Kleinobir) in del Dravske doline. Obir je poznan tudi po bogatem rastlinstvu, ki ga na gori ne manjka.",
        "https://www.hribi.net/slike1/P4230151558600.jpg",
        "46,50599°N",
        "14,48724°E",
        "Karawanks",
        "ojstrc");
    addNewPeak(
        15,
        "Košutnikov turn",
        2133,
        "Košutnikov Turn je najvišji vrh v najdaljšem slovenskem grebenu Košuti. Z vrha je lep pogled proti celotnemu grebenu. Prav tako pa se lepo vidi Avstrija in Kamniške in Savinjske Alpe. Na vrhu stoji križ na katerem je vpisna knjiga.",
        "https://www.hribi.net/Gora/pa080132mediumek5.jpg",
        "46,44637°N",
        "14,41031°E",
        "Karawanks",
        "kosutnikov turn");
    addNewPeak(
        16,
        "Peca",
        2125,
        "Kordeževa glava bolj znana pod imenom Peca je najvišji vrh pogorja Pece. Nahaja se na meji z Avstrijo nad Mežiško dolino na Koroškem. Slovenci Peco poznamo predvsem zaradi pripovedke o kralju Matjažu in njegovi votlini na slovenski strani gore, Avstrijci pa imajo visoko v zgornja pobočja speljane žičnice tako, da jo poznajo ljubitelji smučanja. Ker v bližini Pece ni višjih vrhov je z nje lep razgled. Lepo se vidi bližnja Uršlja gora, Raduha in greben Olševe. Prav tako se vidijo najvišji vrhovi Kamniških in Savinjskih Alp. Na severno stran pa se vidijo avstrijske Alpe, kjer so nam najbližje Stubalpe-Packalpe in Seetaler Alpe.",
        "https://www.hribi.net/slike1/P819013213440.jpg",
        "46,50023°N",
        "14,77993°E",
        "Karawanks",
        "peca");
    addNewPeak(
        17,
        "Bistriška špica",
        2113,
        "Bistriška špica je 2113 m visok vrh, ki se nahaja na avstrijski strani Pece. Z vrha na katerem stoji križ je lep razgled na celotne Karavanke, del Kamniško Savinjskih Alp ter goram nad dolino reke Drave.",
        "https://www.hribi.net/slike1/P6130364534600.jpg",
        "46,51149°N",
        "14,75018°E",
        "Karawanks",
        "bistriska spica");
    addNewPeak(
        18,
        "Kočnikov vrh",
        2109,
        "Končnikov vrh je 2109 m visoka gora, ki se nahaja v srednjem delu Pece. S travnatega vrha je lep pogled po grebenu Pece ter goram nad Savinjsko in Dravsko dolino.",
        "https://www.hribi.net/slike1/P61303280.jpg",
        "46,50401°N",
        "14,76322°E",
        "Karawanks",
        "kocnikov vrh");
    //add paths

    addNewPath(
        11,
        "Ljubelj",
        "Ljubelj",
        300,
        1085,
        "Vrtača",
        1123,
        1123,
        " delno zahtevna označena pot",
        "3h 30min",
        "S parkirišča se usmerimo na peš pot v smeri Zelenice, Vrtače in Stola. Kolovozna pot, ki poteka po levi strani smučarske proge, nas po približno 15 minutah zmernega vzpona skozi gozd pripelje do prej omenjene proge ob kateri se nato vzpenjamo. Pot, ki nam nudi lepe poglede na obsežna melišča Begunjščice na levi in greben Ljubeljščice na desni nas nato v rahlem vzponu pripelje do koče na Vrtači. Od koče nadaljujemo naravnost po markirani poti, ki se počasi obrne rahlo v levo in nas po krajšem prečnem vzponu pripelje v pas rušja. Naprej se pot za krajši čas strmeje vzpne in nas nato pripelje na kolovoz (transportno reševalna cesta), kateremu nato v zmernem vzponu sledimo do planinskega doma na Zelenici.Od doma na Zelenici nadaljujemo desno v smeri Stola in Vrtače (levo Begunjščica) po poti, ki takoj za domom zavije levo in se vzpne ob otroški vlečnico. Nekje na polovici žičnice pa pridemo na manj opazno razpotje, kjer nadaljujemo desno in se prečno vzpnemo čez smučarsko progo (naravnost koča pri izviru Završnice). Naprej prečimo kratek pas gozda in pot nas pripelje do naslednje vlečnice katero prečimo v rahlem spustu. Na drugi strani smučarske proge opazimo večjo skalo in na njej markacijo, ki nas usmeri v gozd. Pot naprej se najprej rahlo spusti, nato pa se prečno vzpne čez melišče. Pot se kmalu položi in zavije nekoliko proti levi, kjer pridemo do manjšega neoznačenega razpotja. Nadaljujemo naravnost po zložni in markirani planinski poti, ki nas le nekoliko naprej pripelje do mesta, kjer se v desno odcepi neoznačena pot v dolino Suhega ruševja (možic).Pot naprej se prečno vzpenja po južnih pobočjih Vrtače. Pot, ki deloma poteka skozi gozd, deloma pa čez prostrana melišča, pa nas višje pripelje na označeno razpotje, kjer nadaljujemo desno v smeri Vrtače (naravnost Stol). Pot naprej se začne strmeje vzpenjati, sprva skozi pas rušja, višje pa čez obsežna travnata pobočja. Na omenjenih travnatih pobočjih se nam z leve skoraj neopazno priključi nemarkirana pot od sedla Šija, mi pa nadaljujemo po markirani poti, ki se strmo vzpenja proti stranskemu grebenu Vrtače. Višje pot zavije rahlo v levo, preči strma deloma kamnita pobočja in nas po nekaj minutah nadaljnje hoje pripelje na prej omenjeni greben, kjer pot zavije ostro v desno. Pot naprej se začne strmo vzpenjati po zelo strmih in za zdrs nevarnih pobočjih. Višje nas pot pripelje na glavni greben Karavank, kjer se le ta položi. Sledi približno 20 minut hoje po in ob grebenu, ki je mestoma nekoliko izpostavljen, v celotnem delu pa nevaren za zdrs. Tej razgledni poti nato sledimo vse do vrha Vrtače. Ljubelj - Zelenica 1:20, Zelenica - Vrtača 2:10.");

    addNewPath(
        11,
        "Tinčkova koča - čez Smuško planino in sedlo Šija",
        "Tinčkova koča",
        301,
        1070,
        "Vrtača",
        1111,
        1111,
        " delno zahtevna označena pot",
        "3h 30min",
        "S parkirišča pri Tinčkovi koči nadaljujemo po širokem kamnitem kolovozu v smeri koče pri izviru Završnice. Že po nekaj korakih hoje pa nas markacije usmerijo rahlo desno, na nekoliko bolj strmo peš pot, ki se vzpne čez razgledno travnato pobočje, nato pa se vrne na prej omenjeni kolovoz, kateremu sledimo v desno. Kolovoz, ki se razmeroma strmo vzpenja skozi gozd, pa nas po nekaj minutah nadaljnje hoje pripelje do pašne ograje, za katero pridemo na označeno razpotje.Nadaljujemo naravnost (rahlo desno Roblekov dom) po še naprej kamnitem kolovozu, ki nas višje iz gozda pripelje na prostrana travnata pobočja Smokuške planine. Tu strmina popusti in vse bolj razgledna pot nas v 15 minutah nadaljnje hoje pripelje do koče pri izviru Završnice.Od koče nadaljujemo levo po markirani peš poti v smeri Stola. Pot že po nekaj minutah zapusti kolovoz in preide v manjšo dolino med Srednjim vrhom na levi in Vrtačo na desni. Zmerno strma pot, ki poteka skozi redek gozd, se višje za krajši čas strmo vzpne in nas po nekaj minutah nadaljnje hoje pripelje na sedlo Šija, kjer je označeno razpotje.Nadaljujemo desno v smeri Vrtače (levo Srednji vrh, naravnost Stol spodnja pot) po poti, ki se vzpne skozi pas rušja in nas po nekaj minutah nadaljnje hoje pripelje do zgornje poti Zelenica - Stol.Tu nadaljujemo levo v smeri Stola, a le nekaj korakov, nato pa bomo opazili slabše uhojeno stezico, ki se nadaljuje po pobočju skoraj naravnost navzgor (če ne najdemo odcepa poti lahko nadaljujemo tudi v smeri Zelenice in nato na označenem razpotje levo navzgor). Pot naprej se prične vse strmeje vzpenjati in se po nekaj minutah nadaljnje hoje priključi široki markirani poti od Zelenice. Nadaljujemo levo in vzpon nadaljujemo po poti, ki se strmo vzpenja proti stranskemu grebenu Vrtače. Višje pot zavije rahlo v levo, preči strma deloma kamnita pobočja in nas po nekaj minutah nadaljnje hoje pripelje na prej omenjeni greben, kjer pot zavije ostro v desno. Pot naprej se začne strmo vzpenjati po zelo strmih in za zdrs nevarnih pobočjih. Višje nas pot pripelje na glavni greben Karavank, kjer se le ta položi. Sledi približno 20 minut hoje po in ob grebenu, ki je mestoma nekoliko izpostavljen, v celotnem delu pa nevaren za zdrs. Tej razgledni poti nato sledimo vse do vrha Vrtače.Zaradi strmih trav je v mokrem velika nevarnost zdrsa.Izhodišče - koča pri izviru Završnice 1:00, koča pri izviru Završnice - Vrtača 2:30.");

    addNewPath(
        11,
        "Trate/Johannsenruhe",
        "Trate/Johannsenruhe",
        302,
        1152,
        "Vrtača",
        1029,
        1075,
        "delno zahtevna označena pot",
        "4h",
        "Na začetku parkirišča bomo med cesto, ki je zaprta z rampo in parkiriščem opazili začetek markirane poti, ki vodi proti Celovški koči / Klagenfurter Hütte, Stolu, Svačici, Ovčjemu vrhu / Geissberg in drugim ciljem. Markirani poti se nekoliko naprej priključi še neoznačena pot, ki vodi od zgornjega dela parkirišča, mi pa se nekaj korakov naprej priključimo na makadamsko cesto, ki vodi proti že omenjeni planinski koči. Cesta nas nato vodi preko struge hudournika ter nas le malo naprej pripelje iz gozda na travnik (Trate / Johannsenruhe), ki je od izhodišča oddaljen le nekaj minut. S travnika se nam odpre lep razgled, cesta pa se nato vrne v pas gozda. Ko se gozd prehodno razredči pa se v blagem levem ovinku v smeri naravnost nadaljuje nemarkirana bližnjica. Nadaljujemo po cesti, kamor nas usmerja tudi rumena planinska tabla. Le kako minuto naprej pa glavna cesta zavije desno, stranska pa se nadaljuje naravnost. Od omenjenega križišča nadaljujemo po pešpoti, ki se nadaljuje med obema cestama ter se v nadaljevanju vzpenja s tisto cesto, ki vodi proti Celovški koči. Nekaj časa se prečno vzpenjamo čez občasno bolj strma pobočja, nato pa se vrnemo na širšo makadamsko cesto. V nadaljevanju markirana pot še nekajkrat preči cesto, nato pa se pri večji skali oz. balvanu s spominskimi obeležji razcepi na dva dela.Desno vodi plezalna pot na Stol, mi pa nadaljujemo naravnost v smeri Celovške koče. Pot naprej še nekajkrat preči cesto, višje pa nas iz občasno redkega gozda pripelje na pašna pobočja Mačenske planine / Matschacher Alm (koče na planini so nekaj minut v levo z markirane poti). Od tu sledi še rahel vzpon in pot oz. cesta nas v nekaj minutah popelje do Celovške koče.Pri koči se usmerimo desno v smeri Prešernove koče na Stolu. Pot naprej sprva preči travnata pobočja, nato pa se rahlo spusti na neizrazito sedelce. Pot naprej se začne strmo vzpenjati po melišču do nekoliko poraščenega dela poti. Nekoliko naprej nam pri prečenju bolj strmega pobočja pomaga jeklenica, a ta del poti nam v kopnem ne povzroča težav. Naprej se ponovno vzpenjamo po melišču vse do državne meje.S sedla Belščica, od koder se v levo odcepi pot na Svačico, nadaljujemo naravnost in pot nadaljujemo v smeri Vrtače, Prešernove koče in Zelenice. Nekaj minut prečimo travnata pobočja, nato pa prispemo do mesta, kjer nas napis na skali za Vrtačo usmeri levo (naravnost navzdol Stol). Sledi še nekaj minut razmeroma lahkotne hoje, nato pa prispemo na kratko, a strmo travnato pobočje, preko katerega se prečno spustimo. Ko se spust konča prispemo do prostranih melišč, preko katerih se začnemo v polkrogu vzpenjati. V nadaljevanju slabše uhojena in na več mestih padajočemu kamenju izpostavljena pot se višje nekajkrat strmeje vzpne, nato pa zavije še nekoliko bolj v desno in nas pripelje na jugozahodno ramo Vrtače, kjer se priključimo bolj uhojeni poti z Ljubelja in Završnice.Tu nadaljujemo levo ter se pričnemo strmo vzpenjati po zelo strmih in za zdrs nevarnih pobočjih. Višje nas pot pripelje na glavni greben Karavank, kjer se le ta položi. Sledi približno 20 minut hoje po in ob grebenu, ki je mestoma nekoliko izpostavljen, v celotnem delu pa nevaren za zdrs. Tej razgledni poti nato sledimo vse do vrha Vrtače.Izhodišče - Celovška koča 1:30, Celovška koča - Vrtača 2:30.");

    addNewPath(
        13,
        "Belca",
        "Belca",
        304,
        692,
        "Kepa",
        1451,
        1451,
        "zahtevna označena pot",
        "4h 15min",
        "Parkiramo na označenem parkirišču pri žagi. Se vrnemo nekaj metrov nazaj do začetka označene poti, ki ji sledimo mimo pregrade. Pot gre potem direktno v strugo (desno kolovoz k zapuščeni karavli). Sredi podrtije kamenja od podora, na večji skali zagledamo markacijo. Do sem in nato na drugo stran struge potoka si iščemo najboljše prehode. Ta del je kratek. Sledimo potki po pesku, ki je že kar vidno uhojena, v pomoč nam je tudi markacija na drevesu, tam kjer pot zavije v gozd. Pot se nato v gozdu strmo dviga in prispemo na cesto. Na levi je predor, če se sprehodimo skozenj lahko vidimo kako je podor odnesel cesto. Mi pa nadaljujemo po cesti v desno. Sledi dolga hoja po skoraj ves čas ravni cesti, ki je na več mestih tudi zasuta ali pa udrta, bližje zapornici že skoraj v celoti odnešena, vendar s prehodi ni težav. Po približno uri in 15 minut smo pri nekdanjem izhodišču pri zapornici. Sledimo oznaki za Kepo (slika 2), pot se spusti v strugo potoka, ga preči in zavije levo v breg, velika markacija in smerokaz. Pot se začne strmeje vzpenjati. Naprej se vzpenjamo skozi gozd, ki je občasno prekinjen s kakšno krajšo z grmičevjem poraslo jaso. Markirana planinska pot nato dvakrat preči gozdno cesto, ko na njo stopimo tretjič pa ji sledimo v desno do nekoliko večjega parkirišča ob mejnem grebenu.S parkirišča se v nekaj korakih povzpnemo na mejni greben in poti naprej sledimo proti vzhodu. Razmeroma zložna pot, ki poteka po mejnem grebenu pa nas hitro pripelje do manjšega bivaka (2 ležišči), ki se nahaja na slovenski strani grebena.Od bivaka še naprej nadaljujemo po markirani stezi kateri pa se kmalu priključi še pot iz Avstrije. Pot se nato nekoliko strmeje vzpne in nas naprej vodi po vedno ožjem grebenu. Vse bolj razgledna pot nato preči nekaj rahlo izpostavljenih grap in za tem zavije desno (povsem na slovensko stran). Pot naprej se prečno vzpne čez strmo in dobro zavarovano pobočje, ki je zelo izpostavljeno padajočemu kamenju. Višje pot zavije levo in se nato vzpenja po strmem vršnem pobočju Kepe. Strma in grušča polna pot pa nas višje ponovno pripelje na mejni greben, kjer je naslednje razpotje. Nadaljujemo levo (desno Dovje) po poti, ki nas po nekaj nadaljnjih korakih pripelje na vrh Kepe.Belca - zapornica 1:15, zapornica - bivak 1:15, bivak - Kepa 1:45.");

    addNewPath(
        13,
        "Erjavčev rovt",
        "Erjavčev rovt",
        305,
        1065,
        "Kepa",
        1078,
        1200,
        "zahtevna označena pot",
        "3h 50min",
        "Od sotočja se usmerimo proti levemu potoku (Žakelj) ter ga takoj prečimo. Široka pot se nadaljuje po desni strani potoka, mi pa ji sledimo le nekaj metrov, nato pa nas napis Kepa na pašni ograji usmeri desno na vzpenjajočo pešpot, po kateri v nekaj minutah prispemo nad kočo v Erjevčevem rovtu.Nadaljujemo po markirani poti, le ta pa preide v gozd ter se prične strmo vzpenjati. Višje pot zavije nekoliko v desno ter nas pripelje na razmeroma zložen kolovoz, po katerem nadaljujemo vzpon. Pot nas nato hitro pripelje do korita z vodo, za njim zavije v levo in nas pripelje iz gozda na planino Brvog, čez katero se hitro povzpnemo do bližnje lovske koče.Od koče nadaljujemo desno ter vzpon nadaljujemo po markirani poti, ki preide v gozd. Pot naprej nas hitro pripelje na neizrazit deloma travnat greben, a se mu že kmalu umakne v desno, na nekoliko bolj strma pobočja. Prijetna stezica se višje povsem položi, nato pa nas čez vse bolj razgledna pobočja pripelje do manjše plazovine, preko katere vodi markirana pot. Z nekaj previdnosti prečimo omenjeno pobočje, nato pa nas še naprej razmeroma zložna pot pripelje do studenčka Koritec, ob katerem je označeno razpotje.Na razpotju nadaljujemo levo ter v rahlem vzponu prečimo pobočja poraščena z ruševjem. V nadaljevanju se nekajkrat nekoliko strmeje vzpnemo, odpirati pa se nam pričnejo vse lepši razgledi na Julijske Alpe. Še naprej v vzponu prečimo strma pobočja proti zahodu, nato pa kmalu dosežemo greben, kjer se nam odpre pogled na avstrijsko stran. Kratek čas še nadaljujemo po razmeroma ozkem grebenu, nato pa pot zavije levo ter v vzponu preči strma travnata pobočja pod vrhom Gubno. Pot nas pripelje do neizrazitega grebena na južni strani vrha, kjer se nam odpre pogled proti Kepi. Če želimo obiskati še vrh Gubno potem na tem mestu zapustimo označeno pot ter se usmerimo desno na brezpotje ter v nekaj minutah dosežemo vrh. Označena pot pa še naprej preči strma pobočja ter nas pripelje na zahodno stran Gubna.V nadaljevanju postane pot zahtevnejša in sledi prečenje izpostavljene grape, v pomoč pa so nam tudi varovala.Pot nas nato po grebenu pripelje pod pobočja Dovške Male Kepe. Vrh lahko dosežemo po nezahtevnem brezpotju v 10 minutah. Označena pot pa obide vrh po južni strani in nas po prečenju zelo strmega in krušljivega pobočja pripelje do sedla med Kepo in Dovško Malo Kepo.S sedla nadaljujemo proti zahodu ter prečimo strma pobočja po avstrijski strani grebena do manjšega sedelca, kjer se nam priključi pot iz Avstrije. V nadaljevanju se pot strmeje vzpne in še naprej poteka ob grebenu. Na koncu sledi še nezahteven vzpon po razglednih travnatih pobočjih vse do vrha Kepe.");

    addNewPath(
        14,
        "Kapelška koča",
        "Kapelška koča",
        306,
        1553,
        "Ojstrc",
        586,
        586,
        "lahka označena pot",
        "1h 35min",
        "S parkirišča se najprej sprehodimo do bližnje planinske koče, nato pa nadaljujemo po markirani poti v smeri vrha Ojstrc / Hochobir. Pot gre kmalu nad kočo v gozd, skozi katerega se nato nekaj časa vzpenja. Višje se pot, ob kateri opazimo večje število učno-naravoslovnih tabel položi ter nas iz gozda pripelje v pas rušja. Sledi še nekaj minut lahkotne hoje in pot nas pripelje do klopi na razglednem vrhu Kraguljše.S Kraguljša, s katerega se nam odpre lep pogled na Ojstrc, se pot najprej malenkostno spusti, nato pa nas mimo manjšega napajališča za živali pripelje na prostran greben. Ko stopimo na greben, široka markirana pot zavije v levo ter se nato prečno vzpenja proti levi. Po krajšem vzponu prispemo na preval Kalte Quelle, pot pa se nato še nekaj časa prečno vzpenja proti levi. Višje pot zavije desno ter se ob robu manjše dolinice povzpne do ruševin nekdanje koče na višini 2040 m (Rainer Schutzhaus). Pot naprej se vzpne na manjše sedelce v glavnem grebenu Obirja, kjer se nam z leve priključi pot od sedla Šajda / Zell - Schaida, mi pa nadaljujemo desno ter se po in ob vse bolj razglednem grebenu, ki je predvsem v snegu nevaren za zdrs povzpnemo do 2139 m visokega vrha.");

    addNewPath(
        14,
        "Kurnikovo sedlo",
        "Kurnikovo sedlo",
        307,
        997,
        "Ojstrc",
        1142,
        1142,
        "lahka označena pot",
        "3h 5min",
        "S parkirišča nadaljujemo po asfaltirani cesti, ki se zmerno vzpenja večinoma skozi gozd. Cesta preči nekaj hudourniških potokov in nas po eni uri hoje pripelje na Obirsko planino.S planine na kateri stoji pastirski stan nadaljujemo po cesti, ki kmalu naredi velik desni ovinek. Za ovinkom pa se levo navzgor odcepi označena peš pot na katero se usmerimo (možno nadaljevanje tudi po cesti). Pot, ki se začne nekoliko strmeje vzpenjati preči kolovoz in nas skozi gozd v slabih 30 minutah pripelje na slabšo gozdno cesto. Cesta nas višje pripelje iz gozda in nato zavije levo. Po nekaj metrih pa se peš pot usmeri na travnata pobočja pod kočo »Eisenkappler Hütte« do katere nas loči le še nekaj korakov.V poletni sezoni, ko je cesta odprta se lahko z avtomobilom pripeljemo skoraj do koče Eisenkappler Hütte (to nam pot skrajša za približno 1 uro in pol).Od koče nadaljujemo v smeri naravoslovne učne poti (Naturkundlicher Rundwanderweg). Pot naprej se zmerno vzpenja deloma skozi gozd, delno pa čez travnike. Ob poti pa so postavljene učne table, ki nam povedo kaj zanimivega o okolici po kateri hodimo. Pot nato pri zasilnem zavetišču preči leso in se nadaljuje po vse bolj redkem gozdu. Le malo za tem se nam odpre lep razgled na Obir z njegovim najvišjim vrhom Ojstrcem / Hochobir. Mestoma zelo široka pot nas nato pripelje na razgledna travna pobočja, kjer se nam odpre pogled proti Sloveniji, kjer opazimo greben Košute. Na višini 2042m pa pridemo do razvalin nekdanje najvišje avstrijske meteorološke postaje.Nadaljujemo naprej in pot nas pripelje na razpotje, kjer se nam priključi pot iz Šajde / Zell-Schaida. Od razpotja do vrha pa imamo le še nekaj minut lahkotne hoje po razglednem vršnem pobočju gore.Izhodišče - Obirska planina 1:00, Obirska planina - Eisenkappler Hütte 30 minut, Eisenkappler Hütte - Ojstrc / Hochobir 1:30.");
  }*/

  @override
  void initState() {
    super.initState();
    //doUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

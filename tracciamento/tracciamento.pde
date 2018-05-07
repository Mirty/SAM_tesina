HashMap <String, Sito> editori_e_3parti; 
HashMap <String, ArrayList <Posizione>> collegamenti_tra_siti;
HashMap <String, Integer> domini_e_colori;
IntDict terze_parti;
int DIAMETRO_DOMINIO = 10;
int DIAMETRO_TERZE_PARTI = 5;
int DISTANZA_TERZE_PARTI = 37;
int BORDO = 30;
// palette di colori -> http://colorhunt.co/c/117601
color STD_COLOR = color (0);
color bg_color = #232931;
color dominio_color = #EEEEEE;
color terze_parti_color = #4ECCA3;
color collegamenti_color = #393E46;
color [] colori_terze_parti_maggiori; 
// OPZIONI AGGIUNTIVE
boolean collegamenti = true; // mostra i collegamenti tra editori e/o terze parti
boolean chi_si_salva = true; // evidenzia gli editori che non sono anche terze parti

void setup () {
  //size (1280, 650);//, P2D);
  fullScreen ();
  background (bg_color);

  if (collegamenti) {
    collegamenti_tra_siti = new HashMap <String, ArrayList <Posizione>> ();
    colori_terze_parti_maggiori = new color [12];
    colori_terze_parti_maggiori [0] = #8dd3c7;
    colori_terze_parti_maggiori [1] = #ffffb3;
    colori_terze_parti_maggiori [2] = #bebada;
    colori_terze_parti_maggiori [3] = #fb8072;
    colori_terze_parti_maggiori [4] = #80b1d3;
    colori_terze_parti_maggiori [5] = #fdb462;
    colori_terze_parti_maggiori [6] = #b3de69;
    colori_terze_parti_maggiori [7] = #fccde5;
    colori_terze_parti_maggiori [8] = #d9d9d9;
    colori_terze_parti_maggiori [9] = #bc80bd;
    colori_terze_parti_maggiori [10] = #ccebc5;
    colori_terze_parti_maggiori [11] = #ffed6f;
    domini_e_colori = new HashMap <String, Integer> ();
  }
  if (chi_si_salva) terze_parti = new IntDict ();

  loadJSON ();
  drawSites ();
  noLoop ();
}

void draw () {
}

void drawSites () {
  // scorro tutti gli editori nel json
  for (String editore : editori_e_3parti.keySet()) {
    Posizione pos = editori_e_3parti.get(editore).posizione;

    int num_terze_parti = editori_e_3parti.get(editore).terze_parti.size ();
    for (int i = 0; i < num_terze_parti; i++) {
      String terza_parte = editori_e_3parti.get(editore).terze_parti.get(i).nome; // prendo il nome di dominio della terza parte considerata
      Posizione pos3p = editori_e_3parti.get(editore).terze_parti.get(i).posizione;
      
      // disegno la linea che unisce il dom con la terza parte
      stroke (collegamenti_color);
      line (pos.x, pos.y, pos3p.x, pos3p.y); 
      noStroke ();
      
      // disegno i cerchietti delle terze parti
      if (collegamenti && domini_e_colori.containsKey(terza_parte)) fill (domini_e_colori.get(terza_parte));
      else fill (terze_parti_color);
      ellipse (pos3p.x, pos3p.y, DIAMETRO_TERZE_PARTI, DIAMETRO_TERZE_PARTI);

      // disegno i collegamenti tra le terze parti
      if (collegamenti) {
        ArrayList <Posizione> posizioni = collegamenti_tra_siti.get(terza_parte); // prendo le posizioni della terza parte
        for (Posizione posizione : posizioni) {
          // se non e' tra le 3 parti + frequenti
          if (collegamenti && domini_e_colori.containsKey(terza_parte)) stroke (domini_e_colori.get(terza_parte), 50);
          else stroke (collegamenti_color, 90);
          line (pos3p.x, pos3p.y, posizione.x, posizione.y);
          noStroke ();
        }
      }
    }
    
    if (chi_si_salva && ! terze_parti.hasKey(editore) && num_terze_parti == 0) {
      fill (255, 0, 255);
      //text (editore, pos.x, pos.y);
    } 
    else 
      if (collegamenti && domini_e_colori.containsKey(editore)) fill (domini_e_colori.get(editore));
      else fill (dominio_color);
    ellipse (pos.x, pos.y, DIAMETRO_DOMINIO, DIAMETRO_DOMINIO);
  }
}

void loadJSON () {
  JSONObject json = loadJSONObject("lightbeamData.json");
  editori_e_3parti = new HashMap <String, Sito> ();
  int counter = 0;

  for (String dominio : (String[]) json.keys().toArray(new String[json.size()])) { // scorro tutti i siti
    if (json.getJSONObject(dominio).getBoolean("firstParty")) { // editore
      Posizione posizione_dominio;
      if (! editori_e_3parti.keySet().contains(dominio)) { // aggiungo il dominio
        posizione_dominio = aggiungiPosizione ();
        editori_e_3parti.put(dominio, new Sito (dominio, posizione_dominio));
      } else {
        posizione_dominio = editori_e_3parti.get(dominio).posizione;
      }
      if (collegamenti) {
        if (! collegamenti_tra_siti.containsKey(dominio)) collegamenti_tra_siti.put (dominio, new ArrayList <Posizione>());
        if (! collegamenti_tra_siti.get(dominio).contains(posizione_dominio)) collegamenti_tra_siti.get(dominio).add(posizione_dominio);
      }
      int num_terze_parti = json.getJSONObject(dominio).getJSONArray("thirdParties").size();
      float angolo = 0.0;
      if (num_terze_parti != 0)  angolo = 360.0 / num_terze_parti;
      for (int i = 0; i < num_terze_parti; i++) {
        String terza_parte = json.getJSONObject(dominio).getJSONArray("thirdParties").getStringArray()[i];
        Posizione posizione = aggiungiPosizione (posizione_dominio, angolo, i);
        editori_e_3parti.get(dominio).terze_parti.add(new Sito(terza_parte, posizione));
        if (collegamenti) {
          if (! collegamenti_tra_siti.containsKey(terza_parte)) collegamenti_tra_siti.put (terza_parte, new ArrayList <Posizione>());
          if (! collegamenti_tra_siti.get(terza_parte).contains(posizione)) collegamenti_tra_siti.get(terza_parte).add(posizione);
        }
        if (chi_si_salva) terze_parti.increment(terza_parte);
      }
      counter ++;
    }
  }

  println ("Hai visitato " + counter + " siti e ti sei connessa con " + (json.keys().size() - counter) + " terze parti");
  //siti.sortValuesReverse(); // ordino dal sito con + terze parti
  counter = 0;
  for (String editore : editori_e_3parti.keySet()) {
    println (counter +1  + ") " + editore + " : " + editori_e_3parti.get(editore).terze_parti.size() + " terze parti ");
    counter ++;
  }

  // setto dei colori alle terze parti maggiormente coinvolte nel tracking
  if (collegamenti) {
    terze_parti.sortValuesReverse();
    counter = 0;
    for (String dominio : terze_parti.keyArray()) {
      if (counter > 11) break;
      else {
        domini_e_colori.put(dominio, colori_terze_parti_maggiori [counter]);
      }
      counter ++;
    }
  }
}

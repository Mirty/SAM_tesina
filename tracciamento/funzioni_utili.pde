boolean intersects(Posizione a, Posizione b) {
  // Funzione che verifica se c'è un'intersezione tra 2 emoji.
  // Restituisce vero quando la somma dei raggi è maggiore della loro distanza.
  return dist(a.x, a.y, b.x, b.y) < DIAMETRO_DOMINIO + (DISTANZA_TERZE_PARTI + DIAMETRO_TERZE_PARTI)*2;
}

Posizione aggiungiPosizione () {
  boolean can_be_created = false;
  Posizione posizione = new Posizione (0, 0);
  while (! can_be_created) {
    float pos_x = random (BORDO * 2, width - BORDO * 2);
    float pos_y = random (BORDO * 2, height - BORDO * 2);
    posizione = new Posizione (pos_x, pos_y);
    boolean intersection = false;
    for (String dominio : editori_e_3parti.keySet()) {
      if (intersects (posizione, editori_e_3parti.get(dominio).posizione)) {
        intersection = true;
        break;
      }
    }
    if (! intersection) can_be_created = true;
  }
  return posizione;
}


Posizione aggiungiPosizione (Posizione posizione_dominio, float angolo, int i) {
  Posizione posizione = new Posizione (0, 0);
  float pos_x = posizione_dominio.x + cos (radians(angolo * i)) * DISTANZA_TERZE_PARTI;
  float pos_y = posizione_dominio.y + sin (radians(angolo * i)) * DISTANZA_TERZE_PARTI;
  posizione = new Posizione (pos_x, pos_y);
  return posizione;
}

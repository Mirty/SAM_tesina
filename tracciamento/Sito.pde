class Sito {
  // proprietà
  String nome;
  ArrayList <Sito> terze_parti;
  Posizione posizione;

  // costruttore
  Sito (String nome, Posizione posizione) {
    this.nome = nome;
    this.terze_parti = new ArrayList <Sito> ();
    this.posizione = posizione;
  }

  // metodi e funzioni
  boolean isMouseOver () {
    int errore = 5;
    return isBetween (mouseX, posizione.x - errore, posizione.x + errore) && isBetween (mouseY, posizione.y - errore, posizione.y + errore);
  }
  
  void whenMouseOver () {
    text (nome, mouseX + 5, mouseY - 10);
  }
}

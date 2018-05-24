# SAM_tesina
progetto per il corso di Sicurezza per Applicazioni Multimediali

Per testare il codice:
1. clonare il mio repository
2. installare l'estensione Firefox Lightbeam sul browser Mozilla Firefox
3. navigare per qualche minuto/ora
4. cliccare sul bottone "Save Data" visibile nell'interfaccia grafica dell'estensione. Verrà scaricato un file JSON chiamato lightbeamData.json
5. inserire il file lightbeamData.json all'interno della cartella data/ del progetto clonato 
6. avviare il codice
7. modificare i valori dei parametri da true a false e viceversa per vedere i diversi risultati della visualizzazione
	1. boolean collegamenti = true; 
	2. boolean chi_si_salva = true; 
	3. boolean collegamenti_colorati = true; 


Possibili problemi: se la visualizzazione è lenta a caricare è probabile che il tuo file JSON contenga una cronologia di navigazione troppo lunga e per questo non è possibile mostrare a video tutte le entità. Prova a resettare i dati da Firefox Lightbeam cliccando sul bottone "Reset Data", naviga per qualche minuto/ora, e riesegui i passi dal punto 4

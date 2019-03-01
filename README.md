# Tracking the trackers


progetto per il corso di Sicurezza per Applicazioni Multimediali

To test the code:
1. clone my repository
2. install the extension Firefox Lightbeam on Mozilla Firefox 
3. surf the net for some minutes/hours
4. click on the button "Save Data" (you can find it in the gui of the extension mentioned above). A JSON file called lightbeamData.json will be downloaded
5. put the lightbeamData.json inside the folder data/ of the cloned project 
6. run the program on Processing
7. you can change these parameters (true or false) to see the different results of the visualisazion:
	1. boolean collegamenti = true; 
	2. boolean chi_si_salva = true; 
	3. boolean collegamenti_colorati = true; 


If you experience a slow visualization then probably the JSON file contains too many data. You can reset Firefox Lightbeam clicking on "Reset Data" button, surf the net for some time and then restart from point 4.

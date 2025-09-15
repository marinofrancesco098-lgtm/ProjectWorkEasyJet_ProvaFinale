--	Visualizzare tutti i voli programmati per '15/09/2025'
SELECT Volo.IDvolo,
       AeroportoPartenza.Città AS CittàPartenza,
       AeroportoArrivo.Città AS CittàArrivo,
       Volo.DataPartenza,
       Volo.OraPartenza,
       Volo.Stato
FROM Volo
JOIN SegmentoTratta ON Volo.IDsegmento = SegmentoTratta.IDsegmento
JOIN Aeroporto AS AeroportoPartenza ON SegmentoTratta.IDaeroportoPartenza = AeroportoPartenza.IDaeroporto
JOIN Aeroporto AS AeroportoArrivo ON SegmentoTratta.IDaeroportoArrivo = AeroportoArrivo.IDaeroporto
WHERE Volo.DataPartenza = '2025-09-15'
  AND Volo.Stato = 'programmato';


--	Ricavi totali per ogni volo
SELECT Volo.IDvolo,
       SUM(Biglietto.Prezzo) AS RicavoTotale
FROM Biglietto
JOIN Volo ON Biglietto.IDvolo = Volo.IDvolo
GROUP BY Volo.IDvolo
ORDER BY RicavoTotale DESC;

--	Servizi extra più acquistati dai passeggeri
SELECT ServizioExtra.Descrizione,
       SUM(BigliettoServizio.Quantità) AS TotaleRichieste
FROM BigliettoServizio
JOIN ServizioExtra ON BigliettoServizio.IDservizio = ServizioExtra.IDservizio
GROUP BY ServizioExtra.Descrizione
ORDER BY TotaleRichieste DESC;

--	Elenco passeggeri che hanno pagamenti in attesa
SELECT Passeggero.Nome,
       Passeggero.Cognome,
       Prenotazione.IDprenotazione,
       Pagamento.Importo,
       Pagamento.DataPagamento
FROM Pagamento
JOIN Prenotazione ON Pagamento.IDprenotazione = Prenotazione.IDprenotazione
JOIN Passeggero ON Prenotazione.IDpasseggero = Passeggero.IDpasseggero
WHERE Pagamento.Esito = 'in attesa';

--	Voli programmati in partenza da un certo aeroporto
SELECT Volo.IDvolo,
       AeroportoPartenza.Nome AS AeroportoPartenza,
       AeroportoArrivo.Nome AS AeroportoArrivo,
       Volo.DataPartenza,
       Volo.OraPartenza
FROM Volo
JOIN SegmentoTratta ON Volo.IDsegmento = SegmentoTratta.IDsegmento
JOIN Aeroporto AS AeroportoPartenza ON SegmentoTratta.IDaeroportoPartenza = AeroportoPartenza.IDaeroporto
JOIN Aeroporto AS AeroportoArrivo ON SegmentoTratta.IDaeroportoArrivo = AeroportoArrivo.IDaeroporto
WHERE Volo.Stato = 'programmato'
ORDER BY Volo.DataPartenza, Volo.OraPartenza;


--  Spesa totale per ogni passeggero (biglietti + servizi extra)
SELECT Passeggero.IDpasseggero,
       Passeggero.Nome,
       Passeggero.Cognome,
       SUM(Biglietto.Prezzo + IFNULL(BigliettoServizio.PrezzoTotale,0)) AS SpesaTotale
FROM Passeggero
JOIN Prenotazione ON Passeggero.IDpasseggero = Prenotazione.IDpasseggero
JOIN Biglietto ON Prenotazione.IDprenotazione = Biglietto.IDprenotazione
LEFT JOIN BigliettoServizio ON Biglietto.IDbiglietto = BigliettoServizio.IDbiglietto
GROUP BY Passeggero.IDpasseggero, Passeggero.Nome, Passeggero.Cognome
ORDER BY SpesaTotale DESC;

--	Numero di voli per ogni tratta
SELECT Tratta.IDtratta,
       Tratta.NomeTratta,
       COUNT(Volo.IDvolo) AS NumeroVoli
FROM Tratta
JOIN SegmentoTratta ON Tratta.IDtratta = SegmentoTratta.IDtratta
JOIN Volo ON SegmentoTratta.IDsegmento = Volo.IDsegmento
GROUP BY Tratta.IDtratta, Tratta.NomeTratta
ORDER BY NumeroVoli DESC;

CREATE DATABASE ProjectWorkEasyJet;

CREATE TABLE Passeggero (
    IDpasseggero INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    DataNascita DATE NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    DocumentoIdentita VARCHAR(30) NOT NULL
);

CREATE TABLE Prenotazione (
    IDprenotazione INT AUTO_INCREMENT PRIMARY KEY,
    IDpasseggero INT NOT NULL,
    IDvolo INT NOT NULL,
    DataPrenotazione DATE NOT NULL,
    Stato ENUM('attiva', 'cancellata', 'modificata'),
    FOREIGN KEY (IDpasseggero) REFERENCES Passeggero(IDpasseggero),
    FOREIGN KEY (IDvolo) REFERENCES Volo(IDvolo)
);

CREATE TABLE Pagamento (
    IDpagamento INT AUTO_INCREMENT PRIMARY KEY,
    IDprenotazione INT NOT NULL,
    Importo DECIMAL(8,2) NOT NULL,
    MetodoPagamento VARCHAR(30) NOT NULL,
    DataPagamento DATE NOT NULL,
    Esito ENUM('confermato', 'negato', 'in attesa'),
    FOREIGN KEY (IDprenotazione) REFERENCES Prenotazione(IDprenotazione)
);

CREATE TABLE Aeroporto (
    IDaeroporto INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Città VARCHAR(50) NOT NULL,
    Nazione VARCHAR(50) NOT NULL,
    CodiceIATA CHAR(3) NOT NULL
);

CREATE TABLE Aereo (
    IDaereo INT AUTO_INCREMENT PRIMARY KEY,
    Modello VARCHAR(50) NOT NULL,
    Capacità INT NOT NULL,
    BaseOperativa VARCHAR(50) NOT NULL
);

CREATE TABLE Tratta (
    IDtratta INT AUTO_INCREMENT PRIMARY KEY,
    NomeTratta VARCHAR(100) NOT NULL,
    NoteOpzionali TEXT
);

CREATE TABLE SegmentoTratta (
    IDsegmento INT AUTO_INCREMENT PRIMARY KEY,
    IDtratta INT NOT NULL,
    IDaeroportoPartenza INT NOT NULL,
    IDaeroportoArrivo INT NOT NULL,
    OrdineSegmento INT NOT NULL,
    DurataPrevista TIME NOT NULL,
    DistanzaKm INT NOT NULL,
    FOREIGN KEY (IDtratta) REFERENCES Tratta(IDtratta),
    FOREIGN KEY (IDaeroportoPartenza) REFERENCES Aeroporto(IDaeroporto),
    FOREIGN KEY (IDaeroportoArrivo) REFERENCES Aeroporto(IDaeroporto)
);

CREATE TABLE Volo (
    IDvolo INT AUTO_INCREMENT PRIMARY KEY,
    IDsegmento INT NOT NULL,
    IDaereo INT NOT NULL,
    DataPartenza DATE NOT NULL,
    OraPartenza TIME NOT NULL,
    Stato ENUM('programmato', 'in ritardo', 'cancellato'),
    FOREIGN KEY (IDsegmento) REFERENCES SegmentoTratta(IDsegmento),
    FOREIGN KEY (IDaereo) REFERENCES Aereo(IDaereo)
);

CREATE TABLE Biglietto (
    IDbiglietto INT AUTO_INCREMENT PRIMARY KEY,
    IDprenotazione INT NOT NULL,
    IDvolo INT NOT NULL,
    Prezzo DECIMAL(8,2) NOT NULL,
    Stato ENUM('valido', 'cancellato', 'modificato'),
    CodiceBiglietto VARCHAR(20) NOT NULL,
    FOREIGN KEY (IDprenotazione) REFERENCES Prenotazione(IDprenotazione),
    FOREIGN KEY (IDvolo) REFERENCES Volo(IDvolo)
);

CREATE TABLE ServizioExtra (
    IDservizio INT AUTO_INCREMENT PRIMARY KEY,
    Descrizione VARCHAR(200) NOT NULL,
    Prezzo DECIMAL(6,2) NOT NULL
);

CREATE TABLE BigliettoServizio (
    IDbiglietto INT NOT NULL,
    IDservizio INT NOT NULL,
    Quantità INT NOT NULL,
    PrezzoTotale DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (IDbiglietto, IDservizio),
    FOREIGN KEY (IDbiglietto) REFERENCES Biglietto(IDbiglietto),
    FOREIGN KEY (IDservizio) REFERENCES ServizioExtra(IDservizio)
);

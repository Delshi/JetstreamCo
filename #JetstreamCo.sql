--Курсовая работа БД и ЭС, Наздрачев В. А., ПМИ-б-о-22-1 


CREATE TABLE Cities (
    CityID serial UNIQUE NOT NULL PRIMARY KEY,
    City varchar UNIQUE NOT NULL CHECK(LENGTH(City) > 0 AND LENGTH(City) <= 20)
);

CREATE TABLE Streets (
    StreetID serial UNIQUE NOT NULL PRIMARY KEY,
    Street varchar UNIQUE NOT NULL CHECK(LENGTH(Street) > 0 AND LENGTH(Street) <= 20)
);

CREATE TABLE Client (
    CliID SERIAL PRIMARY KEY,
    ClientDocumentsID integer UNIQUE NOT NULL CHECK(ClientDocumentsID > 0),
    FNameCli varchar NOT NULL CHECK(LENGTH(FNameCli) BETWEEN 1 and 65),
    LNameCli varchar NOT NULL CHECK(LENGTH(LNameCli) BETWEEN 1 and 65),
    FaNameCli varchar CHECK(LENGTH(FaNameCli) >= 0 AND LENGTH(FaNameCli) <= 64),
    RegCityID integer DEFAULT NULL CHECK(RegCityID IS NULL OR RegCityID > 0),
    RegStreetID integer DEFAULT NULL CHECK(RegStreetID IS NULL OR RegStreetID > 0),
    RegHouse integer DEFAULT NULL CHECK(RegHouse IS NULL OR RegHouse > 0),
    RegApartment integer DEFAULT NULL CHECK (RegApartment IS NULL OR RegApartment > 0),
    ResCityID integer DEFAULT NULL CHECK(ResCityID IS NULL OR ResCityID > 0),
    ResStreetID integer DEFAULT NULL CHECK(ResStreetID IS NULL OR ResStreetID > 0),
    ResHouse integer DEFAULT NULL CHECK(ResHouse IS NULL OR ResHouse > 0),
    ResApartment integer DEFAULT NULL CHECK (ResApartment IS NULL OR ResApartment > 0),
    PhoneCli varchar UNIQUE NOT NULL CHECK(LENGTH(PhoneCli) = 11 AND PhoneCli ~ '^[7][0-9]{10}$'),
    isDeleted boolean DEFAULT false,
    CHECK((RegCityID IS NOT NULL AND RegStreetID IS NOT NULL AND RegHouse IS NOT NULL) 
    OR 
    (ResCityID IS NOT NULL AND ResStreetID IS NOT NULL AND ResHouse IS NOT NULL))
);

CREATE TABLE MainPassesCli (
    MainPassCliID SERIAL PRIMARY KEY UNIQUE NOT NULL,
    MainPassNumCli varchar NOT NULL UNIQUE CHECK(LENGTH(MainPassNumCli) = 6),
    MainPassSeriesCli varchar NOT NULL CHECK(LENGTH(MainPassSeriesCli) = 4),
    MainPassDateCli date NOT NULL CHECK(MainPassDateCli <= CURRENT_DATE),
    isDeleted boolean DEFAULT false
);

CREATE TABLE InterPassesCli (
    InterPassCliID serial PRIMARY KEY UNIQUE NOT NULL,
    InterPassNumCli varchar NOT NULL UNIQUE CHECK(LENGTH(InterPassNumCli) = 6),
    InterPassSeriesCli varchar NOT NULL CHECK(LENGTH(InterPassSeriesCli) = 4),
    InterPassDateCli date NOT NULL CHECK(InterPassDateCli <= CURRENT_DATE),
    isDeleted boolean DEFAULT false
);

CREATE TABLE SnilsCli (
    SnilsCliID SERIAL PRIMARY KEY UNIQUE NOT NULL,
    SnilsCli varchar NOT NULL UNIQUE CHECK(LENGTH(SnilsCli) = 14 AND SnilsCli ~ '^[0-9]{3}-[0-9]{3}-[0-9]{3} [0-9]{2}$'),
    isDeleted boolean DEFAULT false
);

CREATE TABLE InnCli (
    InnCliID SERIAL PRIMARY KEY UNIQUE NOT NULL,
    InnCli varchar UNIQUE NOT NULL CHECK(LENGTH(InnCli) = 12),
    isDeleted boolean DEFAULT false
);

CREATE TABLE ClientDocuments (
    ClientDocumentsID SERIAL UNIQUE NOT NULL PRIMARY KEY,
    MainPassCliID integer UNIQUE NOT NULL CHECK(MainPassCliID > 0),
    InterPassCliID integer UNIQUE NOT NULL CHECK(InterPassCliID > 0),
    SnilsCliID integer UNIQUE NOT NULL CHECK(SnilsCliID > 0),
    InnCliID integer UNIQUE NOT NULL CHECK(InnCliID > 0),
    isDeleted boolean DEFAULT false
);


CREATE TABLE Employee (
    EmpID SERIAL PRIMARY KEY,
    StreetID integer NOT NULL CHECK(StreetID > 0),
    CityID integer NOT NULL CHECK(CityID > 0),
    House integer NOT NULL CHECK(House > 0),
    Apartment integer CHECK(Apartment IS NULL OR Apartment > 0),
    EmployeeDocumentsID integer UNIQUE NOT NULL CHECK(EmployeeDocumentsID > 0),
    FNameEmp varchar NOT NULL CHECK(LENGTH(FNameEmp) BETWEEN 1 and 65),
    LNameEmp varchar NOT NULL CHECK(LENGTH(LNameEmp) BETWEEN 1 and 65),
    FaNameEmp varchar CHECK(LENGTH(FaNameEmp) >= 0 AND LENGTH(FaNameEmp) <= 64),
    PhoneEmp varchar UNIQUE NOT NULL CHECK(LENGTH(PhoneEmp) = 11 AND PhoneEmp ~ '^[7][0-9]{10}$'),
    EmpRoleID integer NOT NULL,
    isDeleted boolean DEFAULT false
);

CREATE TABLE EmpRole (
    EmpRoleID SERIAL PRIMARY KEY,
    EmpRole varchar NOT NULL UNIQUE
);

CREATE TABLE PassesEmp (
    PassEmpID SERIAL PRIMARY KEY,
    PassNumEmp varchar UNIQUE NOT NULL CHECK(LENGTH(PassNumEmp) = 6),
    PassSeriesEmp varchar NOT NULL CHECK(LENGTH(PassSeriesEmp) = 4),
    PassDateEmp date NOT NULL CHECK(PassDateEmp <= CURRENT_DATE),
    isDeleted boolean DEFAULT false
);

CREATE TABLE SnilsEmp (
    SnilsEmpID SERIAL PRIMARY KEY,
    SnilsEmp varchar UNIQUE NOT NULL CHECK(LENGTH(SnilsEmp) = 14 AND SnilsEmp ~ '^[0-9]{3}-[0-9]{3}-[0-9]{3} [0-9]{2}$'),
    isDeleted boolean DEFAULT false
);

CREATE TABLE InnEmp (
    InnEmpID SERIAL PRIMARY KEY,
    InnEmp varchar UNIQUE NOT NULL CHECK(LENGTH(InnEmp) = 12),
    isDeleted boolean DEFAULT false
);

CREATE TABLE WrkBooksEmp (
    WrkEmpID SERIAL PRIMARY KEY,
    WrkNumEmp varchar UNIQUE NOT NULL CHECK(LENGTH(WrkNumEmp) = 7),
    WrkSeriesEmp varchar NOT NULL CHECK(LENGTH(WrkSeriesEmp) >= 4 AND LENGTH(WrkSeriesEmp) <= 10 AND WrkSeriesEmp ~ '^((TK|

AK){1}-[IVX]{1,7})$'),
    isDeleted boolean DEFAULT false
);

CREATE TABLE EmployeeDocuments (
    EmployeeDocumentsID SERIAL PRIMARY KEY,
    PassEmpID integer UNIQUE NOT NULL CHECK(PassEmpID > 0),
    SnilsEmpID integer UNIQUE NOT NULL CHECK(SnilsEmpID > 0),
    InnEmpID integer UNIQUE NOT NULL CHECK(InnEmpID > 0),
    WrkEmpID integer UNIQUE NOT NULL CHECK(WrkEmpID > 0),
    isDeleted boolean DEFAULT false
);

CREATE TABLE Tariff (
    TariffID serial PRIMARY KEY,
    TariffDetailID integer NOT NULL CHECK(TariffDetailID > 0),
    PartnerID integer NOT NULL CHECK(PartnerID > 0),
    TariffTitle varchar UNIQUE NOT NULL CHECK(LENGTH(TariffTitle) BETWEEN 1 AND 193),
    isDeleted boolean DEFAULT false
);

CREATE TABLE TariffDetails (
    TariffDetailID SERIAL PRIMARY KEY,
    TariffType varchar NOT NULL CHECK(LENGTH(TariffType) BETWEEN 1 AND 65),
    TariffPrice integer NOT NULL CHECK(TariffPrice >= 0),
    TariffLocating varchar NOT NULL CHECK(LENGTH(TariffLocating) BETWEEN 1 AND 32),
    TariffInsurance bool NOT NULL,
    isDeleted boolean DEFAULT false
);

CREATE TABLE Partner (
    PartnerID SERIAL PRIMARY KEY,
    PartnerOrgTypeID integer NOT NULL CHECK(PartnerOrgTypeID > 0),
    PartnerTitle varchar UNIQUE NOT NULL CHECK(LENGTH(PartnerTitle) BETWEEN 1 AND 65),
    isDeleted boolean DEFAULT false
);

CREATE TABLE PartnerOrgTypes (
    PartnerOrgTypeID SERIAL PRIMARY KEY,
    PartnerOrgType varchar UNIQUE NOT NULL CHECK(LENGTH(PartnerOrgType) BETWEEN 1 AND 9)
);

CREATE TABLE PartnerContacts (
    ContactID SERIAL PRIMARY KEY,
    PartnerID integer NOT NULL,
    PartnerPhone varchar UNIQUE NOT NULL CHECK(LENGTH(PartnerPhone) > 0),
    PartnerEmail varchar UNIQUE NOT NULL CHECK(LENGTH(PartnerEmail) > 0 AND PartnerEmail ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    isDeleted boolean DEFAULT false
);

CREATE TABLE AdditionalService (
    ServiceID serial PRIMARY KEY,
    PartnerID integer NOT NULL CHECK(PartnerID > 0),
    ServiceDescription text NOT NULL,
    ServicePrice integer NOT NULL CHECK(ServicePrice >= 0),
    isDeleted boolean DEFAULT false
);

CREATE TABLE Contract (
    TreatyID SERIAL PRIMARY KEY,
    ServiceID integer CHECK(ServiceID IS NULL OR ServiceID > 0),
    CliID integer NOT NULL CHECK(CliID > 0),
    EmpID integer NOT NULL CHECK(EmpID > 0),
    PartnerID integer NOT NULL CHECK(PartnerID > 0),
    TariffID integer NOT NULL CHECK(TariffID > 0),
    TreatySignDate date NOT NULL DEFAULT CURRENT_DATE,
    TreatyStartDate date NOT NULL CHECK(TreatyStartDate >= TreatySignDate),
    TreatyStopDate date NOT NULL CHECK(TreatyStopDate >= TreatyStartDate),
    TreatyCost integer CHECK(TreatyCost >= 0),
    Comment text
);


ALTER TABLE Client ADD FOREIGN KEY (RegCityID) REFERENCES Cities (CityID);

ALTER TABLE Client ADD FOREIGN KEY (RegStreetID) REFERENCES Streets (StreetID);

ALTER TABLE Client ADD FOREIGN KEY (ResCityID) REFERENCES Cities (CityID);

ALTER TABLE Client ADD FOREIGN KEY (ResStreetID) REFERENCES Streets (StreetID);

ALTER TABLE ClientDocuments ADD FOREIGN KEY (MainPassCliID) REFERENCES MainPassesCli (MainPassCliID);

ALTER TABLE ClientDocuments ADD FOREIGN KEY (InterPassCliID) REFERENCES InterPassesCli (InterPassCliID);

ALTER TABLE ClientDocuments ADD FOREIGN KEY (SnilsCliID) REFERENCES SnilsCli (SnilsCliID);

ALTER TABLE ClientDocuments ADD FOREIGN KEY (InnCliID) REFERENCES InnCli (InnCliID);

ALTER TABLE Client ADD FOREIGN KEY (ClientDocumentsID) REFERENCES ClientDocuments (ClientDocumentsID);

ALTER TABLE Employee ADD FOREIGN KEY (CityID) REFERENCES Cities (CityID);

ALTER TABLE Employee ADD FOREIGN KEY (StreetID) REFERENCES Streets (StreetID);

ALTER TABLE EmployeeDocuments ADD FOREIGN KEY (PassEmpID) REFERENCES PassesEmp (PassEmpID);

ALTER TABLE EmployeeDocuments ADD FOREIGN KEY (SnilsEmpID) REFERENCES SnilsEmp (SnilsEmpID);

ALTER TABLE EmployeeDocuments ADD FOREIGN KEY (InnEmpID) REFERENCES InnEmp  (InnEmpID)  ;

ALTER TABLE Employee ADD FOREIGN KEY (EmployeeDocumentsID) REFERENCES EmployeeDocuments (EmployeeDocumentsID);

ALTER TABLE EmployeeDocuments ADD FOREIGN KEY (WrkEmpID) REFERENCES WrkBooksEmp (WrkEmpID);

ALTER TABLE Employee ADD FOREIGN KEY (EmpRoleID) REFERENCES EmpRole (EmpRoleID);

ALTER TABLE Tariff ADD FOREIGN KEY (TariffDetailID) REFERENCES TariffDetails (TariffDetailID);

ALTER TABLE AdditionalService ADD FOREIGN KEY (PartnerID) REFERENCES Partner (PartnerID);

ALTER TABLE PartnerContacts ADD FOREIGN KEY (PartnerID) REFERENCES Partner (PartnerID);

ALTER TABLE Tariff ADD FOREIGN KEY (PartnerID) REFERENCES Partner (PartnerID);

ALTER TABLE Partner ADD FOREIGN KEY (PartnerOrgTypeID) REFERENCES PartnerOrgTypes (PartnerOrgTypeID);

ALTER TABLE Contract ADD FOREIGN KEY (ServiceID) REFERENCES AdditionalService (ServiceID);

ALTER TABLE Contract ADD FOREIGN KEY (CliID) REFERENCES Client (CliID);

ALTER TABLE Contract ADD FOREIGN KEY (EmpID) REFERENCES Employee (EmpID);

ALTER TABLE Contract ADD FOREIGN KEY (PartnerID) REFERENCES Partner (PartnerID);

ALTER TABLE Contract ADD FOREIGN KEY (TariffID) REFERENCES Tariff (TariffID);









--Получение данных нужного клиента
CREATE OR REPLACE FUNCTION get_client_data(client_id_input INTEGER)
RETURNS TABLE (
    "ID клиента" INTEGER,
    "Фамилия" VARCHAR,
    "Имя" VARCHAR,
    "Отчество" VARCHAR,
    "Телефон" VARCHAR,
    "Город регистрации" VARCHAR,
    "Улица регистрации" VARCHAR,
    "Дом регистрации" INTEGER,
    "Квартира регистрации" INTEGER,
    "Город проживания" VARCHAR,
    "Улица проживания" VARCHAR,
    "Дом проживания" INTEGER,
    "Квартира проживания" INTEGER,
    "ID документов" INTEGER,
    "Номер основного паспорта" VARCHAR,
    "Серия основного паспорта" VARCHAR,
    "Дата выдачи основного паспорта" DATE,
    "Номер загранпаспорта" VARCHAR,
    "Серия загранпаспорта" VARCHAR,
    "Дата загранпаспорта" DATE,
    "СНИЛС" VARCHAR,
    "ИНН" VARCHAR
) AS $$
BEGIN

    RETURN QUERY
    
    SELECT 
        c.CliID AS "ID клиента",
        c.LNameCli AS "Фамилия",
        c.FNameCli AS "Имя",
        c.FaNameCli AS "Отчество",
        c.PhoneCli AS "Телефон",
        rc.City AS "Город регистрации",
        rs.Street AS "Улица регистрации",
        c.RegHouse AS "Дом регистрации",
        c.RegApartment AS "Квартира регистрации",
        rrc.City AS "Город проживания",
        rrs.Street AS "Улица проживания",
        c.ResHouse AS "Дом проживания",
        c.ResApartment AS "Квартира проживания",
        c.ClientDocumentsID AS "ID документов",
        mp.MainPassNumCli AS "Номер основного паспорта",
        mp.MainPassSeriesCli AS "Серия основного паспорта",
        mp.MainPassDateCli AS "Дата выдачи основного паспорта",
        ip.InterPassNumCli AS "Номер внутреннего паспорта",
        ip.InterPassSeriesCli AS "Серия внутреннего паспорта",
        ip.InterPassDateCli AS "Дата выдачи внутреннего паспорта",
        s.SnilsCli AS "СНИЛС",
        i.InnCli AS "ИНН"
    FROM 
        Client c
        LEFT JOIN Cities rc ON c.RegCityID = rc.CityID
        LEFT JOIN Cities rrc ON c.ResCityID = rrc.CityID
        LEFT JOIN Streets rs ON c.RegStreetID = rs.StreetID
        LEFT JOIN Streets rrs ON c.ResStreetID = rrs.StreetID
        LEFT JOIN ClientDocuments cd ON c.ClientDocumentsID = cd.ClientDocumentsID
        LEFT JOIN MainPassesCli mp ON cd.MainPassCliID = mp.MainPassCliID
        LEFT JOIN InterPassesCli ip ON cd.InterPassCliID = ip.InterPassCliID
        LEFT JOIN SnilsCli s ON cd.SnilsCliID = s.SnilsCliID
        LEFT JOIN InnCli i ON cd.InnCliID = i.InnCliID
    WHERE 
        c.CliID = client_id_input
        AND c.isDeleted = false
        AND cd.isDeleted = false
        AND mp.isDeleted = false
        AND ip.isDeleted = false
        AND s.isDeleted = false
        AND i.isDeleted = false;


    IF NOT EXISTS (SELECT 1 FROM Client WHERE client.cliid = client_id_input AND isDeleted = FALSE) THEN
        RAISE EXCEPTION 'Клиент № % не найден.', client_id_input;
    END IF;

END;
$$ LANGUAGE plpgsql;



-- Получение всех контрактов нужного партнера
CREATE OR REPLACE FUNCTION get_partner_contracts(partner_id INTEGER)
RETURNS TABLE (
    "ID партнера" INTEGER,
    "ID договора" INTEGER,
    "Цена договора" INTEGER,
    "Дата подписания договора" DATE,
    "Дата начала договора" DATE,
    "Дата окончания договора" DATE,
    "ID тарифа" INTEGER,
    "Название тарифа" VARCHAR,
    "Цена тарифа" INTEGER,
    "ID дополнительной услуги" INTEGER,
    "Описание дополнительной услуги" TEXT,
    "Цена дополнительной услуги" INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        c.PartnerID AS "ID партнера",
        c.TreatyID AS "ID договора",
        c.TreatyCost AS "Цена договора",
        c.TreatySignDate AS "Дата подписания договора",
        c.TreatyStartDate AS "Дата начала договора",
        c.TreatyStopDate AS "Дата окончания договора",
        t.TariffID AS "ID тарифа",
        t.TariffTitle AS "Название тарифа",
        td.TariffPrice AS "Цена тарифа",
        a.ServiceID AS "ID дополнительной услуги",
        a.ServiceDescription AS "Описание дополнительной услуги",
        a.ServicePrice AS "Цена дополнительной услуги"
    FROM
        Contract c
        LEFT JOIN Tariff t ON c.TariffID = t.TariffID
        LEFT JOIN TariffDetails td ON t.TariffDetailID = td.TariffDetailID
        LEFT JOIN AdditionalService a ON c.ServiceID = a.ServiceID
    WHERE
        c.PartnerID = partner_id
        AND c.TariffID IS NOT NULL
        AND t.isDeleted = false
        AND td.isDeleted = false
        AND (a.isDeleted = false OR a.ServiceID IS NULL);

    IF NOT EXISTS (SELECT 1 FROM Partner WHERE partner.PartnerID = partner_id) THEN
        RAISE EXCEPTION 'Партнер № % не найден.', partner_id; 
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Contract WHERE Contract.PartnerID = partner_id) THEN
        RAISE EXCEPTION 'У партнера № % нет контрактов.', partner_id; 
    END IF;

END;
$$ LANGUAGE plpgsql;



--Получение актуального статуса нужного контракта
CREATE OR REPLACE FUNCTION get_contract_status(contract_id INTEGER)
RETURNS TABLE (
    "ID договора" INTEGER,
    "Дата подписания договора" DATE,
    "Дата начала договора" DATE,
    "Дата окончания договора" DATE,
    "Статус" TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.TreatyID AS "ID договора",
        c.TreatySignDate AS "Дата подписания договора",
        c.TreatyStartDate AS "Дата начала договора",
        c.TreatyStopDate AS "Дата окончания договора",
        CASE
            WHEN c.TreatyStopDate < CURRENT_DATE THEN 'Завершён'
            WHEN c.TreatyStartDate > CURRENT_DATE THEN 'Ожидает начала'
            ELSE 'Активен'
        END AS "Статус"
    FROM
        Contract c
    WHERE
        c.TreatyID = contract_id;

    IF NOT EXISTS (SELECT 1 FROM Contract WHERE Contract.TreatyID = contract_id) THEN
        RAISE EXCEPTION 'Договор № % не найден.', contract_id; 
    END IF;

END;
$$ LANGUAGE plpgsql;



-- Получение данных о партнере
CREATE OR REPLACE FUNCTION get_partner_info(partner_id INTEGER)
RETURNS TABLE (
    "ID партнера" INTEGER,
    "Тип партнера" VARCHAR,
    "Название партнера" VARCHAR,
    "Количество тарифов" BIGINT,
    "Количество дополнительных услуг" BIGINT,
    "Общее количество контрактов" BIGINT,
    "Контакты" TEXT
) AS $$
BEGIN
    RETURN QUERY
    WITH PartnerData AS (
        SELECT 
            p.PartnerID AS "ID партнера",
            pot.PartnerOrgType AS "Тип партнера",
            p.PartnerTitle AS "Название партнера",
            COUNT(DISTINCT t.TariffID) AS "Количество тарифов",
            COUNT(DISTINCT a.ServiceID) AS "Количество дополнительных услуг",
            COUNT(DISTINCT c.TreatyID) AS "Общее количество контрактов"
        FROM 
            Partner p
            LEFT JOIN PartnerOrgTypes pot ON p.PartnerOrgTypeID = pot.PartnerOrgTypeID
            LEFT JOIN Tariff t ON p.PartnerID = t.PartnerID AND t.isDeleted = false
            LEFT JOIN AdditionalService a ON p.PartnerID = a.PartnerID AND a.isDeleted = false
            LEFT JOIN Contract c ON p.PartnerID = c.PartnerID
        WHERE 
            p.PartnerID = partner_id AND p.isDeleted = false
        GROUP BY 
            p.PartnerID, pot.PartnerOrgType, p.PartnerTitle
    ),
    PartnerContactsAggregated AS (
        SELECT 
            pc.PartnerID,
            STRING_AGG(pc.PartnerPhone || ' ' || pc.PartnerEmail, E'\n' ORDER BY pc.ContactID) AS "Контакты"
        FROM 
            PartnerContacts pc
        WHERE 
            pc.PartnerID = partner_id AND pc.isDeleted = false
        GROUP BY 
            pc.PartnerID
    )
    SELECT 
        pd."ID партнера",
        pd."Тип партнера",
        pd."Название партнера",
        pd."Количество тарифов",
        pd."Количество дополнительных услуг",
        pd."Общее количество контрактов",
        pca."Контакты"
    FROM 
        PartnerData pd
    LEFT JOIN 
        PartnerContactsAggregated pca ON pd."ID партнера" = pca.PartnerID;

    IF NOT EXISTS (SELECT 1 FROM Partner WHERE Partner.PartnerID = partner_id) THEN
        RAISE EXCEPTION 'Партнер № % не найден.', partner_id;
    END IF;
END;
$$ LANGUAGE plpgsql;



-- Получение информации о тарифе
CREATE OR REPLACE FUNCTION get_tariff_info(tariff_id INTEGER)
RETURNS TABLE (
    "ID тарифа" INTEGER,
    "Название тарифа" VARCHAR,
    "Тип тарифа" VARCHAR,
    "Цена тарифа" INTEGER,
    "Местоположение тарифа" VARCHAR,
    "Страхование" BOOLEAN,
    "Название партнёра" VARCHAR,
    "Тип партнёра" VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        t.TariffID AS "ID тарифа",
        t.TariffTitle AS "Название тарифа",
        td.TariffType AS "Тип тарифа",
        td.TariffPrice AS "Цена тарифа",
        td.TariffLocating AS "Местоположение тарифа",
        td.TariffInsurance AS "Страхование включено",
        p.PartnerTitle AS "Название партнёра",
        pot.PartnerOrgType AS "Тип партнёра"
    FROM 
        Tariff t
        LEFT JOIN TariffDetails td ON t.TariffDetailID = td.TariffDetailID AND td.isDeleted = false
        LEFT JOIN Partner p ON t.PartnerID = p.PartnerID AND p.isDeleted = false
        LEFT JOIN PartnerOrgTypes pot ON p.PartnerOrgTypeID = pot.PartnerOrgTypeID
    WHERE 
        t.TariffID = tariff_id AND t.isDeleted = false;

    IF NOT EXISTS (SELECT 1 FROM Tariff WHERE Tariff.TariffID = tariff_id) THEN
        RAISE EXCEPTION 'Тариф № % не найден.', tariff_id;
    END IF;
END;
$$ LANGUAGE plpgsql;



--Получение активных договоров клиента
CREATE OR REPLACE FUNCTION active_client_contracts(client_id INTEGER)
RETURNS TABLE (
    "ID договора" INTEGER,
    "Дата подписания договора" DATE,
    "Дата начала договора" DATE,
    "Дата окончания договора" DATE,
    "Название тарифа" VARCHAR,
    "Название партнёра" VARCHAR,
    "Цена договора" INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.TreatyID AS "ID договора",
        c.TreatySignDate AS "Дата подписания договора",
        c.TreatyStartDate AS "Дата начала договора",
        c.TreatyStopDate AS "Дата окончания договора",
        t.TariffTitle AS "Название тарифа",
        p.PartnerTitle AS "Название партнёра",
        c.TreatyCost AS "Цена договора"
    FROM 
        Contract c
        LEFT JOIN Tariff t ON c.TariffID = t.TariffID
        LEFT JOIN Partner p ON c.PartnerID = p.PartnerID
    WHERE 
        c.CliID = client_id
        AND c.TreatyStopDate >= CURRENT_DATE
        AND c.TreatyStartDate <= CURRENT_DATE;
    
    IF NOT EXISTS (SELECT 1 FROM Client WHERE Client.CliID = client_id) THEN
        RAISE EXCEPTION 'Клиент № % не найден.', client_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Contract WHERE Contract.CliID = client_id 
						AND (Contract.TreatyStopDate >= CURRENT_DATE 
						OR Contract.TreatyStartDate <= CURRENT_DATE)) THEN
        RAISE EXCEPTION 'У клиента № % нет активных договоров.', client_id;
    END IF;

END;
$$ LANGUAGE plpgsql;



--Получение списка дополнительных услуг партнера
CREATE OR REPLACE FUNCTION get_partner_additional_services(partner_id INTEGER)
RETURNS TABLE (
    "ID услуги" INTEGER,
    "Описание услуги" TEXT,
    "Цена услуги" INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        a.ServiceID AS "ID услуги",
        a.ServiceDescription AS "Описание услуги",
        a.ServicePrice AS "Цена услуги"
    FROM 
        AdditionalService a
    WHERE 
        a.PartnerID = partner_id
        AND a.isDeleted = false;

    IF NOT EXISTS (SELECT 1 FROM Partner WHERE Partner.PartnerID = partner_id) THEN
        RAISE EXCEPTION 'Партнер № % не найден.', partner_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM AdditionalService WHERE AdditionalService.PartneriD = partner_id) THEN
        RAISE EXCEPTION 'У партнера № % нет дополнительных услуг.', partner_id;
    END IF;
    
END;
$$ LANGUAGE plpgsql;



-- Получение количества удаленных клиентов
CREATE OR REPLACE FUNCTION count_deleted_clients()
RETURNS INTEGER AS $$
DECLARE
    deleted_clients_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO deleted_clients_count
    FROM Client
    WHERE isDeleted = true;

    RETURN deleted_clients_count;
END;
$$ LANGUAGE plpgsql;



-- Подсчет количества клиентов
CREATE OR REPLACE FUNCTION count_all_clients()
RETURNS INTEGER AS $$
DECLARE
    total_clients_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO total_clients_count
    FROM Client WHERE isDeleted = FALSE;

    RETURN total_clients_count;
END;
$$ LANGUAGE plpgsql;



--Подсчет количества сотрудников
CREATE OR REPLACE FUNCTION count_all_employees()
RETURNS INTEGER AS $$
DECLARE
    total_employees_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO total_employees_count
    FROM Employee WHERE isDeleted = FALSE;

    RETURN total_employees_count;
END;
$$ LANGUAGE plpgsql;



--Подсчет количества уволенных сотрудников
CREATE OR REPLACE FUNCTION count_deleted_employees()
RETURNS INTEGER AS $$
DECLARE
    total_employees_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO total_employees_count
    FROM Employee WHERE isDeleted = TRUE;

    RETURN total_employees_count;
END;
$$ LANGUAGE plpgsql;



-- Получение всех данных о сотруднике
CREATE OR REPLACE FUNCTION get_employee_data(employee_id_input INTEGER)
RETURNS TABLE (
    "ID сотрудника" INTEGER,
    "Фамилия" VARCHAR,
    "Имя" VARCHAR,
    "Отчество" VARCHAR,
    "Телефон" VARCHAR,
    "Город проживания" VARCHAR,
    "Улица проживания" VARCHAR,
    "Дом проживания" INTEGER,
    "Квартира проживания" INTEGER,
    "Должность" VARCHAR,
    "ID документов" INTEGER,
    "Номер паспорта" VARCHAR,
    "Серия паспорта" VARCHAR,
    "Дата выдачи паспорта" DATE,
    "СНИЛС" VARCHAR,
    "ИНН" VARCHAR,
    "Номер трудовой книжки" VARCHAR,
    "Серия трудовой книжки" VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    
    SELECT 
        e.EmpID AS "ID сотрудника",
        e.LNameEmp AS "Фамилия",
        e.FNameEmp AS "Имя",
        e.FaNameEmp AS "Отчество",
        e.PhoneEmp AS "Телефон",
        c.City AS "Город проживания",
        s.Street AS "Улица проживания",
        e.House AS "Дом проживания",
        e.Apartment AS "Квартира проживания",
        r.EmpRole AS "Должность",
        e.EmployeeDocumentsID AS "ID документов",
        p.PassNumEmp AS "Номер паспорта",
        p.PassSeriesEmp AS "Серия паспорта",
        p.PassDateEmp AS "Дата выдачи паспорта",
        sn.SnilsEmp AS "СНИЛС",
        i.InnEmp AS "ИНН",
        w.WrkNumEmp AS "Номер трудовой книжки",
        w.WrkSeriesEmp AS "Серия трудовой книжки"
    FROM 
        Employee e
        LEFT JOIN Cities c ON e.CityID = c.CityID
        LEFT JOIN Streets s ON e.StreetID = s.StreetID
        LEFT JOIN EmpRole r ON e.EmpRoleID = r.EmpRoleID
        LEFT JOIN EmployeeDocuments ed ON e.EmployeeDocumentsID = ed.EmployeeDocumentsID
        LEFT JOIN PassesEmp p ON ed.PassEmpID = p.PassEmpID
        LEFT JOIN SnilsEmp sn ON ed.SnilsEmpID = sn.SnilsEmpID
        LEFT JOIN InnEmp i ON ed.InnEmpID = i.InnEmpID
        LEFT JOIN WrkBooksEmp w ON ed.WrkEmpID = w.WrkEmpID
    WHERE 
        e.EmpID = employee_id_input
        AND e.isDeleted = FALSE
        AND ed.isDeleted = FALSE
        AND p.isDeleted = FALSE
        AND sn.isDeleted = FALSE
        AND i.isDeleted = FALSE
        AND w.isDeleted = FALSE;

    IF NOT EXISTS (
        SELECT 1 
        FROM Employee 
        WHERE EmpID = employee_id_input 
        AND isDeleted = FALSE
    ) THEN
        RAISE EXCEPTION 'Сотрудник № % не найден.', employee_id_input;
    END IF;

END;
$$ LANGUAGE plpgsql;



--Количество подписанных с определенным клиентом контрактов, еще не начавших действие
CREATE OR REPLACE FUNCTION count_pending_contracts(client_id_input INTEGER)
RETURNS INTEGER AS $$
DECLARE
    pending_contracts_count INTEGER;
BEGIN
    -- Подсчёт количества подписанных контрактов, которые ещё не начались
    SELECT COUNT(*)
    INTO pending_contracts_count
    FROM Contract c
    WHERE 
        c.CliID = client_id_input
        AND c.TreatyStartDate > CURRENT_DATE
        AND c.TreatySignDate <= CURRENT_DATE
        AND c.TreatyStopDate >= c.TreatyStartDate;

    IF NOT EXISTS (SELECT 1 FROM Client WHERE client.cliid = client_id_input AND isDeleted = FALSE) THEN
        RAISE EXCEPTION 'Клиент № % не найден.', client_id_input;
    END IF;

    RETURN pending_contracts_count;
END;
$$ LANGUAGE plpgsql;



--Количество поездок за последние N месяцев
CREATE OR REPLACE FUNCTION count_trips_last_n_months(n_months INTEGER)
RETURNS INTEGER AS $$
DECLARE
    trips_count INTEGER;
    start_date DATE;
BEGIN
    start_date := CURRENT_DATE - (n_months * INTERVAL '1 month');

    SELECT COUNT(*)
    INTO trips_count
    FROM Contract c
    WHERE 
        c.TreatyStopDate >= start_date
        AND c.TreatyStartDate <= CURRENT_DATE;

    IF NOT FOUND THEN
        trips_count := 0;
    END IF;

    RETURN trips_count;
END;
$$ LANGUAGE plpgsql;



--Средняя стоимость поездок за последние N месяцев
CREATE OR REPLACE FUNCTION average_trip_cost_last_n_months(n_months INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    avg_cost NUMERIC;
    start_date DATE;
BEGIN
    start_date := CURRENT_DATE - (n_months * INTERVAL '1 month');

    SELECT AVG(c.TreatyCost)
    INTO avg_cost
    FROM Contract c
    WHERE 
        c.TreatyStopDate >= start_date
        AND c.TreatyStartDate <= CURRENT_DATE;

    IF avg_cost IS NULL THEN
        RETURN 0;
    END IF;

    RETURN avg_cost;
END;
$$ LANGUAGE plpgsql;



--Вывести клиентов с N поездок
CREATE OR REPLACE FUNCTION get_clients_with_n_trips(n_trips INTEGER)
RETURNS TABLE (
    "ID клиента" INTEGER,
    "Фамилия клиента" VARCHAR,
    "Имя клиента" VARCHAR,
    "Отчество клиента" VARCHAR,
    "Количество поездок" BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.CliID AS "ID клиента",
        c.LNameCli AS "Фамилия клиента",
        c.FNameCli AS "Имя клиента",
        c.FaNameCli AS "Отчество клиента",
        COUNT(ctr.TreatyID) AS "Количество поездок"
    FROM 
        Client c
        LEFT JOIN Contract ctr ON c.CliID = ctr.CliID
    WHERE 
        ctr.TreatyStartDate <= CURRENT_DATE
        AND ctr.TreatyStopDate <= CURRENT_DATE
        AND c.isDeleted = FALSE
    GROUP BY 
        c.CliID, c.LNameCli, c.FNameCli, c.FaNameCli
    HAVING 
        COUNT(ctr.TreatyID) = n_trips;
END;
$$ LANGUAGE plpgsql;



--Количество договоров по конкретному тур. пакету (тарифу)
CREATE OR REPLACE FUNCTION get_contracts_by_tariff(tariff_id_input INTEGER)
RETURNS TABLE (
    contract_count INTEGER,
    contract_ids INTEGER[]
) AS $$
DECLARE
    contracts_array INTEGER[];
BEGIN
    SELECT array_agg(TreatyID)
    INTO contracts_array
    FROM Contract
    WHERE TariffID = tariff_id_input;

    contract_count := array_length(contracts_array, 1);
    contract_ids := contracts_array;

    IF contract_count = 0 THEN
        RAISE EXCEPTION 'Тариф с ID % не найден или не имеет договоров.', tariff_id_input;
    END IF;

    RETURN NEXT;
END;
$$ LANGUAGE plpgsql;



--Самый продаваемый тур. пакет
CREATE OR REPLACE FUNCTION get_most_popular_tariff()
RETURNS TABLE (
    TariffID INTEGER,
    TariffTitle VARCHAR,
    TariffType VARCHAR,
    TariffPrice INTEGER,
    TariffLocating VARCHAR,
    TariffInsurance BOOLEAN,
    contract_count BIGINT
) AS $$
BEGIN
    RETURN QUERY

    SELECT 
        t.TariffID,
        t.TariffTitle,
        td.TariffType,
        td.TariffPrice,
        td.TariffLocating,
        td.TariffInsurance,
        COUNT(c.TreatyID) AS contract_count
    FROM 
        Tariff t
        JOIN TariffDetails td ON t.TariffDetailID = td.TariffDetailID
        LEFT JOIN Contract c ON t.TariffID = c.TariffID
    WHERE 
        t.isDeleted = FALSE
        AND td.isDeleted = FALSE
    GROUP BY 
        t.TariffID, td.TariffType, td.TariffPrice, td.TariffLocating, td.TariffInsurance
    ORDER BY 
        contract_count DESC
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;



--Количество клиентов, заказавших поездки в определенный период
CREATE OR REPLACE FUNCTION get_clients_in_period(start_date DATE, end_date DATE)
RETURNS INTEGER AS $$
BEGIN
    RETURN (
        SELECT COUNT(DISTINCT c.CliID)
        FROM 
            Contract c
            JOIN Client cl ON c.CliID = cl.CliID
        WHERE 
            c.TreatySignDate BETWEEN start_date AND end_date
            OR c.TreatyStartDate BETWEEN start_date AND end_date
            AND cl.isDeleted = false
    );
END;
$$ LANGUAGE plpgsql;



--Суммарная цена договоров нашей компании за все время
CREATE OR REPLACE FUNCTION get_total_contracts_cost()
RETURNS INTEGER AS $$
BEGIN
    RETURN (
        SELECT SUM(c.TreatyCost)
        FROM Contract c
    );
END;
$$ LANGUAGE plpgsql;



--Количество договоров за все время
CREATE OR REPLACE FUNCTION get_total_contracts_count()
RETURNS INTEGER AS $$
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM Contract c
    );
END;
$$ LANGUAGE plpgsql;



--Список клиентов, которые воспользовались определенным пакетом в определенный период
CREATE OR REPLACE FUNCTION get_clients_by_tariff_and_period(
    tariff_id INTEGER, 
    start_date DATE, 
    end_date DATE
)
RETURNS TABLE (
    "ID клиента" INTEGER,
    "Фамилия" VARCHAR,
    "Имя" VARCHAR,
    "Отчество" VARCHAR,
    "Телефон" VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.CliID AS "ID клиента",
        c.LNameCli AS "Фамилия",
        c.FNameCli AS "Имя",
        c.FaNameCli AS "Отчество",
        c.PhoneCli AS "Телефон"
    FROM 
        Contract ct
        JOIN Client c ON ct.CliID = c.CliID
    WHERE 
        ct.TariffID = tariff_id
        AND ct.TreatySignDate BETWEEN start_date AND end_date
        OR ct.TreatyStartDate BETWEEN start_date AND end_date
        AND c.isDeleted = false;
    
    IF end_date < start_date THEN RAISE EXCEPTION 'Дата окончания договора не может быть раньше даты начала.';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Tariff WHERE Tariff.TariffID = tariff_id) THEN
        RAISE EXCEPTION 'Тариф № % не найден.', tariff_id;
    END IF;

END;
$$ LANGUAGE plpgsql;



--Процент подписанных договоров со страховкой от числа общих договоров
CREATE OR REPLACE FUNCTION get_contracts_with_insurance_percentage()
RETURNS TABLE (
    total_contracts INTEGER,
    contracts_with_insurance INTEGER,
    insurance_percentage NUMERIC
) AS $$
BEGIN
    SELECT COUNT(*) INTO total_contracts
    FROM Contract ct;

    SELECT COUNT(*) INTO contracts_with_insurance
    FROM Contract ct
    JOIN Tariff t ON ct.TariffID = t.TariffID
    JOIN TariffDetails td ON t.TariffDetailID = td.TariffDetailID
    WHERE td.TariffInsurance = true;

    -- Процент страховок
    IF total_contracts > 0 THEN
        insurance_percentage := round((contracts_with_insurance::NUMERIC / total_contracts) * 100, 2);
    ELSE
        insurance_percentage := 0;
    END IF;

    RETURN NEXT;
END;
$$ LANGUAGE plpgsql;



--Прибыль за квартал
CREATE OR REPLACE FUNCTION get_quarter_profit()
RETURNS NUMERIC AS $$
DECLARE
    total_profit NUMERIC;
BEGIN
    SELECT COALESCE(SUM(TreatyCost), 0) INTO total_profit
    FROM Contract
    WHERE (TreatyStartDate >= CURRENT_DATE - INTERVAL '3 months'
            AND TreatyStopDate <= CURRENT_DATE);

    RETURN total_profit;
END;
$$ LANGUAGE plpgsql;



--Количество подписанных наиболее дорогих договоров
CREATE OR REPLACE FUNCTION get_most_expensive_contracts()
RETURNS TABLE (
    contract_count BIGINT,
    contract_price NUMERIC,
    contract_ids JSONB
) AS $$
DECLARE
    max_price NUMERIC;
BEGIN
    SELECT MAX(TreatyCost) INTO max_price
    FROM Contract;

    RETURN QUERY
    SELECT 
        COUNT(*) AS contract_count,
        max_price AS contract_price,
        to_jsonb(array_agg(TreatyID)) AS contract_ids
    FROM Contract
    WHERE TreatyCost = max_price
    GROUP BY max_price;
END;
$$ LANGUAGE plpgsql;



--Количество пользователей, подписавших договор с пакетом определенного типа
CREATE OR REPLACE FUNCTION count_users_by_tariff_type(tariff_type_input VARCHAR)
RETURNS INTEGER AS $$
DECLARE
    user_count INTEGER;
BEGIN
    SELECT COUNT(DISTINCT ct.CliID) 
    INTO user_count
    FROM Contract ct
    JOIN Tariff t ON ct.TariffID = t.TariffID
    JOIN TariffDetails td ON t.TariffDetailID = td.TariffDetailID
    WHERE td.TariffType = tariff_type_input;

    RETURN user_count;
END;
$$ LANGUAGE plpgsql;



--Текущие финансовые показатели фирмы
CREATE OR REPLACE FUNCTION generate_financial_report()
RETURNS TABLE (
    total_contracts_count INTEGER,
    total_contracts_cost INTEGER,
    total_clients_count INTEGER,
    deleted_clients_count INTEGER,
    total_employees_count INTEGER,
    deleted_employees_count INTEGER,
    total_trips_last_3_months INTEGER,
    average_trip_cost_last_3_months NUMERIC,
    insurance_percentage NUMERIC,
    most_expensive_contracts_count BIGINT,
    most_expensive_contracts_price NUMERIC,
    most_expensive_contracts_ids JSONB,
    most_popular_tariff_id INTEGER,
    most_popular_tariff_title VARCHAR,
    most_popular_tariff_type VARCHAR,
    most_popular_tariff_price INTEGER,
    most_popular_tariff_locating VARCHAR,
    most_popular_tariff_insurance BOOLEAN,
    most_popular_tariff_contract_count BIGINT
) AS $$
DECLARE
    total_contracts INTEGER;
    total_cost INTEGER;
    client_count INTEGER;
    deleted_clients INTEGER;
    employee_count INTEGER;
    deleted_employees INTEGER;
    trips_last_3_months INTEGER;
    avg_trip_cost NUMERIC;
    insurance_data RECORD;
    most_expensive_contracts RECORD;
    popular_tariff RECORD;
BEGIN
    total_contracts := get_total_contracts_count();
    
    total_cost := get_total_contracts_cost();
    
    client_count := count_all_clients();
    
    deleted_clients := count_deleted_clients();
    
    employee_count := count_all_employees();
    
    deleted_employees := count_deleted_employees();
    
    trips_last_3_months := count_trips_last_n_months(3);
    
    avg_trip_cost := average_trip_cost_last_n_months(3);
    
    SELECT * INTO insurance_data FROM get_contracts_with_insurance_percentage();
    
    SELECT * INTO most_expensive_contracts FROM get_most_expensive_contracts();
    
    SELECT * INTO popular_tariff FROM get_most_popular_tariff();
    
    RETURN QUERY
    SELECT 
        total_contracts,
        total_cost,
        client_count,
        deleted_clients,
        employee_count,
        deleted_employees,
        trips_last_3_months,
        avg_trip_cost,
        insurance_data.insurance_percentage,
        most_expensive_contracts.contract_count,
        most_expensive_contracts.contract_price,
        most_expensive_contracts.contract_ids,
        popular_tariff.TariffID,
        popular_tariff.TariffTitle,
        popular_tariff.TariffType,
        popular_tariff.TariffPrice,
        popular_tariff.TariffLocating,
        popular_tariff.TariffInsurance,
        popular_tariff.contract_count;
END;
$$ LANGUAGE plpgsql;









-- Удаление клиента
CREATE OR REPLACE PROCEDURE delete_client(client_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Client SET isDeleted = true WHERE CliID = client_id;
    
    UPDATE ClientDocuments 
    SET isDeleted = true 
    WHERE ClientDocumentsID = (SELECT ClientDocumentsID FROM Client WHERE CliID = client_id);

    UPDATE MainPassesCli 
    SET isDeleted = true 
    WHERE MainPassCliID = (SELECT MainPassCliID FROM ClientDocuments WHERE ClientDocumentsID = (SELECT ClientDocumentsID FROM Client WHERE CliID = client_id));

    UPDATE InterPassesCli 
    SET isDeleted = true 
    WHERE InterPassCliID = (SELECT InterPassCliID FROM ClientDocuments WHERE ClientDocumentsID = (SELECT ClientDocumentsID FROM Client WHERE CliID = client_id));

    UPDATE SnilsCli 
    SET isDeleted = true 
    WHERE SnilsCliID = (SELECT SnilsCliID FROM ClientDocuments WHERE ClientDocumentsID = (SELECT ClientDocumentsID FROM Client WHERE CliID = client_id));

    UPDATE InnCli 
    SET isDeleted = true 
    WHERE InnCliID = (SELECT InnCliID FROM ClientDocuments WHERE ClientDocumentsID = (SELECT ClientDocumentsID FROM Client WHERE CliID = client_id));
END;
$$;

--Восстановление клиента
CREATE OR REPLACE PROCEDURE restore_client(client_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Client SET isDeleted = false WHERE CliID = client_id;

    UPDATE ClientDocuments 
    SET isDeleted = false 
    WHERE ClientDocumentsID = (SELECT ClientDocumentsID FROM Client WHERE CliID = client_id);

    UPDATE MainPassesCli 
    SET isDeleted = false 
    WHERE MainPassCliID = (SELECT MainPassCliID FROM ClientDocuments WHERE ClientDocumentsID = (SELECT ClientDocumentsID FROM Client WHERE CliID = client_id));

    UPDATE InterPassesCli 
    SET isDeleted = false 
    WHERE InterPassCliID = (SELECT InterPassCliID FROM ClientDocuments WHERE ClientDocumentsID = (SELECT ClientDocumentsID FROM Client WHERE CliID = client_id));

    UPDATE SnilsCli 
    SET isDeleted = false 
    WHERE SnilsCliID = (SELECT SnilsCliID FROM ClientDocuments WHERE ClientDocumentsID = (SELECT ClientDocumentsID FROM Client WHERE CliID = client_id));

    UPDATE InnCli 
    SET isDeleted = false 
    WHERE InnCliID = (SELECT InnCliID FROM ClientDocuments WHERE ClientDocumentsID = (SELECT ClientDocumentsID FROM Client WHERE CliID = client_id));
END;
$$;

--Удаление сотрудника
CREATE OR REPLACE PROCEDURE delete_employee(employee_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Employee SET isDeleted = true WHERE EmpID = employee_id;

    UPDATE EmployeeDocuments 
    SET isDeleted = true 
    WHERE EmployeeDocumentsID = (SELECT EmployeeDocumentsID FROM Employee WHERE EmpID = employee_id);

    UPDATE PassesEmp 
    SET isDeleted = true 
    WHERE PassEmpID = (SELECT PassEmpID FROM EmployeeDocuments WHERE EmployeeDocumentsID = (SELECT EmployeeDocumentsID 

FROM Employee WHERE EmpID = employee_id));

    UPDATE SnilsEmp 
    SET isDeleted = true 
    WHERE SnilsEmpID = (SELECT SnilsEmpID FROM EmployeeDocuments WHERE EmployeeDocumentsID = (SELECT EmployeeDocumentsID 

FROM Employee WHERE EmpID = employee_id));

    UPDATE InnEmp 
    SET isDeleted = true 
    WHERE InnEmpID = (SELECT InnEmpID FROM EmployeeDocuments WHERE EmployeeDocumentsID = (SELECT EmployeeDocumentsID FROM 

Employee WHERE EmpID = employee_id));

    UPDATE WrkBooksEmp 
    SET isDeleted = true 
    WHERE WrkEmpID = (SELECT WrkEmpID FROM EmployeeDocuments WHERE EmployeeDocumentsID = (SELECT EmployeeDocumentsID FROM 

Employee WHERE EmpID = employee_id));
END;
$$;

--Восстановление сотрудника
CREATE OR REPLACE PROCEDURE restore_employee(employee_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Employee SET isDeleted = false WHERE EmpID = employee_id;

    -- Каскадно восстанавливаем документы
    UPDATE EmployeeDocuments 
    SET isDeleted = false 
    WHERE EmployeeDocumentsID = (SELECT EmployeeDocumentsID FROM Employee WHERE EmpID = employee_id);

    UPDATE PassesEmp 
    SET isDeleted = false 
    WHERE PassEmpID = (SELECT PassEmpID FROM EmployeeDocuments WHERE EmployeeDocumentsID = (SELECT EmployeeDocumentsID 

FROM Employee WHERE EmpID = employee_id));

    UPDATE SnilsEmp 
    SET isDeleted = false 
    WHERE SnilsEmpID = (SELECT SnilsEmpID FROM EmployeeDocuments WHERE EmployeeDocumentsID = (SELECT EmployeeDocumentsID 

FROM Employee WHERE EmpID = employee_id));

    UPDATE InnEmp 
    SET isDeleted = false 
    WHERE InnEmpID = (SELECT InnEmpID FROM EmployeeDocuments WHERE EmployeeDocumentsID = (SELECT EmployeeDocumentsID FROM 

Employee WHERE EmpID = employee_id));

    UPDATE WrkBooksEmp 
    SET isDeleted = false 
    WHERE WrkEmpID = (SELECT WrkEmpID FROM EmployeeDocuments WHERE EmployeeDocumentsID = (SELECT EmployeeDocumentsID FROM 

Employee WHERE EmpID = employee_id));
END;
$$;

--Удаление партнера
CREATE OR REPLACE PROCEDURE delete_partner(partner_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Partner SET isDeleted = true WHERE PartnerID = partner_id;

    -- Каскадно удаляем
    UPDATE PartnerContacts SET isDeleted = true WHERE PartnerID = partner_id;
    UPDATE AdditionalService SET isDeleted = true WHERE PartnerID = partner_id;
    UPDATE Tariff SET isDeleted = true WHERE PartnerID = partner_id;
END;
$$;

--Восстановление партнера
CREATE OR REPLACE PROCEDURE restore_partner(partner_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Partner SET isDeleted = false WHERE PartnerID = partner_id;

    UPDATE PartnerContacts SET isDeleted = false WHERE PartnerID = partner_id;
    UPDATE AdditionalService SET isDeleted = false WHERE PartnerID = partner_id;
    UPDATE Tariff SET isDeleted = false WHERE PartnerID = partner_id;
END;
$$;

--Удаление контактов партнера
CREATE OR REPLACE PROCEDURE delete_partner_contact(partner_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE PartnerContacts SET isDeleted = true WHERE PartnerID = partner_id;
END;
$$;

--Удаление дополнительных услуг партнера
CREATE OR REPLACE PROCEDURE delete_partner_service(partner_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE AdditionalService SET isDeleted = true WHERE PartnerID = partner_id;
END;
$$;

--Удаление тарифов партнера
CREATE OR REPLACE PROCEDURE delete_partner_tariff(partner_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Tariff SET isDeleted = true WHERE PartnerID = partner_id;
END;
$$;

--Восстановление контактов партнера
CREATE OR REPLACE PROCEDURE restore_partner_contact(partner_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE PartnerContacts SET isDeleted = false WHERE PartnerID = partner_id;
END;
$$;

--Восстановление дополнительных услуг партнера
CREATE OR REPLACE PROCEDURE restore_partner_service(partner_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE AdditionalService SET isDeleted = false WHERE PartnerID = partner_id;
END;
$$;

--Восстановление тарифов партнера
CREATE OR REPLACE PROCEDURE restore_partner_tariff(partner_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Tariff SET isDeleted = false WHERE PartnerID = partner_id;
END;
$$;

--Удаление деталей тарифов
CREATE OR REPLACE PROCEDURE delete_tariff_detail(tariff_detail_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE TariffDetails SET isDeleted = true WHERE TariffDetailID = tariff_detail_id;
END;
$$;

--Восстановление деталей тарифов
CREATE OR REPLACE PROCEDURE restore_tariff_detail(tariff_detail_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE TariffDetails SET isDeleted = false WHERE TariffDetailID = tariff_detail_id;
END;
$$;

--Добавление городов и улиц
CREATE OR REPLACE PROCEDURE add_city_and_street_proc(
    city_param varchar,
    street_param varchar
)
LANGUAGE plpgsql AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cities WHERE City = city_param) THEN
        IF NOT EXISTS (SELECT 1 FROM Streets WHERE Street = street_param) THEN
            INSERT INTO Streets (Street) VALUES (street_param);
        END IF;
    ELSIF EXISTS (SELECT 1 FROM Streets WHERE Street = street_param) THEN
        IF NOT EXISTS (SELECT 1 FROM Cities WHERE City = city_param) THEN
            INSERT INTO Cities (City) VALUES (city_param);
        END IF;
    ELSE
        INSERT INTO Cities (City) VALUES (city_param);
        INSERT INTO Streets (Street) VALUES (street_param);
    END IF;
    
    RAISE NOTICE 'Город % и улица % были добавлены или обновлены', city_param, street_param;
END;
$$;



--Добавление контракта
CREATE OR REPLACE PROCEDURE add_contract_proc(
    IN service_id INTEGER,
    IN cli_id INTEGER,
    IN emp_id INTEGER,
    IN partner_id INTEGER,
    IN tariff_id INTEGER,
    IN sign_date DATE,
    IN start_date DATE,
    IN stop_date DATE,
    IN comment TEXT,
    OUT new_treaty_id INTEGER
)
LANGUAGE plpgsql AS $$
DECLARE
    tariff_partner_id INTEGER;
    service_partner_id INTEGER;
    tariff_detail_id INTEGER;
    tariff_price NUMERIC;
    service_price NUMERIC := 0;
    calculated_cost NUMERIC;
    emp_role_name VARCHAR;
BEGIN
    -- Проверка существования переданных идентификаторов
    IF NOT EXISTS (SELECT 1 FROM Partner WHERE PartnerID = partner_id AND isDeleted = FALSE) THEN
        RAISE EXCEPTION 'Партнер с ID % не существует или удален.', partner_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Tariff WHERE TariffID = tariff_id AND isDeleted = FALSE) THEN
        RAISE EXCEPTION 'Тариф с ID % не существует или удален.', tariff_id;
    END IF;

    IF service_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM AdditionalService WHERE ServiceID = service_id AND isDeleted = FALSE) THEN
        RAISE EXCEPTION 'Дополнительная услуга с ID % не существует или удалена.', service_id;
    END IF;

    -- Проверка соответствия тарифа и партнера
    SELECT PartnerID, TariffDetailID INTO tariff_partner_id, tariff_detail_id
    FROM Tariff
    WHERE TariffID = tariff_id AND isDeleted = FALSE;

    IF tariff_partner_id != partner_id THEN
        RAISE EXCEPTION 'Тариф с ID % не связан с партнером с ID %.', tariff_id, partner_id;
    END IF;

    -- Проверка соответствия дополнительной услуги и партнера (если указана услуга)
    IF service_id IS NOT NULL THEN
        SELECT PartnerID INTO service_partner_id
        FROM AdditionalService
        WHERE ServiceID = service_id AND isDeleted = FALSE;

        IF service_partner_id != partner_id THEN
            RAISE EXCEPTION 'Дополнительная услуга с ID % не связана с партнером с ID %.', service_id, partner_id;
        END IF;

        -- Получение цены дополнительной услуги
        SELECT ServicePrice INTO service_price
        FROM AdditionalService
        WHERE ServiceID = service_id;
    END IF;

    -- Получение цены тарифа через TariffDetailID
    SELECT TariffPrice INTO tariff_price
    FROM TariffDetails
    WHERE TariffDetailID = tariff_detail_id AND isDeleted = FALSE;

    -- Проверка роли сотрудника
    SELECT EmpRole INTO emp_role_name
    FROM EmpRole
    WHERE EmpRoleID = (SELECT EmpRoleID FROM Employee WHERE EmpID = emp_id);

    IF emp_role_name != 'Менеджер по продажам' THEN
        RAISE EXCEPTION 'Сотрудник с ID % не имеет должность "Менеджер по продажам".', emp_id;
    END IF;

    -- Расчет стоимости договора
    calculated_cost := (tariff_price + service_price) * 1.3;

    -- Добавление записи в таблицу Contract
    INSERT INTO Contract (
        ServiceID, CliID, EmpID, PartnerID, TariffID,
        TreatySignDate, TreatyStartDate, TreatyStopDate, TreatyCost, Comment
    )
    VALUES (
        service_id, cli_id, emp_id, partner_id, tariff_id,
        sign_date, start_date, stop_date, calculated_cost, comment
    )
    RETURNING TreatyID INTO new_treaty_id;

    RAISE NOTICE 'Контракт с ID % успешно добавлен.', new_treaty_id;
END;
$$;


--Добавление типа организации
CREATE OR REPLACE PROCEDURE add_organization_type_proc(
    IN org_type varchar,
    OUT new_org_type_id integer
)
LANGUAGE plpgsql AS $$
DECLARE
BEGIN
    INSERT INTO PartnerOrgTypes(PartnerOrgType)
    VALUES(org_type)
    RETURNING PartnerOrgTypeID INTO new_org_type_id;
    RAISE NOTICE 'Тип организации % с ID % создан', org_type, new_org_type_id;
END;
$$;

--Добавление партнера
CREATE OR REPLACE PROCEDURE add_partner(
    partner_org_type_id integer,
    partner_title varchar,
    OUT new_partner_id integer
)  
LANGUAGE plpgsql AS $$
DECLARE
BEGIN
    INSERT INTO Partner(PartnerOrgTypeID, PartnerTitle)
    VALUES (partner_org_type_id, partner_title)
    RETURNING PartnerID INTO new_partner_id;
    RAISE NOTICE 'Партнер № % был добавлен', new_partner_id;
END;
$$;

--Добавление контактных данных
CREATE OR REPLACE PROCEDURE add_partner_contact(
    partner_id integer,
    partner_phone varchar,
    partner_email varchar,
    OUT new_contact_id integer
)
LANGUAGE plpgsql AS $$
DECLARE
BEGIN
    INSERT INTO PartnerContacts (PartnerID, PartnerPhone, PartnerEmail)
    VALUES (partner_id, partner_phone, partner_email)
    RETURNING ContactID INTO new_contact_id;
    RAISE NOTICE 'Контактные данные № % для партнера % были добавлены', new_contact_id, partner_id;
END;
$$;

--Добавление деталей тарифа
CREATE OR REPLACE PROCEDURE add_tariff_detail_proc(
    tariff_type varchar,
    tariff_price integer,
    tariff_locating varchar,
    tariff_insurance boolean,
    OUT new_tariff_detail_id integer
)
LANGUAGE plpgsql AS $$
DECLARE
BEGIN
    INSERT INTO TariffDetails (TariffType, TariffPrice, TariffLocating, TariffInsurance)
    VALUES (tariff_type, tariff_price, tariff_locating, tariff_insurance)
    RETURNING TariffDetailID INTO new_tariff_detail_id;
    RAISE NOTICE 'Свойства тарифа № % добавлены', new_tariff_detail_id;
END;
$$;

--Добавление дополнительной услуги партнера
CREATE OR REPLACE PROCEDURE add_additional_service(
    partner_id integer,
    service_description text,
    service_price integer,
    OUT new_service_id integer
) 
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO AdditionalService (PartnerID, ServiceDescription, ServicePrice)
    VALUES (partner_id, service_description, service_price)
    RETURNING ServiceID INTO new_service_id;
    RAISE NOTICE 'Дополнительная услуга № % партнера % была создана', new_service_id, partner_id;
END;
$$;

--Добавление тарифа
CREATE OR REPLACE PROCEDURE add_tariff(
    tariff_detail_id integer, 
    partner_id integer,
    tariff_title varchar,
    OUT new_tariff_id integer
) 
LANGUAGE plpgsql AS $$
DECLARE
BEGIN
    INSERT INTO Tariff (TariffDetailID, PartnerID, TariffTitle)
    VALUES (tariff_detail_id, partner_id, tariff_title)
    RETURNING TariffID INTO new_tariff_id;
    RAISE NOTICE 'Тариф № % был добавлен', new_tariff_id;
END;
$$;

--Добавление документов клиента
CREATE OR REPLACE PROCEDURE add_client_document_proc(
    main_pass_num varchar,
    main_pass_series varchar,
    main_pass_date date,
    inter_pass_num varchar,
    inter_pass_series varchar,
    inter_pass_date date,
    snils varchar,
    inn varchar,
    OUT client_documents_id integer
)
LANGUAGE plpgsql AS $$
DECLARE
    main_pass_id integer;
    inter_pass_id integer;
    snils_id integer;
    inn_id integer;
BEGIN

    INSERT INTO MainPassesCli (MainPassNumCli, MainPassSeriesCli, MainPassDateCli)
    VALUES (main_pass_num, main_pass_series, main_pass_date)
    RETURNING MainPassCliID INTO main_pass_id;

    INSERT INTO InterPassesCli (InterPassNumCli, InterPassSeriesCli, InterPassDateCli)
    VALUES (inter_pass_num, inter_pass_series, inter_pass_date)
    RETURNING InterPassCliID INTO inter_pass_id;

    INSERT INTO SnilsCli (SnilsCli)
    VALUES (snils)
    RETURNING SnilsCliID INTO snils_id;

    INSERT INTO InnCli (InnCli)
    VALUES (inn)
    RETURNING InnCliID INTO inn_id;

    INSERT INTO ClientDocuments (MainPassCliID, InterPassCliID, SnilsCliID, InnCliID)
    VALUES (main_pass_id, inter_pass_id, snils_id, inn_id)
    RETURNING ClientDocumentsID INTO client_documents_id;
    RAISE NOTICE 'Пакет документов № % был добавлен', client_documents_id;
END;
$$;

--Добавление клиента
CREATE OR REPLACE PROCEDURE add_client_proc(
    main_pass_num varchar,
    main_pass_series varchar,
    main_pass_date date,
    inter_pass_num varchar,
    inter_pass_series varchar,
    inter_pass_date date,
    snils varchar,
    inn varchar,
    fname varchar,
    lname varchar,
    faname varchar,
    reg_city_id integer,
    reg_street_id integer,
    reg_house integer,
    reg_apartment integer,
    res_city_id integer,
    res_street_id integer,
    res_house integer,
    res_apartment integer,
    phone varchar,
    OUT new_client_id integer
)
LANGUAGE plpgsql AS $$
DECLARE
    main_pass_id integer;
    inter_pass_id integer;
    snils_id integer;
    inn_id integer;
    client_documents_id integer;
BEGIN

    CALL add_client_document_proc(
        main_pass_num,
        main_pass_series,
        main_pass_date,
        inter_pass_num,
        inter_pass_series,
        inter_pass_date,
        snils,
        inn,
        client_documents_id
    );

    INSERT INTO Client (
        ClientDocumentsID, FNameCli, LNameCli, FaNameCli,
        RegCityID, RegStreetID, RegHouse, RegApartment,
        ResCityID, ResStreetID, ResHouse, ResApartment,
        PhoneCli
    )
    VALUES (
    client_documents_id, fname, lname, faname,
    reg_city_id, reg_street_id, reg_house, reg_apartment,
    res_city_id, res_street_id, res_house, res_apartment,
    phone
    )
    RETURNING CliID INTO new_client_id;

    RAISE NOTICE 'Клиент № % успешно добавлен с пакетом документов № %', new_client_id, client_documents_id;END;
$$;

--Изменить ФИО и телефон клиента
CREATE OR REPLACE PROCEDURE update_client_data_proc(
    ID integer,
    NewFirstName varchar,
    NewLastName varchar,
    NewFatherName varchar,
    NewPhone varchar
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Client
    SET FNameCli = COALESCE(NewFirstName, FNameCli),
        LNameCli = COALESCE(NewLastName, LNameCli),
        FaNameCli = COALESCE(NewFatherName, FaNameCli),
        PhoneCli = COALESCE(NewPhone, PhoneCli)
    WHERE CliID = ID;
    RAISE NOTICE 'Данные клиента % были обновлены.', ID;
END;
$$;

--Изменить места жительства и прописки клиента
CREATE OR REPLACE PROCEDURE update_client_living_places_proc(
    ID integer,
    NewRegCityID integer DEFAULT NULL,
    NewRegStreetID integer DEFAULT NULL,
    NewRegHouse integer DEFAULT NULL,
    NewRegApartment integer DEFAULT NULL,
    NewResCityID integer DEFAULT NULL,
    NewResStreetID integer DEFAULT NULL,
    NewResHouse integer DEFAULT NULL,
    NewResApartment integer DEFAULT NULL
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Client
    SET RegCityID = COALESCE(NewRegCityID, RegCityID),
        RegStreetID = COALESCE(NewRegStreetID, RegStreetID),
        RegHouse = COALESCE(NewRegHouse, RegHouse),
        RegApartment = COALESCE(NewRegApartment, RegApartment),
        ResCityID = COALESCE(NewResCityID, ResCityID),
        ResStreetID = COALESCE(NewResStreetID, ResStreetID),
        ResHouse = COALESCE(NewResHouse, ResHouse),
        ResApartment = COALESCE(NewResApartment, ResApartment)
    WHERE CliID = ID;
    RAISE NOTICE 'Места проживания клиента % были обновлены.', ID;
END;
$$;

--Изменить документы клиента
CREATE OR REPLACE PROCEDURE update_client_documents_proc(
    ID integer,
    NewMainPassNum varchar DEFAULT NULL,
    NewMainPassSeries varchar DEFAULT NULL,
    NewMainPassDate date DEFAULT NULL,
    NewInterPassNum varchar DEFAULT NULL,
    NewInterPassSeries varchar DEFAULT NULL,
    NewInterPassDate date DEFAULT NULL,
    NewSnils varchar DEFAULT NULL,
    NewInn varchar DEFAULT NULL
)
LANGUAGE plpgsql AS $$
BEGIN
    IF NewMainPassNum IS NOT NULL OR NewMainPassSeries IS NOT NULL OR NewMainPassDate IS NOT NULL THEN
        UPDATE MainPassesCli
        SET MainPassNumCli = COALESCE(NewMainPassNum, MainPassNumCli),
            MainPassSeriesCli = COALESCE(NewMainPassSeries, MainPassSeriesCli),
            MainPassDateCli = COALESCE(NewMainPassDate, MainPassDateCli)
        WHERE MainPassCliID = ID;
    END IF;
    IF NewInterPassNum IS NOT NULL OR NewInterPassSeries IS NOT NULL OR NewInterPassDate IS NOT NULL THEN
        UPDATE InterPassesCli
        SET InterPassNumCli = COALESCE(NewInterPassNum, InterPassNumCli),
            InterPassSeriesCli = COALESCE(NewInterPassSeries, InterPassSeriesCli),
            InterPassDateCli = COALESCE(NewInterPassDate, InterPassDateCli)
        WHERE InterPassCliID = ID;
    END IF;
    IF NewSnils IS NOT NULL THEN
        UPDATE SnilsCli
        SET SnilsCli = NewSnils
        WHERE SnilsCliID = ID;
    END IF;
    IF NewInn IS NOT NULL THEN
        UPDATE InnCli
        SET InnCli = NewInn
        WHERE InnCliID = ID;
    END IF;
    RAISE NOTICE 'Документы клиента % были обновлены.', ID;
END;
$$;

--Добавление документов сотрудника
CREATE OR REPLACE PROCEDURE add_employee_document_proc(
    pass_num varchar,
    pass_series varchar,
    pass_date date,
    snils varchar,
    inn varchar,
    wrk_book_series varchar,
    wrk_book_num varchar,
    OUT employee_documents_id integer
)
LANGUAGE plpgsql AS $$
DECLARE
    pass_id integer;
    snils_id integer;
    inn_id integer;
    wrk_book_id integer;
BEGIN

    INSERT INTO PassesEmp(PassNumEmp, PassSeriesEmp, PassDateEmp)
    VALUES (pass_num, pass_series, pass_date)
    RETURNING PassEmpID INTO pass_id;

    INSERT INTO SnilsEmp (SnilsEmp)
    VALUES (snils)
    RETURNING SnilsEmpID INTO snils_id;

    INSERT INTO InnEmp (InnEmp)
    VALUES (inn)
    RETURNING InnEmpID INTO inn_id;

    INSERT INTO WrkBooksEmp(WrkSeriesEmp, WrkNumEmp)
    VALUES (wrk_book_series, wrk_book_num)
    RETURNING WrkEmpID INTO wrk_book_id;

    INSERT INTO EmployeeDocuments (PassEmpID, SnilsEmpID, InnEmpID, WrkEmpID)
    VALUES (pass_id, snils_id, inn_id, wrk_book_id)
    RETURNING EmployeeDocumentsID INTO employee_documents_id;
    RAISE NOTICE 'Пакет документов № % был добавлен', employee_documents_id;
END;
$$;

--Добавление должности
CREATE OR REPLACE PROCEDURE add_emp_role(role varchar)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO EmpRole(EmpRole) VALUES (role);
    RAISE NOTICE 'Должность % была добавлена.', role;
END;
$$;

--Добавление сотрудника
CREATE OR REPLACE PROCEDURE add_employee_proc(
    pass_num varchar,
    pass_series varchar,
    pass_date date,
    snils varchar,
    inn varchar,
    wrk_book_series varchar,
    wrk_book_num varchar,
    fname varchar,
    lname varchar,
    faname varchar,
    role_id integer,
    city integer,
    street integer,
    house integer,
    apartment integer,
    phone varchar,
    OUT new_employee_id integer
)
LANGUAGE plpgsql AS $$
DECLARE
    employee_documents_id integer;
BEGIN
    CALL add_employee_document_proc(
        pass_num,
        pass_series,
        pass_date,
        snils,
        inn,
        wrk_book_series,
        wrk_book_num,
        employee_documents_id
    );
    INSERT INTO Employee (
        EmployeeDocumentsID, FNameEmp, LNameEmp, FaNameEmp, EmpRoleID, CityID, StreetID, House, Apartment, PhoneEmp
    )
    VALUES (employee_documents_id, fname, lname, faname, role_id, city, street, house, apartment, phone)
    RETURNING EmpID INTO new_employee_id;
    RAISE NOTICE 'Сотрудник % был добавлен', new_employee_id;
END;
$$;









--Логгирование изменений


--Таблица логов
CREATE TABLE Logs (
    LogID SERIAL PRIMARY KEY,
    LogDate DATE NOT NULL DEFAULT CURRENT_DATE,
    LogTime TIME NOT NULL DEFAULT CURRENT_TIME,
    TableName TEXT NOT NULL,
    Operation TEXT NOT NULL,
    OldData JSONB,
    NewData JSONB 
);

--Функция записи логов
CREATE OR REPLACE FUNCTION log_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Logs (TableName, Operation, OldData, NewData)
    VALUES (
        TG_TABLE_NAME, -- Название таблицы
        TG_OP,         -- Тип операции: INSERT, UPDATE, DELETE
        row_to_json(OLD), -- Старые данные (NULL для INSERT)
        row_to_json(NEW)  -- Новые данные (NULL для DELETE)
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Таблицы, для которых будет настроено логирование
DO $$
DECLARE
    tbl_name TEXT;
BEGIN
    -- Список таблиц
    FOR tbl_name IN 
        SELECT UNNEST(ARRAY[
            'Client', 'ClientDocuments', 'MainPassesCli', 'InterPassesCli', 'SnilsCli', 'InnCli',
            'Employee', 'EmployeeDocuments', 'PassesEmp', 'SnilsEmp', 'InnEmp', 'WrkBooksEmp', 'EmpRole',
            'Cities', 'Streets', 'Contract',
            'Partner', 'PartnerContacts', 'PartnerOrgTypes', 'AdditionalService', 'Tariff', 'TariffDetails'
        ])
    LOOP
        EXECUTE format($sql$
            CREATE TRIGGER log_%s_changes
            AFTER INSERT OR UPDATE OR DELETE ON %s
            FOR EACH ROW
            EXECUTE FUNCTION log_changes();
        $sql$, tbl_name, tbl_name);
    END LOOP;
END;
$$;




--Предотвращение изменения исторических данных 


--Контракты
CREATE OR REPLACE FUNCTION prevent_contract_modifications()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'UPDATE' OR TG_OP = 'DELETE') THEN
        RAISE EXCEPTION 'Изменение исторических данных запрещено: %', TG_OP;
    END IF;
    RETURN NULL; -- Предотвращаем
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_contract_modifications
BEFORE UPDATE OR DELETE ON Contract
FOR EACH ROW EXECUTE FUNCTION prevent_contract_modifications();

--Клиенты и сотрудники
CREATE OR REPLACE FUNCTION prevent_client_employee_deletion()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        RAISE EXCEPTION 'Удаление Клиента/Сотрудника запрещено. Используйте логическое удаление.';
    END IF;
    RETURN NULL; -- Предотвращаем
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_client_deletion
BEFORE DELETE ON Client
FOR EACH ROW EXECUTE FUNCTION prevent_client_employee_deletion();

CREATE TRIGGER trg_prevent_employee_deletion
BEFORE DELETE ON Employee
FOR EACH ROW EXECUTE FUNCTION prevent_client_employee_deletion();

--Партнеры, тарифы, доп. услуги
CREATE OR REPLACE FUNCTION prevent_partner_tariff_modifications()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        RAISE EXCEPTION 'Удаление партнера, тарифов и доп. услуг запрещено. Используйте логическое удаление.';
    END IF;
    RETURN NULL; -- Предотвращаем
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_partner_modifications
BEFORE DELETE OR UPDATE ON Partner
FOR EACH ROW EXECUTE FUNCTION prevent_partner_tariff_modifications();

CREATE TRIGGER trg_prevent_tariff_modifications
BEFORE DELETE OR UPDATE ON Tariff
FOR EACH ROW EXECUTE FUNCTION prevent_partner_tariff_modifications();

CREATE TRIGGER trg_prevent_service_modifications
BEFORE DELETE OR UPDATE ON AdditionalService
FOR EACH ROW EXECUTE FUNCTION prevent_partner_tariff_modifications();

--Детали тарифа
CREATE OR REPLACE FUNCTION prevent_tariffdetails_modifications()
RETURNS TRIGGER AS $$
BEGIN
    RAISE EXCEPTION 'Удаление деталей тарифа запрещено. Используйте логическое удаление.';
    RETURN NULL; -- Предотвращаем
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_tariffdetails_modifications
BEFORE DELETE ON TariffDetails
FOR EACH ROW EXECUTE FUNCTION prevent_tariffdetails_modifications();




--Уведомление партнера о новом контракте


--Таблица уведомлений
CREATE TABLE PartnerNotifications (
    NotificationID SERIAL PRIMARY KEY,
    PartnerID INTEGER NOT NULL,
    ContractID INTEGER NOT NULL,
    NotificationText TEXT NOT NULL,
    NotificationDate TIMESTAMP DEFAULT NOW(),
    IsRead BOOLEAN DEFAULT FALSE
);

--Функция записи уведомлений
CREATE OR REPLACE FUNCTION notify_partner()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO PartnerNotifications (PartnerID, ContractID, NotificationText)
    VALUES (
        NEW.PartnerID,
        NEW.TreatyID,
        'Был оформлен договор № ' || NEW.TreatyID
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Триггер на функцию
CREATE TRIGGER trg_notify_partner
AFTER INSERT ON Contract
FOR EACH ROW EXECUTE FUNCTION notify_partner();


--Функция для отметки уведомления, как прочитанного
CREATE OR REPLACE PROCEDURE read_notification(ids INTEGER[])
LANGUAGE plpgsql AS $$
DECLARE
    id INTEGER;
BEGIN
    -- Перебор элементов массива ids
    FOR id IN SELECT UNNEST(ids)
    LOOP
        -- Обновление уведомлений
        EXECUTE format(
            'UPDATE PartnerNotifications SET IsRead = TRUE WHERE NotificationID = %s;', id
        );
    END LOOP;
END;
$$;








--!ДЛЯ ИСПОЛЬЗОВАНИЯ ТРАНЗАКЦИЙ ПРОСТО ОБЕРНУТЬ 
--!НУЖНУЮ ПРОЦЕДУРУ ИЛИ ФУНКЦИЮ В КОНСТРУКЦИЮ:
--!BEGIN TRANSACTION ISOLATION LEVEL [READ UNCOMMITED | READ COMMITED | REPEATABLE READ | SERIALIZIBLE];
--!ТУТ ВЫЗОВ ОПЕРАЦИЙ
--!COMMIT;








--Города и улицы
CALL add_city_and_street_proc('Москва', 'Тверская');
CALL add_city_and_street_proc('Санкт-Петербург', 'Невский проспект');
CALL add_city_and_street_proc('Новосибирск', 'Красный проспект');
CALL add_city_and_street_proc('Екатеринбург', 'Ленина');
CALL add_city_and_street_proc('Казань', 'Баумана');
CALL add_city_and_street_proc('Челябинск', 'Кировка');
CALL add_city_and_street_proc('Самара', 'Ленинградская');
CALL add_city_and_street_proc('Ростов-на-Дону', 'Большая Садовая');
CALL add_city_and_street_proc('Краснодар', 'Красная');
CALL add_city_and_street_proc('Владивосток', 'Светланская');
CALL add_city_and_street_proc('Сочи', 'Ривьерская');
CALL add_city_and_street_proc('Омск', 'Сталина');
CALL add_city_and_street_proc('Уфа', 'Октября');
CALL add_city_and_street_proc('Пермь', 'Камская');
CALL add_city_and_street_proc('Воронеж', 'Кольцовская');
CALL add_city_and_street_proc('Иркутск', 'Карла Маркса');
CALL add_city_and_street_proc('Барнаул', 'Пушкина');
CALL add_city_and_street_proc('Тюмень', 'Республики');
CALL add_city_and_street_proc('Хабаровск', 'Муравьева-Амурского');
CALL add_city_and_street_proc('Ярославль', 'Которосльная набережная');
CALL add_city_and_street_proc('Тула', 'Ленина');
CALL add_city_and_street_proc('Иваново', 'Шереметевский проспект');
CALL add_city_and_street_proc('Калининград', 'Ленинский проспект');
CALL add_city_and_street_proc('Вологда', 'Мира');
CALL add_city_and_street_proc('Курск', 'Карла Либкнехта');
CALL add_city_and_street_proc('Белгород', 'Богдана Хмельницкого');
CALL add_city_and_street_proc('Саратов', 'Московская');
CALL add_city_and_street_proc('Тверь', 'Трехсвятская');
CALL add_city_and_street_proc('Липецк', 'Космонавтов');
CALL add_city_and_street_proc('Ульяновск', 'Гончарова');
CALL add_city_and_street_proc('Махачкала', 'Коркмасова');
CALL add_city_and_street_proc('Владикавказ', 'Коста Хетагурова');
CALL add_city_and_street_proc('Нижний Новгород', 'Большая Покровская');
CALL add_city_and_street_proc('Петрозаводск', 'Карла Фомина');
CALL add_city_and_street_proc('Кемерово', 'Советская');

--Должности
CALL add_emp_role('Администратор');
CALL add_emp_role('Бухгалтер');
CALL add_emp_role('Менеджер по продажам');
CALL add_emp_role('Уборщик');

--Сотрудники
CALL add_employee_proc('123456', '4510', '2010-05-12', '123-456-789 01', '123456789101', 'TK-VI', '1234567', 'Жук', 'Ниссан', 'Мерседесович', 3, 1, 1, 15, 5, '79261112233', NULL);
CALL add_employee_proc('654321', '4511', '2012-11-10', '987-654-321 01', '109876543210', 'TK-VI', '7654321', 'Магнус', 'Карлсен', NULL, 3, 2, 3, 25, NULL, '79263334455', NULL);
CALL add_employee_proc('112233', '4508', '2008-03-19', '321-654-987 12', '123987654321', 'TK-VI', '1122334', 'Ян', 'Непомнящий', 'Александрович', 3, 3, 5, 8, 3, '79260001122', NULL);
CALL add_employee_proc('334455', '4515', '2015-08-24', '654-987-321 09', '129876543210', 'TK-VI', '2233445', 'Виши', 'Ананд', NULL, 1, 4, 6, 20, NULL, '79265556677', NULL);
CALL add_employee_proc('445566', '4520', '2020-01-30', '567-890-123 45', '129876543456', 'TK-VI', '3344556', 'Александр', 'Алехин', 'Александрович', 2, 5, 7, 12, 4, '79268887799', NULL);
CALL add_employee_proc('556677', '4530', '2018-07-15', '123-987-654 67', '123456780000', 'TK-VI', '5566778', 'Хоссе-Рауль', 'Капабланка', NULL, 4, 6, 8, 10, NULL, '79264443322', NULL);
CALL add_employee_proc('809788', '4234', '2019-06-22', '004-567-890 12', '111222333444', 'TK-VI', '0000000', 'Гарри', 'Каспаров', 'Кимович', 2, 7, 9, 18, 1, '79264445566', NULL);
CALL add_employee_proc('845699', '4532', '2017-04-10', '340-678-901 23', '222333444555', 'TK-VI', '0000001', 'Фабиано', 'Каруана', NULL, 2, 8, 10, 5, NULL, '79261117788', NULL);
CALL add_employee_proc('123400', '4503', '2016-03-15', '406-789-012 34', '333444555666', 'TK-VI', '0000002', 'Анатолий', 'Карпов', 'Евгеньевич', 3, 9, 11, 30, 2, '79263337744', NULL);
CALL add_employee_proc('100012', '4766', '2013-02-18', '789-012-305 67', '666777888999', 'TK-VI', '0000003', 'Левон', 'Аронян', NULL, 3, 12, 14, 19, 3, '79267776655', NULL);
CALL add_employee_proc('330985', '4987', '2022-08-07', '890-003-456 78', '777888999000', 'TK-VI', '0000004', 'Янник', 'Пельтье', NULL, 3, 13, 15, 22, 4, '79265559922', NULL);
CALL add_employee_proc('000788', '8900', '2010-05-05', '123-056-789 12', '000111222333', 'TK-VI', '0000005', 'Алиреза', 'Фируджа', NULL, 3, 15, 18, 7, 3, '79264448833', NULL);

--Клиент
CALL add_client_proc('123456', '4510', '2015-05-01', '654321', '4570', '2019-03-01', '123-456-789 12', '123400089101', 'Бобби', 'Фишер', NULL, 1, 1, 15, 5, 2, 2, 8, 3, '71333467890', NULL);
CALL add_client_proc('223344', '4509', '2014-06-10', '765432', '4571', '2020-07-15', '234-567-890 23', '123456789102', 'Ольга', 'Борисова', 'Владимировна', 3, 5, 12, 4, 1, 6, 9, 5, '71445566789', NULL);
CALL add_client_proc('334455', '4511', '2013-09-20', '876543', '4572', '2018-11-11', '345-678-901 34', '123456789103', 'Михаил', 'Ботвинник', NULL, 2, 7, 11, NULL, 3, 3, 12, 2, '71556677890', NULL);
CALL add_client_proc('445566', '4512', '2012-11-05', '987654', '4573', '2021-02-28', '456-789-012 45', '123456789104', 'Владимир', 'Крамник', NULL, 4, 8, 10, NULL, NULL, NULL, NULL, NULL, '71667788990', NULL);
CALL add_client_proc('556677', '4513', '2021-12-15', '414141', '0934', '2021-02-28', '567-890-123 56', '123456789105', 'Магнус', 'Карлсен', NULL, NULL, NULL, NULL, NULL, 5, 10, 15, 6, '71778899000', NULL);
CALL add_client_proc('667788', '4514', '2011-01-30', '987054', '4573', '2017-05-20', '678-901-234 67', '123456789106', 'Эмануил', 'Ласкер', NULL, 6, 9, 14, 8, NULL, NULL, NULL, NULL, '71889900112', NULL);
CALL add_client_proc('778899', '4515', '2009-04-22', '252525', '4573', '2021-02-28', '789-012-345 78', '123456789107', 'Тигран', 'Петросян', NULL, 7, 11, 13, 7, 8, 5, 15, 3, '71990011223', NULL);
CALL add_client_proc('889900', '4516', '2010-08-14', '147258', '4574', '2018-09-10', '890-123-456 89', '223344556677', 'Андрей', 'Иванов', 'Петрович', 3, 5, 12, 9, 1, 2, 7, 6, '72001122334', NULL);
CALL add_client_proc('990011', '4517', '2019-02-03', '369147', '4575', '2020-01-22', '901-234-567 90', '334455667788', 'Мария', 'Сидорова', NULL, 4, 6, 13, NULL, 2, 9, 8, 2, '72112233445', NULL);
CALL add_client_proc('101112', '4518', '2023-03-25', '481269', '4576', '2022-06-18', '012-345-678 01', '445566778899', 'Сергей', 'Кузнецов', NULL, 5, 7, 14, 6, NULL, 11, 5, 4, '72223344556', NULL);
CALL add_client_proc('112233', '4519', '2022-07-09', '592481', '4577', '2023-05-10', '123-456-789 02', '556677889900', 'Екатерина', 'Воронина', NULL, 6, 8, 15, 3, 4, 6, 9, NULL, '72334455667', NULL);
CALL add_client_proc('200044', '4520', '2020-11-15', '603592', '4578', '2019-08-05', '234-567-890 03', '667788990011', 'Дмитрий', 'Орлов', NULL, 7, 9, 16, NULL, NULL, NULL, NULL, 5, '72445566778', NULL);
CALL add_client_proc('303555', '4521', '2018-12-20', '714603', '4579', '2017-12-31', '345-678-901 04', '778899001112', 'Александра', 'Смирнова', NULL, 8, 10, 11, 4, 5, 4, 13, 8, '72556677889', NULL);
CALL add_client_proc('445866', '4522', '2017-09-29', '825714', '4580', '2016-03-19', '456-789-012 05', '889900112233', 'Владимир', 'Соколов', NULL, 9, 11, 12, NULL, 7, 12, 10, 7, '72667788990', NULL);
CALL add_client_proc('556077', '4523', '2015-04-04', '936825', '4581', '2014-10-02', '567-890-123 06', '990011223344', 'Анна', 'Крылова', NULL, 10, 12, 14, NULL, 6, 10, 8, NULL, '72778899011', NULL);
CALL add_client_proc('611118', '4524', '2014-08-11', '147936', '4582', '2013-07-21', '678-901-234 07', '101112334455', 'Максим', 'Захаров', NULL, 11, 13, 15, 2, 8, 7, 6, 9, '72889900122', NULL);
CALL add_client_proc('799999', '4525', '2013-01-16', '258147', '4583', '2012-05-28', '789-012-345 08', '112233445566', 'Ольга', 'Рябова', NULL, 12, 14, 16, 10, NULL, NULL, NULL, 3, '72990011234', NULL);

--Типы организаций
CALL add_organization_type_proc('ООО', NULL);
CALL add_organization_type_proc('ЗАО', NULL);
CALL add_organization_type_proc('ИП', NULL);
CALL add_organization_type_proc('ОАО', NULL);

--Детали тарифов
CALL add_tariff_detail_proc('Экскурсия Красная площадь', 5000, 'Отель', true, NULL);
CALL add_tariff_detail_proc('Поход Алтай', 7000, 'Палатка', false, NULL);
CALL add_tariff_detail_proc('Круиз Средиземное море', 15000, 'Яхта', true, NULL);
CALL add_tariff_detail_proc('Горнолыжный отдых на Красной Поляне', 20000, 'Пещера', false, NULL);
CALL add_tariff_detail_proc('Сафари в Африке', 0, 'Под открытым небом', true, NULL);
CALL add_tariff_detail_proc('Отдых в Анапе', 10000, 'Шлюпка', false, NULL);
CALL add_tariff_detail_proc('Культурный тур Санкт-Петербург', 8000, 'Подъезд', true, NULL);
CALL add_tariff_detail_proc('Поездка в Байкал', 6000, 'Юрта', false, NULL);
CALL add_tariff_detail_proc('Путешествие по Камчатке', 0, 'Кемпер', true, NULL);
CALL add_tariff_detail_proc('Тур по Золотому кольцу России', 7500, 'Хостел', false, NULL);
CALL add_tariff_detail_proc('Сплав по реке Волга', 5500, 'Лодка', true, NULL);
CALL add_tariff_detail_proc('Тур к Северному сиянию', 18000, 'Иглу', false, NULL);
CALL add_tariff_detail_proc('Экспедиция в Чукотку', 22000, 'Лагерь', true, NULL);
CALL add_tariff_detail_proc('Гастрономический тур Италия', 0, 'Ресторан', true, NULL);
CALL add_tariff_detail_proc('Отдых на Сейшелах', 30000, 'Бунгало', false, NULL);
CALL add_tariff_detail_proc('Круиз по Карибским островам', 40000, 'Лайнер', true, NULL);
CALL add_tariff_detail_proc('Экскурсия в Эрмитаж', 3000, 'Апартаменты', false, NULL);

--Партнеры
CALL add_partner(1, 'Агенство РЕКЕТИР', NULL);
CALL add_partner(2, 'Планета', NULL);
CALL add_partner(3, 'С огоньком', NULL);

--Доп. услуги
CALL add_additional_service(1, 'Трансфер до отеля', 300, NULL);
CALL add_additional_service(1, 'Экскурсионное сопровождение', 1000, NULL);
CALL add_additional_service(2, 'Прокат снаряжения', 500, NULL);
CALL add_additional_service(2, 'Гид на маршруте', 2000, NULL);
CALL add_additional_service(3, 'Обучение танцу крабика', 1500, NULL);
CALL add_additional_service(3, 'Охота на крокодилов', 2500, NULL);
CALL add_additional_service(2, 'Прокат лыжного снаряжения', 1000, NULL);
CALL add_additional_service(3, 'Обучение катанию на сноуборде', 3500, NULL);
CALL add_additional_service(3, 'Гид-натуралист', 1500, NULL);
CALL add_additional_service(1, 'Фотосессия на сафари', 2000, NULL);
CALL add_additional_service(1, 'Аренда лежаков на пляже', 300, NULL);
CALL add_additional_service(3, 'Организация пикника', 2500, NULL);
CALL add_additional_service(2, 'Билеты в музеи', 1200, NULL);
CALL add_additional_service(2, 'Услуги переводчика', 3000, NULL);
CALL add_additional_service(3, 'Рыбалка с гидом', 1000, NULL);
CALL add_additional_service(1, 'Экскурсия по местным деревням', 2000, NULL);


--Контакты партнеров
CALL add_partner_contact(1, '74951234567', 'info@reketir.ru', NULL);
CALL add_partner_contact(1, '74951254167', 'support@reketir.ru', NULL);
CALL add_partner_contact(2, '74953454567', 'contact@planet.ru', NULL);
CALL add_partner_contact(3, '74187634567', 'blewUpWith@flame.up', NULL);
CALL add_partner_contact(3, '74959785567', 'smilingknight@hailrake.arthas', NULL);
CALL add_partner_contact(3, '74951200007', 'Q_Pal@gmail.com', NULL);

--Тарифы
CALL add_tariff(1, 1, 'Москва слезам не верит', NULL);
CALL add_tariff(2, 1, 'С холодком', NULL);
CALL add_tariff(3, 2, 'Любителям искупаться', NULL);
CALL add_tariff(6, 2, 'Депрессия', NULL);
CALL add_tariff(4, 3, 'Догони меня лавина', NULL);
CALL add_tariff(5, 3, 'Экстрим для всей семьи', NULL);
CALL add_tariff(7, 1, 'Культурное наследие', NULL);
CALL add_tariff(8, 1, 'Дух Байкала', NULL);
CALL add_tariff(9, 2, 'На краю земли', NULL);
CALL add_tariff(10, 2, 'Великие города России', NULL);
CALL add_tariff(11, 3, 'Волга встречает', NULL);
CALL add_tariff(12, 3, 'Ледяное чудо', NULL);
CALL add_tariff(13, 2, 'Покорители Чукотки', NULL);
CALL add_tariff(14, 3, 'Итальянские вкусы', NULL);
CALL add_tariff(15, 3, 'Райский отдых', NULL);
CALL add_tariff(16, 3, 'Карибское наслаждение', NULL);
CALL add_tariff(17, 1, 'Историческая экскурсия', NULL);


--Контракты
CALL add_contract_proc(6, 1, 2, 3, 6, '2025-01-23', '2025-01-24', '2025-01-30', NULL, NULL);
CALL add_contract_proc(NULL, 1, 3, 1, 1, '2025-01-23', '2025-02-01', '2025-02-10', 'Трансфер до отеля включен', NULL);
CALL add_contract_proc(NULL, 2, 3, 1, 2, '2025-01-24', '2025-02-05', '2025-02-15', 'Экскурсионное сопровождение включено', NULL);
CALL add_contract_proc(3, 3, 3, 2, 3, '2025-01-25', '2025-03-01', '2025-03-10', 'Гид на маршруте обеспечен', NULL);
CALL add_contract_proc(NULL, 4, 3, 3, 6, '2025-01-26', '2025-03-15', '2025-03-25', 'Дополнительные услуги не включены', NULL);
CALL add_contract_proc(5, 5, 3, 3, 5, '2025-01-27', '2025-04-01', '2025-04-10', 'Обучение танцу крабика запланировано', NULL);
CALL add_contract_proc(6, 6, 3, 3, 5, '2025-01-28', '2025-04-20', '2025-04-30', 'Охота на крокодилов организована', NULL);
CALL add_contract_proc(1, 1, 3, 1, 1, '2025-01-29', '2025-05-01', '2025-05-05', 'Трансфер до отеля включен', NULL);
CALL add_contract_proc(NULL, 2, 3, 1, 2, '2025-01-30', '2025-06-10', '2025-06-20', 'Экскурсионное сопровождение предоставлено', NULL);
CALL add_contract_proc(2, 3, 3, 1, 1, '2025-01-31', '2025-07-01', '2025-07-10', 'Гид на маршруте обеспечен', NULL);
CALL add_contract_proc(NULL, 4, 3, 3, 6, '2025-02-01', '2025-08-15', '2025-08-25', NULL, NULL);
CALL add_contract_proc(NULL, 6, 3, 3, 5, '2025-02-03', '2025-10-01', '2025-10-15', NULL, NULL);
CALL add_contract_proc(NULL, 1, 3, 1, 1, '2025-02-04', '2025-11-01', '2025-11-10', NULL, NULL);
CALL add_contract_proc(NULL, 8, 3, 2, 3, '2025-02-06', '2025-12-01', '2025-12-10', NULL, NULL);
CALL add_contract_proc(NULL, 3, 3, 2, 3, '2025-02-18', '2026-12-01', '2026-12-10', 'Гид-натуралист включен', NULL);
CALL add_contract_proc(NULL, 4, 3, 1, 1, '2025-02-19', '2027-01-01', '2027-01-15', NULL, NULL);
CALL add_contract_proc(NULL, 5, 3, 3, 6, '2025-02-20', '2027-02-01', '2027-02-10', NULL, NULL);
CALL add_contract_proc(NULL, 6, 3, 2, 3, '2025-02-21', '2027-03-01', '2027-03-10', NULL, NULL);
CALL add_contract_proc(10, 7, 3, 1, 2, '2025-02-22', '2027-04-01', '2027-04-15', NULL, NULL);
CALL add_contract_proc(12, 9, 3, 3, 5, '2025-02-24', '2027-06-01', '2027-06-10', NULL, NULL);
CALL add_contract_proc(9, 2, 3, 3, 6, '2025-02-17', '2026-11-01', '2026-11-10', NULL, NULL);
CALL add_contract_proc(NULL, 11, 3, 3, 5, '2025-02-09', '2026-03-01', '2026-03-10', NULL, NULL);
CALL add_contract_proc(5, 14, 3, 3, 5, '2025-02-12', '2026-06-01', '2026-06-10', 'Фотосессия на сафари включена', NULL);
CALL add_contract_proc(NULL, 16, 3, 2, 10, '2025-02-14', '2026-08-01', '2026-08-10', NULL, NULL);
CALL add_contract_proc(12, 17, 3, 3, 5, '2025-02-15', '2026-09-01', '2026-09-10', NULL, NULL);
CALL add_contract_proc(16, 1, 3, 1, 2, '2025-02-16', '2026-10-01', '2026-10-15', NULL, NULL);
CALL add_contract_proc(14, 9, 3, 2, 3, '2025-02-07', '2026-01-01', '2026-01-15', NULL, NULL);
CALL add_contract_proc(4, 12, 3, 2, 9, '2025-02-10', '2026-04-01', '2026-04-10', NULL, NULL);
















--Представления


--Все пользователи
CREATE OR REPLACE VIEW all_users AS
SELECT 
    CliID AS UserID,
    CONCAT(FNameCli, ' ', FaNameCli, COALESCE(' ' || LNameCli, '')) AS FullName,
    'Client' AS UserType
FROM Client
WHERE isDeleted = false
UNION ALL
SELECT 
    EmpID AS UserID,
    CONCAT(FNameEmp, ' ', FaNameEmp, COALESCE(' ' || LNameEmp, '')) AS FullName,
    'Employee' AS UserType
FROM Employee
WHERE isDeleted = false;

--Список активности клиентов
CREATE OR REPLACE VIEW user_activity_logs AS
SELECT 
    TreatyID,
    CliID AS UserID,
    TreatySignDate AS "Подписан",
    Comment
FROM Contract;

--Доступные тарифы
CREATE OR REPLACE VIEW available_tour_packages AS
SELECT
    t.TariffID AS TariffID,
    t.TariffTitle AS TariffTitle,
    p.PartnerTitle AS PartnerName,
    td.TariffType AS TariffType,
    td.TariffLocating AS TariffLocating,
    td.TariffInsurance AS TariffInsurance,
    td.TariffPrice AS TariffPrice
FROM
    Tariff t
JOIN
    TariffDetails td ON t.TariffDetailID = td.TariffDetailID
JOIN
    Partner p ON t.PartnerID = p.PartnerID
WHERE
    t.isDeleted = false
    AND td.isDeleted = false
    AND p.isDeleted = false
ORDER BY
    t.TariffID;

--Статус своих поездок
CREATE OR REPLACE VIEW user_activity_log AS
SELECT 
    c.CliID AS ClientID,
    c.FNameCli AS "Имя клиента",
    c.LNameCli AS "Фамилия клиента",
    e.EmpID AS EmployeeID,
    e.FNameEmp AS "Имя сотрудника",
    e.LNameEmp AS "Фамилия сотрудника",
    con.TreatyID AS ContractID,
    con.TreatySignDate AS "Дата подписания",
    con.TreatyStartDate AS "Начало действия",
    con.TreatyStopDate AS "Конец действия",
    con.Comment AS "Комментарий",
    CASE 
        WHEN con.TreatyStopDate < CURRENT_DATE THEN 'Завершен'
        WHEN con.TreatyStartDate <= CURRENT_DATE AND con.TreatyStopDate >= CURRENT_DATE THEN 'В действии'
        ELSE 'Будущий'
    END AS ContractStatus
FROM 
    Contract con
JOIN Client c ON con.CliID = c.CliID
JOIN Employee e ON con.EmpID = e.EmpID
WHERE 
    c.isDeleted = FALSE 
    AND e.isDeleted = FALSE;

--Получить информацию о статусе своего договора
CREATE OR REPLACE VIEW get_contract_status AS
SELECT TreatyID AS "ID", TreatySignDate, TreatyStartDate, TreatyStopDate,
CASE
    WHEN TreatyStopDate < CURRENT_DATE THEN 'Завершен'
    WHEN TreatyStartDate <= CURRENT_DATE AND TreatyStopDate >= CURRENT_DATE THEN 'Действует'
    ELSE 'Будущий'
END AS ContractStatus
FROM Contract;

--Получить список договоров
CREATE OR REPLACE VIEW all_contracts AS
SELECT * FROM Contract;

--Получить список сотрудников
CREATE OR REPLACE VIEW all_employee AS
SELECT * FROM Employee;

--Получить список клиентов
CREATE OR REPLACE VIEW all_clients AS
SELECT * FROM Client;

--Посмотреть все предложения
CREATE OR REPLACE VIEW all_tariffs AS
SELECT * FROM Tariff;

--Список своих активных договоров
CREATE OR REPLACE VIEW active_contracts AS
SELECT * FROM Contract WHERE TreatyStartDATE <= CURRENT_DATE AND TreatyStopDate >= CURRENT_DATE;

--Получить данные своих документов
CREATE OR REPLACE VIEW client_documents_view AS
SELECT
    c.CliID,
    c.FNameCli,
    c.LNameCli,
    c.FaNameCli,
    mpc.MainPassNumCli AS MainPassportNumber,
    mpc.MainPassSeriesCli AS MainPassportSeries,
    mpc.MainPassDateCli AS MainPassportDate,
    ipc.InterPassNumCli AS InternationalPassportNumber,
    ipc.InterPassSeriesCli AS InternationalPassportSeries,
    ipc.InterPassDateCli AS InternationalPassportIssueDate,
    sc.SnilsCli AS Snils,
    ic.InnCli AS Inn
FROM
    Client c
LEFT JOIN ClientDocuments cd ON c.ClientDocumentsID = cd.ClientDocumentsID
LEFT JOIN MainPassesCli mpc ON cd.MainPassCliID = mpc.MainPassCliID
LEFT JOIN InterPassesCli ipc ON cd.InterPassCliID = ipc.InterPassCliID
LEFT JOIN SnilsCli sc ON cd.SnilsCliID = sc.SnilsCliID
LEFT JOIN InnCli ic ON cd.InnCliID = ic.InnCliID;

--Посмотреть все комбинации предложений
CREATE OR REPLACE VIEW tariff_service_combinations AS
SELECT 
    p.PartnerID,
    p.PartnerTitle,
    pot.PartnerOrgType AS OrganizationType,
    t.TariffID,
    t.TariffTitle,
    td.TariffType,
    td.TariffPrice,
    td.TariffLocating,
    td.TariffInsurance,
    s.ServiceID,
    s.ServiceDescription,
    s.ServicePrice
FROM 
    Partner p
INNER JOIN PartnerOrgTypes pot ON p.PartnerOrgTypeID = pot.PartnerOrgTypeID
LEFT JOIN Tariff t ON p.PartnerID = t.PartnerID AND t.isDeleted = false
LEFT JOIN TariffDetails td ON t.TariffDetailID = td.TariffDetailID AND td.isDeleted = false
LEFT JOIN AdditionalService s ON p.PartnerID = s.PartnerID AND s.isDeleted = false
WHERE 
    p.isDeleted = false
ORDER BY 
    p.PartnerID, t.TariffID, s.ServiceID;








--Индексы


-- Индексы для таблицы Client
CREATE INDEX idx_client_regcity ON Client(RegCityID);
CREATE INDEX idx_client_rescity ON Client(ResCityID);

-- Индексы для таблицы Tariff
CREATE INDEX idx_tariff_partner ON Tariff(PartnerID);
CREATE INDEX idx_tariff_detail ON Tariff(TariffDetailID);

-- Индексы для таблицы Contract
CREATE INDEX idx_contract_client ON Contract(CliID);
CREATE INDEX idx_contract_employee ON Contract(EmpID);
CREATE INDEX idx_contract_partner ON Contract(PartnerID);
CREATE INDEX idx_contract_tariff ON Contract(TariffID);
CREATE INDEX idx_contract_service ON Contract(ServiceID);
CREATE INDEX idx_contract_sign_date ON Contract(TreatySignDate);
CREATE INDEX idx_contract_start_date ON Contract(TreatyStartDate);
CREATE INDEX idx_contract_stop_date ON Contract(TreatyStopDate);

-- Индексы для таблицы AdditionalService
CREATE INDEX idx_additional_service_partner ON AdditionalService(PartnerID);

-- Индексы для таблицы TariffDetails
CREATE INDEX idx_tariffdetails_type ON TariffDetails(TariffType);

-- Индексы BRIN для полей цены
CREATE INDEX brin_tariff_price ON TariffDetails USING brin(TariffPrice);
CREATE INDEX brin_service_price ON AdditionalService USING brin(ServicePrice);








CREATE ROLE admin WITH LOGIN PASSWORD '1' SUPERUSER;
CREATE ROLE sales_manager WITH LOGIN PASSWORD '1' ;
CREATE ROLE accountant WITH LOGIN PASSWORD '1';
CREATE ROLE client WITH LOGIN PASSWORD '1';
CREATE ROLE auditor WITH LOGIN PASSWORD '1';
CREATE ROLE partner WITH LOGIN PASSWORD '1';




--Contract
GRANT SELECT ON TABLE Contract TO sales_manager, accountant, client, auditor, partner;
GRANT SELECT, UPDATE ON SEQUENCE contract_treatyid_seq TO accountant, sales_manager;
GRANT SELECT ON TABLE Contract TO client, auditor, partner;
GRANT SELECT ON SEQUENCE contract_treatyid_seq TO client, auditor, partner;

--Client, ClientDocuments
GRANT SELECT ON TABLE Client TO sales_manager;
GRANT SELECT ON TABLE client_documents_view TO sales_manager;
GRANT SELECT ON TABLE clientdocuments TO sales_manager;
GRANT SELECT ON SEQUENCE clientdocuments_clientdocumentsid_seq TO sales_manager;

GRANT SELECT, UPDATE, INSERT ON TABLE Client TO accountant, client; 
GRANT SELECT, UPDATE, INSERT ON TABLE client_documents_view TO accountant, client;
GRANT SELECT, UPDATE, INSERT ON TABLE clientdocuments TO accountant, client;
GRANT SELECT, UPDATE ON SEQUENCE clientdocuments_clientdocumentsid_seq TO accountant, client;

GRANT SELECT ON TABLE Client TO auditor;
GRANT SELECT ON TABLE client_documents_view TO auditor;
GRANT SELECT ON TABLE clientdocuments TO auditor;
GRANT SELECT ON SEQUENCE clientdocuments_clientdocumentsid_seq TO auditor;

REVOKE ALL ON TABLE Client FROM partner;
REVOKE ALL ON TABLE client_documents_view FROM partner;
REVOKE ALL ON TABLE clientdocuments FROM partner;
REVOKE ALL ON SEQUENCE clientdocuments_clientdocumentsid_seq FROM partner;

--MainPassesCli
GRANT SELECT ON TABLE MainPassesCli TO sales_manager, accountant, client, auditor;
GRANT SELECT ON SEQUENCE mainpassescli_mainpasscliid_seq TO sales_manager, accountant, client, auditor;
GRANT UPDATE, INSERT ON TABLE MainPassesCli TO sales_manager, accountant, client, auditor;
GRANT UPDATE ON SEQUENCE mainpassescli_mainpasscliid_seq TO sales_manager, accountant, client, auditor;

REVOKE ALL ON TABLE MainPassesCli FROM partner;
REVOKE ALL ON SEQUENCE mainpassescli_mainpasscliid_seq FROM partner;

--InterPassesCli
GRANT SELECT ON TABLE InterPassesCli TO sales_manager, accountant, client, auditor;
GRANT SELECT ON SEQUENCE interpassescli_interpasscliid_seq TO sales_manager, accountant, client, auditor;
GRANT UPDATE, INSERT ON TABLE interPassesCli TO sales_manager, accountant, client, auditor;
GRANT UPDATE ON SEQUENCE interpassescli_interpasscliid_seq TO sales_manager, accountant, client, auditor;

REVOKE ALL ON TABLE InterPassesCli FROM partner;
REVOKE ALL ON SEQUENCE interpassescli_interpasscliid_seq FROM partner;

--SnilsCli
GRANT SELECT ON TABLE SnilsCli TO sales_manager, accountant, client, auditor;
GRANT SELECT ON SEQUENCE snilscli_snilscliid_seq TO sales_manager, accountant, client, auditor;
GRANT UPDATE, INSERT ON TABLE SnilsCli TO sales_manager, accountant, client, auditor;
GRANT UPDATE ON SEQUENCE snilscli_snilscliid_seq TO sales_manager, accountant, client, auditor;

REVOKE ALL ON TABLE SnilsCli FROM partner;
REVOKE ALL ON SEQUENCE snilscli_snilscliid_seq FROM partner;

--InnCli
GRANT SELECT ON TABLE InnCli TO sales_manager, accountant, client, auditor;
GRANT SELECT ON SEQUENCE inncli_inncliid_seq TO sales_manager, accountant, client, auditor;
GRANT UPDATE, INSERT ON TABLE InnCli TO sales_manager, accountant, client, auditor;
GRANT UPDATE ON SEQUENCE inncli_inncliid_seq TO sales_manager, accountant, client, auditor;

REVOKE ALL ON TABLE InnCli FROM partner;
REVOKE ALL ON SEQUENCE inncli_inncliid_seq FROM partner;

--Employee, EmployeeDocuments
REVOKE ALL ON TABLE Employee FROM client, sales_manager, partner;
REVOKE ALL ON TABLE EmployeeDocuments FROM client, sales_manager, partner;
REVOKE ALL ON TABLE EmpRole FROM client, sales_manager, partner;
REVOKE ALL ON SEQUENCE employee_empid_seq FROM client, sales_manager, partner;
REVOKE ALL ON SEQUENCE employeedocuments_employeedocumentsid_seq FROM client, sales_manager, partner;
REVOKE ALL ON SEQUENCE emprole_emproleid_seq FROM client, sales_manager, partner;

GRANT SELECT, UPDATE, INSERT ON TABLE Employee TO accountant;
GRANT SELECT, UPDATE, INSERT ON TABLE EmployeeDocuments TO accountant;
GRANT SELECT, UPDATE, INSERT ON TABLE EmpRole TO accountant;
GRANT SELECT, UPDATE ON SEQUENCE employee_empid_seq TO accountant;
GRANT SELECT, UPDATE ON SEQUENCE employeedocuments_employeedocumentsid_seq TO accountant;
GRANT SELECT, UPDATE ON SEQUENCE emprole_emproleid_seq TO accountant;

GRANT SELECT ON TABLE Employee TO auditor;
GRANT SELECT ON TABLE EmployeeDocuments TO auditor;
GRANT SELECT ON TABLE EmpRole TO auditor;
GRANT SELECT ON SEQUENCE employee_empid_seq TO auditor;
GRANT SELECT ON SEQUENCE employeedocuments_employeedocumentsid_seq TO auditor;
GRANT SELECT ON SEQUENCE emprole_emproleid_seq TO auditor;

--PassesEmp
REVOKE ALL ON TABLE PassesEmp FROM sales_manager, client, partner;
REVOKE ALL ON SEQUENCE passesemp_passempid_seq FROM sales_manager, client, partner;

GRANT SELECT, UPDATE, INSERT ON TABLE PassesEmp TO accountant;
GRANT SELECT, UPDATE ON SEQUENCE passesemp_passempid_seq TO accountant;

GRANT SELECT ON TABLE PassesEmp TO auditor;
GRANT SELECT ON SEQUENCE passesemp_passempid_seq TO auditor;

--WrkBooksEmp
REVOKE ALL ON TABLE WrkBooksEmp FROM sales_manager, client, partner;
REVOKE ALL ON SEQUENCE wrkbooksemp_wrkempid_seq FROM sales_manager, client, partner;

GRANT SELECT, UPDATE, INSERT ON TABLE WrkBooksEmp TO accountant;
GRANT SELECT, UPDATE ON SEQUENCE wrkbooksemp_wrkempid_seq TO accountant;

GRANT SELECT ON TABLE WrkBooksEmp TO auditor;
GRANT SELECT ON SEQUENCE wrkbooksemp_wrkempid_seq TO auditor;

--SnilsEmp
REVOKE ALL ON TABLE SnilsEmp FROM sales_manager, client, partner;
REVOKE ALL ON SEQUENCE snilsemp_snilsempid_seq FROM sales_manager, client, partner;

GRANT SELECT, UPDATE, INSERT ON TABLE SnilsEmp TO accountant;
GRANT SELECT, UPDATE ON SEQUENCE snilsemp_snilsempid_seq TO accountant;

GRANT SELECT ON TABLE SnilsEmp TO auditor;
GRANT SELECT ON SEQUENCE snilsemp_snilsempid_seq TO auditor;

--InnEmp
REVOKE ALL ON TABLE InnEmp FROM sales_manager, client, partner;
REVOKE ALL ON SEQUENCE innemp_innempid_seq FROM sales_manager, client, partner;

GRANT SELECT, UPDATE, INSERT ON TABLE InnEmp TO accountant;
GRANT SELECT, UPDATE ON SEQUENCE innemp_innempid_seq TO accountant;

GRANT SELECT ON TABLE InnEmp TO auditor;
GRANT SELECT ON SEQUENCE innemp_innempid_seq TO auditor;

--EmpRole
GRANT SELECT, UPDATE, INSERT ON TABLE EmpRole TO accountant;
GRANT SELECT, UPDATE ON SEQUENCE emprole_emproleid_seq TO accountant;
GRANT SELECT ON TABLE EmpRole TO sales_manager;
GRANT SELECT ON SEQUENCE emprole_emproleid_seq TO sales_manager;

REVOKE ALL ON TABLE EmpRole FROM client, auditor;
REVOKE ALL ON SEQUENCE emprole_emproleid_seq FROM sales_manager, client, auditor;

--Partner, PartnerContacts, PartnerOrgTypes
GRANT SELECT ON TABLE Partner TO sales_manager, accountant, client;
GRANT SELECT ON TABLE PartnerContacts TO sales_manager, accountant, client;
REVOKE ALL ON TABLE PartnerNotifications FROM sales_manager, accountant, client, auditor;
GRANT SELECT ON TABLE PartnerOrgTypes TO sales_manager, accountant, client;
GRANT SELECT ON SEQUENCE partner_partnerid_seq TO sales_manager, accountant, client;
GRANT SELECT ON SEQUENCE partnercontacts_contactid_seq TO sales_manager, accountant, client;
GRANT SELECT ON SEQUENCE partnernotifications_notificationid_seq TO sales_manager, accountant, client;
GRANT SELECT ON SEQUENCE partnerorgtypes_partnerorgtypeid_seq TO sales_manager, accountant, client;
GRANT INSERT ON TABLE PartnerOrgTypes TO accountant;
GRANT SELECT, UPDATE ON SEQUENCE partnerorgtypes_partnerorgtypeid_seq TO accountant;

GRANT SELECT, UPDATE, INSERT ON TABLE Partner TO partner, accountant;
GRANT SELECT, UPDATE, INSERT ON TABLE PartnerContacts TO partner, accountant;
GRANT SELECT, UPDATE, INSERT ON TABLE PartnerOrgTypes TO partner, accountant;
GRANT SELECT, UPDATE ON SEQUENCE partner_partnerid_seq TO partner, accountant;
GRANT SELECT, UPDATE ON SEQUENCE partnercontacts_contactid_seq TO partner, accountant;
GRANT SELECT, UPDATE ON SEQUENCE partnernotifications_notificationid_seq TO partner;
GRANT SELECT, UPDATE ON SEQUENCE partnerorgtypes_partnerorgtypeid_seq TO partner;

--Tariff
GRANT SELECT ON TABLE Tariff TO sales_manager, accountant, client;
GRANT SELECT ON TABLE TariffDetails TO sales_manager, accountant, client;
GRANT SELECT ON TABLE tariff_service_combinations TO sales_manager, accountant, client;
GRANT SELECT ON SEQUENCE tariffdetails_tariffdetailid_seq TO sales_manager, accountant, client;
GRANT SELECT ON SEQUENCE tariff_tariffid_seq TO sales_manager, accountant, client;

GRANT SELECT, UPDATE, INSERT ON TABLE Tariff TO partner, accountant;
GRANT SELECT, UPDATE, INSERT ON TABLE TariffDetails TO partner, accountant;
GRANT SELECT, UPDATE, INSERT ON TABLE tariff_service_combinations TO partner, accountant;
GRANT SELECT, UPDATE ON SEQUENCE tariffdetails_tariffdetailid_seq TO partner, accountant;
GRANT SELECT, UPDATE ON SEQUENCE tariff_tariffid_seq TO partner, accountant;

REVOKE ALL ON TABLE Tariff FROM auditor;
REVOKE ALL ON TABLE TariffDetails FROM auditor;
REVOKE ALL ON TABLE tariff_service_combinations FROM auditor;
REVOKE ALL ON SEQUENCE tariffdetails_tariffdetailid_seq FROM auditor;
REVOKE ALL ON SEQUENCE tariff_tariffid_seq FROM auditor;

--AdditionalService
GRANT SELECT ON TABLE AdditionalService TO sales_manager, accountant, client;
GRANT SELECT ON SEQUENCE additionalservice_serviceid_seq TO sales_manager, accountant, client;

GRANT SELECT, UPDATE, INSERT ON TABLE AdditionalService TO partner, accountant;
GRANT SELECT, UPDATE ON SEQUENCE additionalservice_serviceid_seq TO partner, accountant;

REVOKE ALL ON TABLE AdditionalService FROM auditor;
REVOKE ALL ON SEQUENCE additionalservice_serviceid_seq FROM auditor;


--Cities
GRANT SELECT ON TABLE Cities TO sales_manager, accountant, client, auditor;
GRANT UPDATE ON TABLE Cities TO accountant;
GRANT INSERT ON TABLE Cities TO accountant;
GRANT SELECT ON SEQUENCE cities_cityid_seq TO sales_manager, accountant, client, auditor;
GRANT UPDATE ON SEQUENCE cities_cityid_seq TO accountant;
GRANT UPDATE ON SEQUENCE cities_cityid_seq TO accountant;

--Streets
GRANT SELECT ON TABLE Streets TO sales_manager, accountant, client, auditor;
GRANT UPDATE ON TABLE Streets TO accountant;
GRANT INSERT ON TABLE Streets TO accountant;
GRANT SELECT ON SEQUENCE streets_streetid_seq TO sales_manager, accountant, client, auditor;
GRANT UPDATE ON SEQUENCE streets_streetid_seq TO accountant;
GRANT UPDATE ON SEQUENCE streets_streetid_seq TO accountant;




--Представления
GRANT SELECT ON TABLE user_activity_logs TO sales_manager, accountant;
REVOKE ALL ON TABLE user_activity_logs FROM client, partner, auditor;

GRANT SELECT ON TABLE available_tour_packages TO sales_manager, accountant, client, partner;
REVOKE ALL ON TABLE available_tour_packages FROM auditor;

GRANT SELECT ON TABLE user_activity_log TO client, accountant;
REVOKE ALL ON TABLE user_activity_log FROM sales_manager, partner, auditor;

GRANT SELECT ON TABLE get_contract_status TO sales_manager, accountant, client, partner;
REVOKE ALL ON TABLE get_contract_status FROM auditor;

GRANT SELECT ON TABLE all_contracts TO accountant, auditor, client, sales_manager, auditor;

GRANT SELECT ON TABLE all_employee TO accountant, auditor;
REVOKE ALL ON TABLE all_employee FROM partner, client, sales_manager;

GRANT SELECT ON TABLE all_clients TO accountant, auditor;
REVOKE ALL ON TABLE all_clients FROM client, partner;

GRANT SELECT ON TABLE all_tariffs TO accountant, sales_manager, client, partner;
REVOKE ALL ON TABLE all_tariffs FROM auditor;

GRANT SELECT ON TABLE active_contracts TO client;
REVOKE ALL ON TABLE active_contracts FROM sales_manager, accountant, auditor, partner;

GRANT SELECT ON TABLE client_documents_view TO client, accountant, auditor;
REVOKE ALL ON TABLE client_documents_view FROM partner, sales_manager;

GRANT SELECT ON TABLE tariff_service_combinations TO client, sales_manager, accountant, partner;
REVOKE ALL ON TABLE tariff_service_combinations FROM auditor;




--Функции

GRANT EXECUTE ON FUNCTION get_client_data(client_id_input INTEGER) TO accountant, auditor, client;
REVOKE EXECUTE ON FUNCTION get_client_data(client_id_input INTEGER) FROM sales_manager, partner;

GRANT EXECUTE ON FUNCTION get_partner_contracts(partner_id INTEGER) TO accountant, sales_manager, partner;
REVOKE EXECUTE ON FUNCTION get_partner_contracts(partner_id INTEGER) FROM client, auditor;

GRANT EXECUTE ON FUNCTION get_contract_status(contract_id INTEGER) TO accountant, sales_manager, client, partner;
REVOKE EXECUTE ON FUNCTION get_contract_status(contract_id INTEGER) FROM auditor;

GRANT EXECUTE ON FUNCTION get_partner_info(partner_id INTEGER) TO accountant, sales_manager, client, partner;
REVOKE EXECUTE ON FUNCTION get_partner_info(partner_id INTEGER) FROM auditor;

GRANT EXECUTE ON FUNCTION get_tariff_info(tariff_id INTEGER) TO accountant, sales_manager, client, partner;
REVOKE EXECUTE ON FUNCTION get_tariff_info(tariff_id INTEGER) FROM auditor;

GRANT EXECUTE ON FUNCTION active_client_contracts(client_id INTEGER) TO accountant, sales_manager, client, partner;
REVOKE EXECUTE ON FUNCTION active_client_contracts(client_id INTEGER) FROM auditor;

GRANT EXECUTE ON FUNCTION get_partner_additional_services(partner_id INTEGER) TO accountant, sales_manager, client, partner;
REVOKE EXECUTE ON FUNCTION get_partner_additional_services(partner_id INTEGER) FROM auditor;

GRANT EXECUTE ON FUNCTION count_deleted_clients() TO accountant;
REVOKE EXECUTE ON FUNCTION count_deleted_clients() FROM auditor, sales_manager, client, partner;

GRANT EXECUTE ON FUNCTION count_all_clients() TO accountant;
REVOKE EXECUTE ON FUNCTION count_all_clients() FROM auditor, sales_manager, client, partner;

GRANT EXECUTE ON FUNCTION count_all_employees() TO accountant;
REVOKE EXECUTE ON FUNCTION count_all_employees() FROM auditor, sales_manager, client, partner;

GRANT EXECUTE ON FUNCTION count_deleted_employees() TO accountant;
REVOKE EXECUTE ON FUNCTION count_deleted_employees() FROM auditor, sales_manager, client, partner;

GRANT EXECUTE ON FUNCTION get_employee_data(employee_id_input INTEGER) TO accountant;
REVOKE EXECUTE ON FUNCTION get_employee_data(employee_id_input INTEGER) FROM auditor, sales_manager, client, partner;

GRANT EXECUTE ON FUNCTION count_pending_contracts(client_id_input INTEGER) TO accountant, sales_manager, client, partner;
REVOKE EXECUTE ON FUNCTION count_pending_contracts(client_id_input INTEGER) FROM auditor;

GRANT EXECUTE ON FUNCTION count_trips_last_n_months(n_months INTEGER) TO accountant;
REVOKE EXECUTE ON FUNCTION count_trips_last_n_months(n_months INTEGER) FROM auditor, sales_manager, partner;

GRANT EXECUTE ON FUNCTION average_trip_cost_last_n_months(n_months INTEGER) TO accountant;
REVOKE EXECUTE ON FUNCTION average_trip_cost_last_n_months(n_months INTEGER) FROM auditor, sales_manager, partner;

GRANT EXECUTE ON FUNCTION get_clients_with_n_trips(n_trips INTEGER) TO accountant;
REVOKE EXECUTE ON FUNCTION get_clients_with_n_trips(n_trips INTEGER) FROM auditor, sales_manager, partner;

GRANT EXECUTE ON FUNCTION get_contracts_by_tariff(tariff_id_input INTEGER) TO accountant, client, partner, sales_manager;
REVOKE EXECUTE ON FUNCTION get_contracts_by_tariff(tariff_id_input INTEGER) FROM auditor;

GRANT EXECUTE ON FUNCTION get_most_popular_tariff() TO accountant;
REVOKE EXECUTE ON FUNCTION get_most_popular_tariff() FROM auditor, sales_manager, partner;

GRANT EXECUTE ON FUNCTION get_clients_in_period(start_date DATE, end_date DATE) TO accountant;
REVOKE EXECUTE ON FUNCTION get_clients_in_period(start_date DATE, end_date DATE) FROM auditor, sales_manager, partner;

GRANT EXECUTE ON FUNCTION get_total_contracts_cost() TO accountant;
REVOKE EXECUTE ON FUNCTION get_total_contracts_cost() FROM auditor, sales_manager, partner;

GRANT EXECUTE ON FUNCTION get_total_contracts_count() TO accountant;
REVOKE EXECUTE ON FUNCTION get_total_contracts_count() FROM auditor, sales_manager, partner;

GRANT EXECUTE ON FUNCTION get_clients_by_tariff_and_period(
    tariff_id INTEGER, 
    start_date DATE, 
    end_date DATE
) TO accountant;
REVOKE EXECUTE ON FUNCTION get_clients_by_tariff_and_period(
    tariff_id INTEGER, 
    start_date DATE, 
    end_date DATE
) FROM auditor, sales_manager, partner;

GRANT EXECUTE ON FUNCTION get_quarter_profit() TO accountant;
REVOKE EXECUTE ON FUNCTION get_quarter_profit() FROM auditor, sales_manager, partner;

GRANT EXECUTE ON FUNCTION get_most_expensive_contracts() TO accountant;
REVOKE EXECUTE ON FUNCTION get_most_expensive_contracts() FROM auditor, sales_manager, partner;

GRANT EXECUTE ON FUNCTION count_users_by_tariff_type(tariff_type_input VARCHAR) TO accountant;
REVOKE EXECUTE ON FUNCTION count_users_by_tariff_type(tariff_type_input VARCHAR) FROM auditor, sales_manager, partner;

GRANT EXECUTE ON FUNCTION generate_financial_report() TO accountant;
REVOKE EXECUTE ON FUNCTION generate_financial_report() FROM auditor, sales_manager, partner;




--Процедуры

GRANT EXECUTE ON PROCEDURE delete_client(client_id INT) TO accountant;
REVOKE EXECUTE ON PROCEDURE delete_client(client_id INT) FROM sales_manager, client, auditor, partner;

GRANT EXECUTE ON PROCEDURE restore_client(client_id INT) TO accountant;
REVOKE EXECUTE ON PROCEDURE restore_client(client_id INT) FROM sales_manager, client, auditor, partner;

GRANT EXECUTE ON PROCEDURE delete_employee(employee_id INT) TO accountant;
REVOKE EXECUTE ON PROCEDURE delete_employee(employee_id INT) FROM sales_manager, client, auditor, partner;

GRANT EXECUTE ON PROCEDURE restore_employee(employee_id INT) TO accountant;
REVOKE EXECUTE ON PROCEDURE restore_employee(employee_id INT) FROM sales_manager, client, auditor, partner;

GRANT EXECUTE ON PROCEDURE delete_partner(partner_id INT) TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE delete_partner(partner_id INT) FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE restore_partner(partner_id INT) TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE restore_partner(partner_id INT) FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE delete_partner_contact(partner_id INT) TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE delete_partner_contact(partner_id INT) FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE delete_partner_service(partner_id INT) TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE delete_partner_service(partner_id INT) FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE delete_partner_tariff(partner_id INT) TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE delete_partner_tariff(partner_id INT) FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE restore_partner_contact(partner_id INT) TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE restore_partner_contact(partner_id INT) FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE restore_partner_service(partner_id INT) TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE restore_partner_service(partner_id INT) FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE restore_partner_tariff(partner_id INT) TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE restore_partner_tariff(partner_id INT) FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE delete_tariff_detail(tariff_detail_id INT) TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE delete_tariff_detail(tariff_detail_id INT) FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE restore_tariff_detail(tariff_detail_id INT) TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE restore_tariff_detail(tariff_detail_id INT) FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE add_city_and_street_proc(
    city varchar,
    street varchar
) TO accountant;
REVOKE EXECUTE ON PROCEDURE add_city_and_street_proc(
    city varchar,
    street varchar
) FROM sales_manager, client, auditor, partner;

GRANT EXECUTE ON PROCEDURE add_contract_proc(
    IN service_id INTEGER,
    IN cli_id INTEGER,
    IN emp_id INTEGER,
    IN partner_id INTEGER,
    IN tariff_id INTEGER,
    IN sign_date DATE,
    IN start_date DATE,
    IN stop_date DATE,
    IN comment TEXT,
    OUT new_treaty_id INTEGER
) TO accountant, sales_manager;
REVOKE EXECUTE ON PROCEDURE add_contract_proc(
    IN service_id INTEGER,
    IN cli_id INTEGER,
    IN emp_id INTEGER,
    IN partner_id INTEGER,
    IN tariff_id INTEGER,
    IN sign_date DATE,
    IN start_date DATE,
    IN stop_date DATE,
    IN comment TEXT,
    OUT new_treaty_id INTEGER
) FROM partner, client, auditor;

GRANT EXECUTE ON PROCEDURE add_organization_type_proc(
    IN org_type varchar,
    OUT new_org_type_id integer
) TO accountant;
REVOKE EXECUTE ON PROCEDURE add_organization_type_proc(
    IN org_type varchar,
    OUT new_org_type_id integer
) FROM sales_manager, client, auditor, partner;

GRANT EXECUTE ON PROCEDURE add_partner(
    partner_org_type_id integer,
    partner_title varchar,
    OUT new_partner_id integer
)   TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE add_partner(
    partner_org_type_id integer,
    artner_title varchar,
    OUT new_partner_id integer
)   FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE add_partner_contact(
    partner_id integer,
    partner_phone varchar,
    partner_email varchar,
    OUT new_contact_id integer
) TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE add_partner_contact(
    partner_id integer,
    partner_phone varchar,
    partner_email varchar,
    OUT new_contact_id integer
) FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE add_tariff_detail_proc(
    tariff_type varchar,
    tariff_price integer,
    tariff_locating varchar,
    tariff_insurance boolean,
    OUT new_tariff_detail_id integer
) TO partner, accountant;
REVOKE EXECUTE ON PROCEDURE add_tariff_detail_proc(
    tariff_type varchar,
    tariff_price integer,
    tariff_locating varchar,
    tariff_insurance boolean,
    OUT new_tariff_detail_id integer
) FROM sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE add_additional_service(
    partner_id integer,
    service_description text,
    service_price integer,
    OUT new_service_id integer
)  TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE add_additional_service(
    partner_id integer,
    service_description text,
    service_price integer,
    OUT new_service_id integer
)  FROM accountant, sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE add_tariff(
    tariff_detail_id integer, 
    partner_id integer,
    tariff_title varchar,
    OUT new_tariff_id integer
)  TO accountant, partner;
REVOKE EXECUTE ON PROCEDURE add_tariff(
    tariff_detail_id integer, 
    partner_id integer,
    tariff_title varchar,
    OUT new_tariff_id integer
)  FROM accountant, sales_manager, client, auditor;

GRANT EXECUTE ON PROCEDURE add_client_document_proc(
    main_pass_num varchar,
    main_pass_series varchar,
    main_pass_date date,
    inter_pass_num varchar,
    inter_pass_series varchar,
    inter_pass_date date,
    snils varchar,
    inn varchar,
    OUT client_documents_id integer
) TO  client, accountant;
REVOKE EXECUTE ON PROCEDURE add_client_document_proc(
    main_pass_num varchar,
    main_pass_series varchar,
    main_pass_date date,
    inter_pass_num varchar,
    inter_pass_series varchar,
    inter_pass_date date,
    snils varchar,
    inn varchar,
    OUT client_documents_id integer
) FROM sales_manager, auditor, partner;

GRANT EXECUTE ON PROCEDURE add_client_proc(
    main_pass_num varchar,
    main_pass_series varchar,
    main_pass_date date,
    inter_pass_num varchar,
    inter_pass_series varchar,
    inter_pass_date date,
    snils varchar,
    inn varchar,
    fname varchar,
    lname varchar,
    faname varchar,
    reg_city_id integer,
    reg_street_id integer,
    reg_house integer,
    reg_apartment integer,
    res_city_id integer,
    res_street_id integer,
    res_house integer,
    res_apartment integer,
    phone varchar,
    OUT new_client_id integer
) TO accountant, client;
REVOKE EXECUTE ON PROCEDURE add_client_proc(
    main_pass_num varchar,
    main_pass_series varchar,
    main_pass_date date,
    inter_pass_num varchar,
    inter_pass_series varchar,
    inter_pass_date date,
    snils varchar,
    inn varchar,
    fname varchar,
    lname varchar,
    faname varchar,
    reg_city_id integer,
    reg_street_id integer,
    reg_house integer,
    reg_apartment integer,
    res_city_id integer,
    res_street_id integer,
    res_house integer,
    res_apartment integer,
    phone varchar,
    OUT new_client_id integer
) FROM sales_manager, partner, auditor;

GRANT EXECUTE ON PROCEDURE update_client_data_proc(
    ID integer,
    NewFirstName varchar,
    NewLastName varchar,
    NewFatherName varchar,
    NewPhone varchar
) TO accountant, client;
REVOKE EXECUTE ON PROCEDURE update_client_data_proc(
    ID integer,
    NewFirstName varchar,
    NewLastName varchar,
    NewFatherName varchar,
    NewPhone varchar
) FROM sales_manager, partner, auditor;

GRANT EXECUTE ON PROCEDURE update_client_living_places_proc(
    ID integer,
    NewRegCityID integer,
    NewRegStreetID integer,
    NewRegHouse integer,
    NewRegApartment integer,
    NewResCityID integer,
    NewResStreetID integer,
    NewResHouse integer,
    NewResApartment integer
) TO accountant, client;
REVOKE EXECUTE ON PROCEDURE update_client_living_places_proc(
    ID integer,
    NewRegCityID integer,
    NewRegStreetID integer,
    NewRegHouse integer,
    NewRegApartment integer,
    NewResCityID integer,
    NewResStreetID integer,
    NewResHouse integer,
    NewResApartment integer
) FROM sales_manager, partner, auditor;

GRANT EXECUTE ON PROCEDURE update_client_documents_proc(
    ID integer,
    NewMainPassNum varchar,
    NewMainPassSeries varchar,
    NewMainPassDate date,
    NewInterPassNum varchar,
    NewInterPassSeries varchar,
    NewInterPassDate date,
    NewSnils varchar,
    NewInn varchar
) TO accountant, client;
REVOKE EXECUTE ON PROCEDURE update_client_documents_proc(
    ID integer,
    NewMainPassNum varchar,
    NewMainPassSeries varchar,
    NewMainPassDate date,
    NewInterPassNum varchar,
    NewInterPassSeries varchar,
    NewInterPassDate date,
    NewSnils varchar,
    NewInn varchar
) FROM sales_manager, partner, auditor;

GRANT EXECUTE ON PROCEDURE add_employee_document_proc(
    pass_num varchar,
    pass_series varchar,
    pass_date date,
    snils varchar,
    inn varchar,
    wrk_book_series varchar,
    wrk_book_num varchar,
    OUT employee_documents_id integer
) TO accountant;
REVOKE EXECUTE ON PROCEDURE add_employee_document_proc(
    pass_num varchar,
    pass_series varchar,
    pass_date date,
    snils varchar,
    inn varchar,
    wrk_book_series varchar,
    wrk_book_num varchar,
    OUT employee_documents_id integer
) FROM sales_manager, client, auditor, partner;

GRANT EXECUTE ON PROCEDURE add_emp_role(role varchar) TO accountant;
REVOKE EXECUTE ON PROCEDURE add_emp_role(role varchar) FROM sales_manager, client, auditor, partner;

GRANT EXECUTE ON PROCEDURE add_employee_proc(
    pass_num varchar,
    pass_series varchar,
    pass_date date,
    snils varchar,
    inn varchar,
    wrk_book_series varchar,
    wrk_book_num varchar,
    fname varchar,
    lname varchar,
    faname varchar,
    role_id integer,
    city integer,
    street integer,
    house integer,
    apartment integer,
    phone varchar,
    OUT new_employee_id integer
) TO accountant;
REVOKE EXECUTE ON PROCEDURE add_employee_proc(
    pass_num varchar,
    pass_series varchar,
    pass_date date,
    snils varchar,
    inn varchar,
    wrk_book_series varchar,
    wrk_book_num varchar,
    fname varchar,
    lname varchar,
    faname varchar,
    role_id integer,
    city integer,
    street integer,
    house integer,
    apartment integer,
    phone varchar,
    OUT new_employee_id integer
) FROM sales_manager, client, auditor, partner;
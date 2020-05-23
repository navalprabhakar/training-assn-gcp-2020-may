--liquibase formatted sql

--changeset Sahil:SpringBatch-PS-6490

CREATE TABLE [dbo].[BATCH_JOB_INSTANCE]  (
	JOB_INSTANCE_ID BIGINT  NOT NULL PRIMARY KEY ,
	VERSION BIGINT NULL,
	JOB_NAME VARCHAR(100) NOT NULL,
	JOB_KEY VARCHAR(32) NOT NULL,
	constraint JOB_INST_UN unique (JOB_NAME, JOB_KEY)
) ;

CREATE TABLE [dbo].[BATCH_JOB_EXECUTION]  (
	JOB_EXECUTION_ID BIGINT  NOT NULL PRIMARY KEY ,
	VERSION BIGINT NULL,
	JOB_INSTANCE_ID BIGINT NOT NULL,
	CREATE_TIME DATETIME NOT NULL,
	START_TIME DATETIME DEFAULT NULL ,
	END_TIME DATETIME DEFAULT NULL ,
	STATUS VARCHAR(10) NULL,
	EXIT_CODE VARCHAR(2500) NULL,
	EXIT_MESSAGE VARCHAR(2500) NULL,
	LAST_UPDATED DATETIME NULL,
	JOB_CONFIGURATION_LOCATION VARCHAR(2500) NULL,
	constraint JOB_INST_EXEC_FK foreign key (JOB_INSTANCE_ID)
	references dbo.BATCH_JOB_INSTANCE(JOB_INSTANCE_ID)
) ;

CREATE TABLE [dbo].[BATCH_JOB_EXECUTION_PARAMS]  (
	JOB_EXECUTION_ID BIGINT NOT NULL ,
	TYPE_CD VARCHAR(6) NOT NULL ,
	KEY_NAME VARCHAR(100) NOT NULL ,
	STRING_VAL VARCHAR(250) NULL,
	DATE_VAL DATETIME DEFAULT NULL ,
	LONG_VAL BIGINT NULL,
	DOUBLE_VAL DOUBLE PRECISION NULL,
	IDENTIFYING CHAR(1) NOT NULL ,
	constraint JOB_EXEC_PARAMS_FK foreign key (JOB_EXECUTION_ID)
	references dbo.BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
) ;

CREATE TABLE [dbo].[BATCH_STEP_EXECUTION]  (
	STEP_EXECUTION_ID BIGINT  NOT NULL PRIMARY KEY ,
	VERSION BIGINT NOT NULL,
	STEP_NAME VARCHAR(100) NOT NULL,
	JOB_EXECUTION_ID BIGINT NOT NULL,
	START_TIME DATETIME NOT NULL ,
	END_TIME DATETIME DEFAULT NULL ,
	STATUS VARCHAR(10) NULL,
	COMMIT_COUNT BIGINT NULL,
	READ_COUNT BIGINT NULL,
	FILTER_COUNT BIGINT NULL,
	WRITE_COUNT BIGINT NULL,
	READ_SKIP_COUNT BIGINT NULL,
	WRITE_SKIP_COUNT BIGINT NULL,
	PROCESS_SKIP_COUNT BIGINT NULL,
	ROLLBACK_COUNT BIGINT NULL,
	EXIT_CODE VARCHAR(2500) NULL,
	EXIT_MESSAGE VARCHAR(2500) NULL,
	LAST_UPDATED DATETIME NULL,
	constraint JOB_EXEC_STEP_FK foreign key (JOB_EXECUTION_ID)
	references dbo.BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
) ;

CREATE TABLE [dbo].[BATCH_STEP_EXECUTION_CONTEXT]  (
	STEP_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
	SHORT_CONTEXT VARCHAR(2500) NOT NULL,
	SERIALIZED_CONTEXT TEXT NULL,
	constraint STEP_EXEC_CTX_FK foreign key (STEP_EXECUTION_ID)
	references dbo.BATCH_STEP_EXECUTION(STEP_EXECUTION_ID)
) ;

CREATE TABLE [dbo].[BATCH_JOB_EXECUTION_CONTEXT] (
	JOB_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
	SHORT_CONTEXT VARCHAR(2500) NOT NULL,
	SERIALIZED_CONTEXT TEXT NULL,
	constraint JOB_EXEC_CTX_FK foreign key (JOB_EXECUTION_ID)
	references dbo.BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
) ;

CREATE TABLE [dbo].[BATCH_STEP_EXECUTION_SEQ] (ID BIGINT IDENTITY);
CREATE TABLE [dbo].[BATCH_JOB_EXECUTION_SEQ] (ID BIGINT IDENTITY);
CREATE TABLE [dbo].[BATCH_JOB_SEQ] (ID BIGINT IDENTITY);

--rollback  DROP TABLE dbo.BATCH_JOB_SEQ;
--rollback  DROP TABLE dbo.BATCH_JOB_EXECUTION_SEQ;
--rollback  DROP TABLE dbo.BATCH_STEP_EXECUTION_SEQ;
--rollback  DROP TABLE dbo.BATCH_JOB_EXECUTION_CONTEXT;
--rollback  DROP TABLE dbo.BATCH_STEP_EXECUTION_CONTEXT;
--rollback  DROP TABLE dbo.BATCH_STEP_EXECUTION;
--rollback  DROP TABLE dbo.BATCH_JOB_EXECUTION_PARAMS;
--rollback  DROP TABLE dbo.BATCH_JOB_EXECUTION;
--rollback  DROP TABLE dbo.BATCH_JOB_INSTANCE;

--changeset GauravGulati:alter-PS-8044
ALTER TABLE [dbo].[ModuleConfig]
Add IsVisible BIT;

--rollback  ALTER TABLE [dbo].[ModuleConfig] DROP COLUMN IsVisible;

--changeset Sahil:alter-PS-7799

ALTER TABLE VendorContacts ADD VendorGuid UNIQUEIDENTIFIER NULL;

ALTER TABLE VendorAddresses ADD VendorGuid UNIQUEIDENTIFIER NULL;

ALTER TABLE VendorAccounts ADD VendorGuid UNIQUEIDENTIFIER NULL;

ALTER TABLE VendorAggregates ADD VendorGuid UNIQUEIDENTIFIER NULL;

--rollback  ALTER TABLE VendorAggregates DROP COLUMN VendorGuid;
--rollback  ALTER TABLE VendorAccounts DROP COLUMN VendorGuid;
--rollback  ALTER TABLE VendorAddresses DROP COLUMN VendorGuid;
--rollback  ALTER TABLE VendorContacts DROP COLUMN VendorGuid;

--changeset Nitesh Jadon:create-PS-7904
CREATE TABLE [dbo].[AppVendorContacts](
	[AppVendorContactId] [UNIQUEIDENTIFIER] NOT NULL,
	[AppVendorId] [UNIQUEIDENTIFIER] NOT NULL,
	[VendorId] [INT] NULL,
	[VendorContactId] [INT] NULL,
	[SourceVendorContactId] [NVARCHAR](100) NULL,
	[FirstName] [NVARCHAR](50) NULL,
	[LastName] [NVARCHAR](50) NULL,
	[Greeting] [NVARCHAR](10) NULL,
	[Title] [NVARCHAR](50) NULL,
	[Email] [NVARCHAR](50) NULL,
	[OfficePhone] [NVARCHAR](25) NULL,
	[OfficePhonePrefix] [NVARCHAR](10) NULL,
	[OfficePhoneExtension] [NVARCHAR](10) NULL,
	[CellPhone] [NVARCHAR](25) NULL,
	[CellPhonePrefix] [NVARCHAR](10) NULL,
	[OtherPhone] [NVARCHAR](25) NULL,
	[OtherPhonePrefix] [NVARCHAR](10) NULL,
	[OtherPhoneExtension] [NVARCHAR](10) NULL,
	[Fax] [NVARCHAR](25) NULL,
	[FaxPrefix] [NVARCHAR](3) NULL,
	[InactiveDate] DATETIME2 NULL,
	[CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
	SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL ,
	SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
	PERIOD FOR SYSTEM_TIME (SysStartTime,SysEndTime),
	CONSTRAINT PK_AppVendorContact PRIMARY  KEY CLUSTERED(AppVendorContactId)
) WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.AppVendorContactHistory, DATA_CONSISTENCY_CHECK = ON));  
--rollback  DROP TABLE [dbo].[AppVendorContacts] ;

--changeset Nitesh Jadon:create-PS-7904-1
CREATE VIEW [dbo].[vwAppVendorContacts] 
AS

SELECT  
	RTRIM(CASE WHEN ISNULL(ISNULL(AVC.Greeting, VC.Greeting),'') = '' THEN '' ELSE ISNULL(AVC.Greeting, VC.Greeting) + ' ' END
				  + CASE WHEN ISNULL(ISNULL(AVC.FirstName, VC.FName), '') = '' THEN '' ELSE ISNULL(AVC.FirstName, VC.FName) + ' ' END
				  + ISNULL(ISNULL(AVC.LastName, VC.LName), '')) as FullName,
	ISNULL(AVC.AppVendorContactId, VC.VenContactGuid) as AppVendorContactId,
	ISNULL(AVC.AppVendorId, VC.VendorGuid) as AppVendorId,
	ISNULL(AVC.VendorId, VC.VenID) as VendorId,
	ISNULL(AVC.VendorContactId, VC.VenContactID) as VendorContactId,
	ISNULL(AVC.SourceVendorContactId, VC.SourceVenContactID) as SourceVendorContactId,
	ISNULL(AVC.FirstName, VC.FName) as FirstName,
	ISNULL(AVC.LastName, VC.LName) as LastName,
	ISNULL(AVC.Greeting, VC.Greeting) as Greeting,
	ISNULL(AVC.Title, VC.Title) as Title,
	ISNULL(AVC.Email, VC.Email) as Email,
	ISNULL(AVC.OfficePhone, VC.Office) as OfficePhone,
	ISNULL(AVC.OfficePhonePrefix, VC.OfficePrefix) as OfficePhonePrefix,
	AVC.OfficePhoneExtension as OfficePhoneExtension,
	ISNULL(AVC.CellPhone, VC.Cell) as CellPhone,
	ISNULL(AVC.CellPhonePrefix, VC.CellPrefix) as CellPhonePrefix,
	ISNULL(AVC.OtherPhone, VC.Other) as OtherPhone,
	ISNULL(AVC.OtherPhonePrefix, VC.OtherPrefix) as OtherPhonePrefix,
	AVC.OtherPhoneExtension as OtherPhoneExtension,
	ISNULL(AVC.Fax, VC.Fax) as Fax,
	ISNULL(AVC.FaxPrefix, VC.FaxPrefix) as FaxPrefix,
	AVC.InactiveDate as InactiveDate,
	ISNULL(AVC.CreatedBy, VC.CreatedBy) as CreatedBy,
	ISNULL(AVC.CreatedDate, VC.CreatedDt) as CreatedDate,
	ISNULL(AVC.LastModifiedDate, VC.ModifiedDt) as LastModifiedDate,
	ISNULL(AVC.LastModifiedBy, VC.ModifiedBy) as LastModifiedBy

FROM VendorContacts VC
FULL OUTER JOIN AppVendorContacts AVC
ON AVC.VendorContactId = VC.VenContactID
--rollback  DROP VIEW [dbo].[vwAppVendorContacts] ;

--changeset Nitesh Jadon:create-PS-7904-2
CREATE TRIGGER [dbo].[TRG_vwAppVendorContacts_InsteadOfInsert]  
ON vwAppVendorContacts  
INSTEAD OF INSERT  
AS 
BEGIN  	
	
	INSERT INTO AppVendorContacts
	(
		AppVendorContactId,
		AppVendorId,
		VendorId,
		VendorContactId,
		SourceVendorContactId,
		FirstName,
		LastName,
		Greeting,
		Title,
		Email,
		OfficePhone,
		OfficePhonePrefix,
		OfficePhoneExtension,
		CellPhone,
		CellPhonePrefix,
		OtherPhone,
		OtherPhonePrefix,
		OtherPhoneExtension,
		Fax,
		FaxPrefix,
		InactiveDate,
		CreatedBy,
		CreatedDate,
		LastModifiedBy,
		LastModifiedDate
	)
	SELECT 
		AppVendorContactId,
		AppVendorId,
		VendorId,
		VendorContactId,
		SourceVendorContactId,
		FirstName,
		LastName,
		Greeting,
		Title,
		Email,
		OfficePhone,
		OfficePhonePrefix,
		OfficePhoneExtension,
		CellPhone,
		CellPhonePrefix,
		OtherPhone,
		OtherPhonePrefix,
		OtherPhoneExtension,
		Fax,
		FaxPrefix,
		InactiveDate,
		CreatedBy,
		CreatedDate,
		LastModifiedBy,
		LastModifiedDate
	FROM Inserted	
END
--rollback  DROP TRIGGER [dbo].[TRG_vwAppVendorContacts_InsteadOfInsert] ;

--changeset Nitesh Jadon:create-PS-7904-3
CREATE TRIGGER [dbo].[TRG_vwAppVendorContacts_InsteadOfUpdate]
ON vwAppVendorContacts
INSTEAD OF UPDATE 
AS 
BEGIN
	
	--Record Exists in App Vendor Contacts

	
	UPDATE	AVC
	SET 
		AVC.FirstName	=	I.FirstName,
		AVC.LastName	=	I.LastName,
		AVC.Greeting	=	I.Greeting,
		AVC.Title	=	I.Title,
		AVC.Email	=	I.Email,
		AVC.OfficePhone	=	I.OfficePhone,
		AVC.OfficePhonePrefix	=	I.OfficePhonePrefix,
		AVC.OfficePhoneExtension	=	I.OfficePhoneExtension,
		AVC.CellPhone	=	I.CellPhone,
		AVC.CellPhonePrefix	=	I.CellPhonePrefix,
		AVC.OtherPhone	=	I.OtherPhone,
		AVC.OtherPhonePrefix	=	I.OtherPhonePrefix,
		AVC.OtherPhoneExtension	=	I.OtherPhoneExtension,
		AVC.Fax	=	I.Fax,		
		AVC.FaxPrefix	=	I.FaxPrefix,
		AVC.InactiveDate	=	I.InactiveDate,
		AVC.CreatedBy	=	I.CreatedBy,
		AVC.CreatedDate	=	I.CreatedDate,
		AVC.LastModifiedBy	=	I.LastModifiedBy,
		AVC.LastModifiedDate	=	I.LastModifiedDate	
	FROM INSERTED I
	JOIN AppVendorContacts AVC
	ON I.AppVendorContactId = AVC.AppVendorContactId
	
	
	--Record doesn't exist in App Vendor
	INSERT INTO AppVendorContacts
	(
		AppVendorContactId,
		AppVendorId,
		VendorId,
		VendorContactId,
		SourceVendorContactId,
		FirstName,
		LastName,
		Greeting,
		Title,
		Email,
		OfficePhone,
		OfficePhonePrefix,
		OfficePhoneExtension,
		CellPhone,
		CellPhonePrefix,
		OtherPhone,
		OtherPhonePrefix,
		OtherPhoneExtension,
		Fax,
		FaxPrefix,
		InactiveDate,
		CreatedBy,
		CreatedDate,
		LastModifiedBy,
		LastModifiedDate
	)
	SELECT
		I.AppVendorContactId,
		I.AppVendorId,
		I.VendorId,
		I.VendorContactId,
		I.SourceVendorContactId,
		I.FirstName,
		I.LastName,
		I.Greeting,
		I.Title,
		I.Email,
		I.OfficePhone,
		I.OfficePhonePrefix,
		I.OfficePhoneExtension,
		I.CellPhone,
		I.CellPhonePrefix,
		I.OtherPhone,
		I.OtherPhonePrefix,
		I.OtherPhoneExtension,
		I.Fax,
		I.FaxPrefix,
		I.InactiveDate,
		I.CreatedBy,
		I.CreatedDate,
		I.LastModifiedBy,
		I.LastModifiedDate
	FROM INSERTED I
	LEFT JOIN AppVendorContacts AVC
	ON I.AppVendorContactId = AVC.AppVendorContactId
	WHERE AVC.AppVendorContactId IS NULL

END
--rollback  DROP TRIGGER [dbo].[TRG_vwAppVendorContacts_InsteadOfUpdate] ;

--changeset ShreyaMalhotra:create-PS-7893
CREATE TABLE [dbo].[VendorCountry] (
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](100) NOT NULL,
	[TwoLetterIsoCode] [varchar](2),
	[ThreeLetterIsoCode] [varchar](3),
	[CountryCode] [varchar](50) NOT NULL,
	[DisplayOrder] [int],
	[InactiveDate] [datetime2](7) NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
	CONSTRAINT PK_VendorCountry PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	
	CONSTRAINT UC_VendorCountry UNIQUE (CountryName, CountryCode)
	
) ON [PRIMARY]

--rollback  DROP TABLE [dbo].[VendorCountry] ;

--changeset NitinYadav:PS-8326

ALTER TABLE [dbo].[TableConfig] ALTER COLUMN [TableConfigDesc] VARCHAR(200)

--rollback  ALTER TABLE [dbo].[TableConfig] ALTER COLUMN [TableConfigDesc] VARCHAR(50) ;  

--changeset Sahil:alter-PS-6826

ALTER TABLE VendorAggregates ADD LastPayNum NVARCHAR(50) NULL;

ALTER TABLE VendorAggregates ADD Currency VARCHAR(3) NULL;

--rollback  ALTER TABLE VendorAggregates DROP COLUMN Currency;
--rollback  ALTER TABLE VendorAccounts DROP COLUMN LastPayNum;

--changeset Sahil:CreateView-Contact-PS-7799
CREATE VIEW [dbo].[vwVendorContactLatest]
AS  
	SELECT 
	AppVendorId,
	AppVendorContactId,
	CASE 
		WHEN FirstName is NULL AND LastName is NULL THEN NULL
		ELSE CONCAT_WS(' ',FirstName,LastName) 
	END AS ContactName,
	Title As CompanyTitle,
	Email As ContactEmail,
	CASE 
		WHEN OfficePhonePrefix is NULL AND OfficePhone is NULL AND OfficePhoneExtension is NULL THEN NULL
		ELSE CONCAT_WS(' ',OfficePhonePrefix,OfficePhone,OfficePhoneExtension)
	END AS OfficePhone,
	CASE 
		WHEN CellPhonePrefix is NULL AND CellPhone is NULL THEN NULL
		ELSE CONCAT_WS(' ',CellPhonePrefix,CellPhone)
	END AS CellPhone,
	CASE 
		WHEN OtherPhonePrefix is NULL AND OtherPhone is NULL AND OtherPhoneExtension is NULL THEN NULL
		ELSE CONCAT_WS(' ',OtherPhonePrefix,OtherPhone,OtherPhoneExtension)
	END AS OtherPhone,
	CASE 
		WHEN FaxPrefix is NULL AND Fax is NULL THEN NULL
		ELSE CONCAT_WS(' ',FaxPrefix,Fax)
	END AS Fax
	FROM	
	(
		SELECT 
		ROW_NUMBER() OVER (
		PARTITION BY AppVendorId
		ORDER BY IIF(LastModifiedDate is null,CreatedDate,LastModifiedDate) DESC,CreatedDate DESC, VendorContactId DESC
		) row_num,
		AppVendorId,
		AppVendorContactId,
		FirstName,
		LastName,
		Title,
		Email,
		OfficePhone,
		OfficePhonePrefix,
		OfficePhoneExtension,
		CellPhone,
		CellPhonePrefix,
		OtherPhone,
		OtherPhonePrefix,
		OtherPhoneExtension,
		Fax,
		FaxPrefix
	FROM dbo.vwAppVendorContacts
	) VC
	WHERE row_num = 1

--rollback  DROP VIEW [dbo].[vwVendorContactLatest];

--changeset Sahil:CreateView-Aggregate-PS-7799
CREATE VIEW [dbo].[vwVendorAggregateLatest]
AS  
	SELECT
	VenAggID,
	VendorGuid,
	TotVol AS TotalVolume,
	TotCt AS NumberTransactions,
	TotCrCt AS NumberCredits
	FROM	
	(
		SELECT 
		ROW_NUMBER() OVER (
		PARTITION BY VendorGuid
		ORDER BY IIF(ModifiedDt is null,CreatedDt,ModifiedDt) DESC,CreatedDt DESC, VenAggID DESC
		) row_num,
		VenAggID,
		VendorGuid,
		TotVol,
		TotCt,
		TotCrCt
	FROM dbo.VendorAggregates
	) VA
	WHERE row_num = 1

--rollback  DROP VIEW [dbo].[vwVendorAggregateLatest];

--changeset Sahil:ALterView-PS-7799
ALTER FUNCTION [dbo].[UF_VenderSelection] 
(
    @ProjectId INT
)
RETURNS TABLE
AS
RETURN
	SELECT 
	[Id] = CONVERT(VARCHAR(100),vwAV.[AppVendorId]) + '-' + CONVERT(VARCHAR(10), ISNULL(@ProjectId,0)),
	VS.[VendorSelectionId],
	VS.[ProjectId],
	ISNULL(VS.[VendorSelectionStatusId], 3) AS VendorSelectionStatusId,
	vwAV.[AppVendorId],
	vwAV.[VendorId],
	[VendorName],
	[VendorName2],
	[VendorName3],
	[VendorName4],
	[VendorNumber],
	[VendorNumber2],
	[VendorDescription],
	[VendorGroup],
	[BusinessUnit],
	[VendorLanguage],
	[VendorType],
	[CompanyCode],
	[TaxId1],
	[TaxId2],
	[InactiveDate],
	[AuditVendorType],
	[Custom],
	vwAV.[CreatedDate],
	vwAV.[CreatedBy],
	vwAV.[LastModifiedDate],
	vwAV.[LastModifiedBy],
	vwVC.ContactName,
	vwVC.CompanyTitle,
	vwVC.ContactEmail,
	vwVC.OfficePhone,
	vwVC.CellPhone,
	vwVC.OtherPhone,
	vwVC.Fax,
	vwVA.TotalVolume,
	vwVA.NumberTransactions,
	vwVA.NumberCredits
	FROM vwAppVendor vwAV
	LEFT JOIN VendorSelection VS
	ON vwAV.AppVendorId = VS.AppVendorId 
	AND VS.ProjectId= @ProjectId
	LEFT JOIN vwVendorContactLatest vwVC ON vwVC.AppVendorId = vwAV.AppVendorId					
	LEFT JOIN vwVendorAggregateLatest vwVA ON vwVA.VendorGuid = vwAV.AppVendorId  

--rollback SELECT 1 WHERE 1=0; 

--changeset NiteshJadon:PS-10704-FaxPrefix

ALTER TABLE [dbo].[AppVendorContacts] ALTER COLUMN [FaxPrefix] NVARCHAR(10)

--rollback  ALTER TABLE [dbo].[AppVendorContacts] ALTER COLUMN [FaxPrefix] NVARCHAR(3) ;  


--changeset NiteshJadon:PS-10704-FaxPrefix-1

exec sp_refreshview 'dbo.vwAppVendorContacts'

--rollback  SELECT 1 WHERE 1=0 ;  

--changeset Sahil:alter-PS-9342

ALTER TABLE [dbo].[ObjectField] ADD IsForeignKey BIT NOT NULL DEFAULT 0;

--rollback  ALTER TABLE [dbo].[ObjectField] DROP COLUMN IsForeignKey;

--changeset NiteshJadon:create-PS-6753	

CREATE TABLE [dbo].[DocumentType](
	[Id] [BIGINT] IDENTITY(1,1) NOT NULL,
	[ModuleId] [BIGINT] NOT NULL,
	[DocumentType] [VARCHAR](50) NULL,
	[InactiveDate] DATETIME2 NULL,
CONSTRAINT PK_DataType PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_DataType_ModuleConfig FOREIGN KEY (ModuleId)
    REFERENCES ModuleConfig(Id)
) ON [PRIMARY]

;  
--rollback  DROP TABLE [dbo].[DocumentType] ;

--changeset AmanKapoor:PS10149

CREATE TABLE [dbo].[currency](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[currencycode] [varchar](3) NOT NULL,
	[currencyname] [varchar](60),
	[inactivedate] [datetime2](7) NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
	CONSTRAINT PK_currency PRIMARY  KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];

alter table currency add  constraint  uk_currency_currencycode UNIQUE(currencycode)

--rollback  DROP TABLE [dbo].[currency] ;

--changeset VarunMehta:alter-PS-10049-1

ALTER TABLE [dbo].[ObjectField] 
ADD [Description] VARCHAR(256);

ALTER TABLE [dbo].[ObjectField] 
ADD [DisplayName] VARCHAR(50);

--rollback  ALTER TABLE [dbo].[ObjectField] DROP COLUMN DisplayName;
--rollback  ALTER TABLE [dbo].[ObjectField] DROP COLUMN Description;


--changeset Om Parkash:create-PS-8194
create table [dbo].CalculatedColumn (
	Id bigint identity not null,
	CreatedBy varchar(255),
	CreatedDate datetime2,
	LastModifiedBy varchar(255),
	LastModifiedDate datetime2,
	EntityIdentifier varchar(255),
	Formula varchar(255) not null,
	FormulaType int not null,
	Label varchar(255),
	Name varchar(255) not null,
	Type varchar(255) not null,
	ValueType varchar(255) not null,
	ColumnOrder int,
	Hide bit DEFAULT 0,
	primary key (id),
	constraint uc_type_and_entity_id unique (type, entityidentifier, name)
)

alter table [dbo].TableConfig add JsonColumnName varchar(255);
alter table [dbo].TableConfig add ApplicationTableName varchar(255);
--rollback  DROP TABLE [dbo].[CalculatedColumn] ;
--rollback  alter table [dbo].TableConfig drop column JsonColumnName;
--rollback  alter table [dbo].TableConfig drop column ApplicationTableName;

--changeset SiddharthSharma:PS-9375

CREATE TABLE [dbo].[ClaimSequenceGenerator](
	Id bigint IDENTITY(1,1) NOT NULL,
	AuditId bigint NOT NULL,
	NextSequence bigint NOT NULL,
	SequenceLength tinyint NOT NULL,
	Prefix varchar(25),
	Suffix varchar(25),
	CONSTRAINT NextSequenceValidationSeqGen CHECK(NextSequence >= 0)
);

CREATE TABLE [dbo].[ClaimSequence](
	Id bigint IDENTITY(1,1) NOT NULL,
	AuditId bigint NOT NULL,
	SequenceLength tinyint NOT NULL,
	Prefix varchar(25),
	Suffix varchar(25),
	StartSequence bigint NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
);

--rollback  DROP TABLE [dbo].[ClaimSequence] ;
--rollback  DROP TABLE [dbo].[ClaimSequenceGenerator] ;

--changeset SiddharthSharma:PS9375-1

CREATE PROCEDURE [dbo].[ClaimSequenceGeneratorProcedure]
	-- Add the parameters for the stored procedure here
	(
		@AuditId bigint, 
		@StartSequence bigint,
		@SequenceLength tinyint,
		@Prefix varchar(25),
		@Suffix varchar(25),
		@NextSequence bigint OUT
	)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	BEGIN TRAN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON
		DECLARE @Id bigint
		-- Insert statements for procedure here
		SELECT
			@Id = Id,
			@NextSequence = NextSequence
			FROM 
				dbo.ClaimSequenceGenerator 
			WHERE
				(AuditId = @AuditId) and 
				(SequenceLength = @SequenceLength) and
				(Prefix = @Prefix) and
				(Suffix = @Suffix)
		IF @Id is null
			BEGIN
				SET @NextSequence = @StartSequence
				SELECT @Id = coalesce((SELECT max(ID) + 1 FROM dbo.ClaimSequenceGenerator), 1)
				INSERT INTO dbo.ClaimSequenceGenerator(Id, AuditId, Prefix, Suffix, SequenceLength, NextSequence)
				VALUES(@Id, @AuditId, @Prefix, @Suffix, @SequenceLength, @StartSequence + 1)
			END
		ELSE
			BEGIN
				UPDATE dbo.ClaimSequenceGenerator
				SET NextSequence = @NextSequence + 1
				WHERE Id = @Id
			END
	COMMIT TRAN
END
GO

--rollback DROP PROCEDURE [dbo].[ClaimSequenceGenerator];

--changeset AmanKapoor:CurrencyName-ColumnLengthChanged

alter table currency alter column   currencyname varchar(100);

--rollback alter table currency alter column   currencyname varchar(50);

--changeset NiteshJadon:create-PS-8892	

CREATE TABLE [dbo].[VendorCredit](
	[Id] [BIGINT] IDENTITY(1,1) NOT NULL,
	[AppVendorId] [uniqueidentifier] NOT NULL,
	[ProjectId] [BIGINT] NOT NULL,
	[AccountNumber] [VARCHAR](50) NULL,
	[CreditReferenceNumber] [VARCHAR](50) NOT NULL,
	[CreditDate] DATETIME2 NOT NULL,
	[CreditAmount] [decimal](14, 2) NOT NULL,
	[CreditCurrency] [BIGINT] NOT NULL,
	[PoNumber] [VARCHAR](50) NULL,
	[CreditStatus] [uniqueidentifier] NOT NULL,
	[ProblemSubType] [uniqueidentifier] NULL,
	[CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
	
CONSTRAINT PK_VendorCredit PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_VendorCredit_Project FOREIGN KEY (ProjectId)
    REFERENCES Project(ProjectId),
	CONSTRAINT FK_VendorCredit_Currency FOREIGN KEY (CreditCurrency)
    REFERENCES currency(id),
	
) ON [PRIMARY]

;  
--rollback  DROP TABLE [dbo].[VendorCredit] ;


--changeset SiddharthSharma:Feature-PS-9375-alter

alter table dbo.ClaimSequenceGenerator drop column SequenceLength
alter table dbo.ClaimSequenceGenerator drop column Prefix
alter table dbo.ClaimSequenceGenerator drop column Suffix
alter table dbo.ClaimSequenceGenerator add StartSequence bigint not null default 0

--rollback alter table dbo.claimsequencegenerator add sequencelength bigint not null
--rollback alter table dbo.claimsequencegenerator add prefix varchar(25)
--rollback alter table dbo.claimsequencegenerator add suffix varchar(25)
--rollback alter table dbo.claimsequencegenerator drop column StartSequence

--changeset SiddharthSharma:Feature-PS-9375-1-alter

ALTER PROCEDURE dbo.ClaimSequenceGeneratorProcedure
	-- Add the parameters for the stored procedure here
	(
		@AuditId bigint, 
		@StartSequence bigint,
		@NextSequence bigint OUT
	)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	BEGIN TRAN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON
		DECLARE @Id bigint
		DECLARE @CurrentStartSequence bigint
		-- Insert statements for procedure here
		SELECT
			@Id = Id,
			@NextSequence = NextSequence,
			@CurrentStartSequence = StartSequence
			FROM 
				dbo.ClaimSequenceGenerator 
			WHERE
				(AuditId = @AuditId)
		IF @Id is null
			BEGIN
				SET @NextSequence = @StartSequence
				INSERT INTO dbo.ClaimSequenceGenerator(AuditId, StartSequence, NextSequence)
				VALUES(@AuditId, @StartSequence, @StartSequence + 1)
			END
		ELSE
			BEGIN
				IF @CurrentStartSequence <> @StartSequence
					BEGIN
						SET @NextSequence = @StartSequence
						UPDATE dbo.ClaimSequenceGenerator
						SET NextSequence = @NextSequence + 1,
						StartSequence = @StartSequence
						WHERE Id = @Id
					END
				ELSE
					BEGIN
						UPDATE dbo.ClaimSequenceGenerator
						SET NextSequence = @NextSequence + 1
						WHERE Id = @Id
					END
			END
	COMMIT TRAN
END
GO

--rollback DROP PROCEDURE [dbo].[ClaimSequenceGenerator];


--changeset Om Parkash:create-PS-8227

EXEC sp_rename '[dbo].[CalculatedColumn].Hide', 'Hidden', 'COLUMN'
--rollback  EXEC sp_rename '[dbo].[CalculatedColumn].Hidden', 'Hide', 'COLUMN' 

--changeset SiddharthSharma:Feature-PS-9375-2-alter

ALTER PROCEDURE dbo.ClaimSequenceGeneratorProcedure
	-- Add the parameters for the stored procedure here
	(
		@AuditId bigint, 
		@StartSequence bigint
	)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	BEGIN TRAN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON
		DECLARE @Id bigint
		DECLARE @CurrentStartSequence bigint
		DECLARE @NextSequence bigint
		-- Insert statements for procedure here
		SELECT
			@Id = Id,
			@NextSequence = NextSequence,
			@CurrentStartSequence = StartSequence
			FROM 
				dbo.ClaimSequenceGenerator 
			WHERE
				(AuditId = @AuditId)
		IF @Id is null
			BEGIN
				SET @NextSequence = @StartSequence
				INSERT INTO dbo.ClaimSequenceGenerator(AuditId, StartSequence, NextSequence)
				VALUES(@AuditId, @StartSequence, @StartSequence + 1)
			END
		ELSE
			BEGIN
				IF @CurrentStartSequence <> @StartSequence
					BEGIN
						SET @NextSequence = @StartSequence
						UPDATE dbo.ClaimSequenceGenerator
						SET NextSequence = @NextSequence + 1,
						StartSequence = @StartSequence
						WHERE Id = @Id
					END
				ELSE
					BEGIN
						UPDATE dbo.ClaimSequenceGenerator
						SET NextSequence = @NextSequence + 1
						WHERE Id = @Id
					END
			END
	COMMIT TRAN
	SELECT @NextSequence
END
GO

--rollback DROP PROCEDURE [dbo].[ClaimSequenceGenerator];

--changeset SiddharthSharma:Feature-PS-9375-4-alter

alter table dbo.audit add ServiceLineId bigint

--rollback alter table dbo.audit drop column ServiceLineId

--changeset ShreyaMalhotra:drop-CS-1833

DROP TABLE [dbo].[ExceptionClaimMappingDetail];
DROP TABLE [dbo].[ExceptionClaimMapping];

--rollback SELECT 1 WHERE 1=0;


--changeset ShreyaMalhotra:create-CS-1833-1

CREATE TABLE [dbo].[ExceptionClaimMapping](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectId] [bigint] NOT NULL,
	[DataSetId] [bigint] NOT NULL,
	[ClaimFieldId] [uniqueidentifier] NOT NULL,
	[SourceId] [bigint] ,
	[ClaimFunction][varchar](255) NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
CONSTRAINT PK_ExceptionClaimMapping PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],

	CONSTRAINT FK_ExceptionClaimMapping_Project FOREIGN KEY (ProjectId)
    REFERENCES Project(ProjectId),
	
	CONSTRAINT FK_ExceptionClaimMapping_TableConfig FOREIGN KEY (DataSetId)
    REFERENCES TableConfig(TableConfigId),

	CONSTRAINT FK_ExceptionClaimMapping_FieldConfigMapping FOREIGN KEY (SourceId)
    REFERENCES FieldConfigMapping(FieldConfigMappingId),
	
	CONSTRAINT UC_ExceptionClaimMapping_ProjectId_sourceId UNIQUE (ProjectId, sourceId)

) ON [PRIMARY]

--rollback  DROP TABLE [dbo].[ExceptionClaimMapping];

--changeset ShreyaMalhotra:create-CS-1833-2

ALTER TABLE [dbo].[ExceptionClaimMapping]
Alter Column  [DataSetId] bigint NULL

--rollback  ALTER TABLE [dbo].[ExceptionClaimMapping] Alter Column [DataSetId] bigint NOT NULL;

--changeset GauravGulati:create-PS-1179-1
CREATE FUNCTION [dbo].[PROPER](@Text AS VARCHAR(8000))
RETURNS VARCHAR(8000)
AS
BEGIN
  DECLARE @Reset bit
  DECLARE @Ret varchar(8000)
  DECLARE @i int
  DECLARE @c char(1)

  IF @Text is null
    RETURN null

  SELECT @Reset = 1, @i = 1, @Ret = ''

  WHILE (@i <= LEN(@Text))
    SELECT @c = SUBSTRING(@Text, @i, 1),
      @Ret = @Ret + CASE WHEN @Reset = 1 THEN UPPER(@c) ELSE LOWER(@c) END,
      @Reset = CASE WHEN @c like '[a-zA-Z]' THEN 0 ELSE 1 END,
      @i = @i + 1
  RETURN @Ret
END
--rollback  DROP FUNCTION [dbo].[PROPER] ;


--changeset NiteshJadon:PS-11120-EmailBug

ALTER TABLE [dbo].[AppVendorContacts] ALTER COLUMN [Email] NVARCHAR(100)
exec sp_refreshview 'dbo.vwAppVendorContacts'

--rollback  SELECT 1 WHERE 1=0 ; 
--rollback  ALTER TABLE [dbo].[AppVendorContacts] ALTER COLUMN [Email] [NVARCHAR](50) ;  

--changeset NiteshJadon:PS-11478-AccountNoBug

ALTER TABLE [dbo].[VendorCredit] ALTER COLUMN [AccountNumber] [VARCHAR](100)

--rollback  ALTER TABLE [dbo].[VendorCredit] ALTER COLUMN [AccountNumber] [NVARCHAR](50) ;  

--changeset GauravGulati:update-PS-11210
ALTER TABLE [dbo].[CalculatedColumn]
ALTER COLUMN [Label] varchar(255) NOT NULL

ALTER TABLE [dbo].[CalculatedColumn]
ALTER COLUMN [Formula] varchar(max) NOT NULL

ALTER TABLE [dbo].[CalculatedColumn]   
ADD CONSTRAINT uc_type_and_entity_id_label UNIQUE (type, entityidentifier, label)

--rollback ALTER TABLE [dbo].[CalculatedColumn] ALTER COLUMN [Label] varchar(255) NULL
--rollback ALTER TABLE [dbo].[CalculatedColumn] ALTER COLUMN [Formula] varchar(255) NOT NULL
--rollback ALTER TABLE [dbo].[CalculatedColumn] DROP CONSTRAINT uc_type_and_entity_id_label 

--changeset ShreyaMalhotra:CS-2314-Alter
ALTER TABLE [dbo].[ExceptionClaimMapping]
DROP CONSTRAINT UC_ExceptionClaimMapping_ProjectId_sourceId

--rollback ALTER TABLE [dbo].[ExceptionClaimMapping] ADD CONSTRAINT UC_ExceptionClaimMapping_ProjectId_sourceId UNIQUE (ProjectId, sourceId)


--changeset NiteshJadon:create-PS-8010

CREATE TABLE [dbo].[ProjectVendorStatus] (
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[VendorStatus] [varchar](100),
	[Deleted] [bit] DEFAULT 0,	
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL
	CONSTRAINT PK_ProjectVendorStatus PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
) ON [PRIMARY]
;

CREATE TABLE [dbo].[ProjectVendor](
	[Id] [BIGINT] IDENTITY(1,1) NOT NULL,
	[ProjectId] [BIGINT] NOT NULL,
	[AppVendorId] [uniqueidentifier] NULL,
	[ProjectVendorStatusId] [BIGINT] NOT NULL,
	[Deleted] [bit] DEFAULT 0,
	[CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
	
CONSTRAINT PK_ProjectVendor PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_ProjectVendor_Project FOREIGN KEY (ProjectId)
    REFERENCES Project(ProjectId),
	CONSTRAINT FK_ProjectVendor_ProjectVendorStatus FOREIGN KEY (ProjectVendorStatusId)
    REFERENCES ProjectVendorStatus(id),
	CONSTRAINT UC_ProjectVendor_ProjectId_AppVendorId UNIQUE (ProjectId, AppVendorId),
) ON [PRIMARY]
;  

--rollback  DROP TABLE [dbo].[ProjectVendor] ;
--rollback  DROP TABLE [dbo].[ProjectVendorStatus] ;


--changeset NitinYadav:Alter-PS-11410

Alter table [dbo].Audit add JsonColumnName varchar(8000);
Alter table [dbo].Project add JsonColumnName varchar(8000);
Alter table [dbo].Vendor add JsonColumnName varchar(8000);
Alter table [dbo].VendorCredit add JsonColumnName varchar(8000);

--rollback  alter table [dbo].VendorCredit DROP Column  JsonColumnName;
--rollback  alter table [dbo].Vendor DROP Column  JsonColumnName;
--rollback  alter table [dbo].Project DROP Column  JsonColumnName;
--rollback  alter table [dbo].Audit DROP Column  JsonColumnName;

--changeset NiteshJindal:Alter-PS-10866
ALTER TABLE [dbo].[ObjectField] ADD showinui BIT NOT NULL DEFAULT 1;
ALTER TABLE [dbo].[ObjectField] ADD showingrid BIT NOT NULL DEFAULT 1;
ALTER TABLE [dbo].[ObjectField] ADD fieldorder [numeric](5, 3) NULL;
--rollback  alter table [dbo].[ObjectField] DROP Column  showinui;
--rollback  alter table [dbo].[ObjectField] DROP Column  showingrid;
--rollback  alter table [dbo].[ObjectField] DROP Column  fieldorder;

--changeset NitinYadav:Alter-PS-11410-1
ALTER table [dbo].Audit ALTER Column JsonColumnName varchar(MAX);
ALTER table [dbo].Project ALTER Column JsonColumnName varchar(MAX);
ALTER table [dbo].Vendor ALTER Column JsonColumnName varchar(MAX);
ALTER table [dbo].VendorCredit ALTER Column JsonColumnName varchar(MAX);
--rollback  alter table [dbo].VendorCredit ALTER Column JsonColumnName varchar(8000);
--rollback  alter table [dbo].Vendor ALTER Column JsonColumnName varchar(8000);
--rollback  alter table [dbo].Project ALTER Column JsonColumnName varchar(8000);
--rollback  alter table [dbo].Audit ALTER Column JsonColumnName varchar(8000);
						
--changeset NiteshJindal:Alter-PS-10866-1
ALTER TABLE [dbo].[ObjectFieldServiceLine] ADD showinui BIT NOT NULL DEFAULT 1;
ALTER TABLE [dbo].[ObjectFieldServiceLine] ADD showingrid BIT NOT NULL DEFAULT 1;
--rollback  alter table [dbo].[ObjectFieldServiceLine] DROP Column  showinui;
--rollback  alter table [dbo].[ObjectFieldServiceLine] DROP Column  showingrid;

--changeset NitinYadav:Alter-PS-11410-2
Alter table [dbo].Vendor DROP Column JsonColumnName;
Alter table [dbo].AppVendor add JsonColumnName varchar(MAX);

--rollback  alter table [dbo].AppVendor DROP Column  JsonColumnName;
--rollback  alter table [dbo].Vendor ADD JsonColumnName varchar(MAX);

--changeset Sahil:PS-9212

CREATE TABLE [dbo].[ProjectVendorGroup](
	[ProjectId] [BIGINT] NOT NULL,
	[GroupVendorId] UNIQUEIDENTIFIER NOT NULL
	CONSTRAINT PK_ProjectVendorGroup PRIMARY KEY CLUSTERED 
(
	[GroupVendorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [FK_ProjectVendorGroup_Project] FOREIGN KEY([ProjectId])
 REFERENCES [dbo].Project ([ProjectId])
) ON [PRIMARY];

CREATE TABLE [dbo].[ProjectVendorGroupChild](
	[Id] [bigint] IDENTITY(1,1) NOT NULL, 
	[GroupVendorId] UNIQUEIDENTIFIER NOT NULL,
	[ChildVendorId] UNIQUEIDENTIFIER NOT NULL,
	[CreatedBy] [VARCHAR](255) NULL,
	[CreatedDate] [DATETIME2](7) NULL,
	[LastModifiedBy] [VARCHAR](255) NULL,
	[LastModifiedDate] [DATETIME2](7) NULL,
	CONSTRAINT PK_ProjectVendorGroupChild PRIMARY  KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];

ALTER TABLE [dbo].[AppVendor] ADD IsGroupVendor BIT NOT NULL DEFAULT 0;

--rollback  ALTER TABLE [dbo].[AppVendor] DROP COLUMN IsGroupVendor;
--rollback  DROP TABLE [dbo].[ProjectVendorGroupChild];
--rollback  DROP TABLE [dbo].[ProjectVendorGroup];

--changeset Sahil:PS-9212-1
ALTER VIEW [dbo].[vwAppVendor] 
AS

SELECT 
	ISNULL(AV.AppVendorId, V.VendorGuid) as AppVendorId,
	ISNULL(AV.VendorId, V.VenID) as VendorId,
	ISNULL(AV.VendorName, V.VenName) as VendorName,
	ISNULL(AV.VendorName2, V.VenName2) as VendorName2,
	ISNULL(AV.VendorName3, V.VenName3) as VendorName3,
	ISNULL(AV.VendorName4, V.VenName4) as VendorName4,
	ISNULL(AV.VendorNumber, V.VenNum) as VendorNumber,
	ISNULL(AV.VendorNumber2, V.VenNum2) as VendorNumber2,
	ISNULL(AV.VendorDescription, V.VenDesc) as VendorDescription,
	ISNULL(AV.VendorGroup, V.VenGroup) as VendorGroup,
	ISNULL(AV.BusinessUnit, V.BusUnit) as BusinessUnit,
	ISNULL(AV.VendorLanguage, V.VenLang) as VendorLanguage,
	ISNULL(AV.VendorType, V.VenType) as VendorType,
	ISNULL(AV.CompanyCode, V.CompCd) as CompanyCode,
	ISNULL(AV.TaxId1, V.TaxID1) as TaxId1,
	ISNULL(AV.TaxId2, V.TaxID2) as TaxId2,
	ISNULL(AV.InactiveDate, V.InactiveDt) as InactiveDate,
	AV.AuditVendorType as AuditVendorType,
	AV.Custom as Custom,
	ISNULL(AV.IsGroupVendor,0) as IsGroupVendor,
	ISNULL(AV.CreatedDate, V.CreatedDt) as CreatedDate,
	ISNULL(AV.CreatedBy, V.CreatedBy) as CreatedBy,
	ISNULL(AV.LastModifiedDate, V.ModifiedDt) as LastModifiedDate,
	ISNULL(AV.LastModifiedBy, V.ModifiedBy) as LastModifiedBy

FROM Vendor V
FULL OUTER JOIN AppVendor AV
ON AV.VendorId = V.VenID

--rollback  SELECT 1 WHERE 1=0 ; 

--changeset Sahil:PS-9212-2
ALTER TRIGGER [dbo].[TRG_vwAppVendor_InsteadOfInsert]  
ON vwAppVendor  
INSTEAD OF INSERT  
AS 
BEGIN  	
	
	INSERT INTO AppVendor
	(
		AppVendorId,
		VendorId,
		VendorName,
		VendorName2,
		VendorName3,
		VendorName4,
		VendorNumber,
		VendorNumber2,
		VendorDescription,
		VendorGroup,
		BusinessUnit,
		VendorLanguage,
		VendorType,
		CompanyCode,
		TaxId1,
		TaxId2,
		InactiveDate,
		AuditVendorType,
		Custom,
		IsGroupVendor,
		CreatedBy,
		CreatedDate,
		LastModifiedBy,
		LastModifiedDate
	)
	SELECT 
		AppVendorId,
		VendorId,
		VendorName,
		VendorName2,
		VendorName3,
		VendorName4,
		VendorNumber,
		VendorNumber2,
		VendorDescription,
		VendorGroup,
		BusinessUnit,
		VendorLanguage,
		VendorType,
		CompanyCode,
		TaxId1,
		TaxId2,
		InactiveDate,
		AuditVendorType,
		Custom,
		IsGroupVendor,
		CreatedBy,
		CreatedDate,
		LastModifiedBy,
		LastModifiedDate
	FROM Inserted	
END

--rollback  SELECT 1 WHERE 1=0 ;

--changeset Sahil:PS-9212-3
ALTER TRIGGER [dbo].[TRG_vwAppVendor_InsteadOfUpdate]
ON vwAppVendor
INSTEAD OF UPDATE 
AS 
BEGIN
	
	--Record Exists in App Vendor

	
	UPDATE	AV
	SET 
		AV.VendorName	=	I.VendorName,
		AV.VendorName2	=	I.VendorName2,
		AV.VendorName3	=	I.VendorName3,
		AV.VendorName4	=	I.VendorName4,
		AV.VendorNumber	=	I.VendorNumber,
		AV.VendorNumber2	=	I.VendorNumber2,
		AV.VendorDescription	=	I.VendorDescription,
		AV.VendorGroup	=	I.VendorGroup,
		AV.BusinessUnit	=	I.BusinessUnit,
		AV.VendorLanguage	=	I.VendorLanguage,
		AV.VendorType	=	I.VendorType,
		AV.CompanyCode	=	I.CompanyCode,
		AV.TaxId1	=	I.TaxId1,
		AV.TaxId2	=	I.TaxId2,
		AV.InactiveDate	=	I.InactiveDate,
		AV.AuditVendorType	=	I.AuditVendorType,
		AV.Custom	=	I.Custom,
		AV.IsGroupVendor	=	I.IsGroupVendor,
		AV.CreatedBy	=	I.CreatedBy,
		AV.CreatedDate	=	I.CreatedDate,
		AV.LastModifiedBy	=	I.LastModifiedBy,
		AV.LastModifiedDate	=	I.LastModifiedDate	
	FROM INSERTED I
	JOIN AppVendor AV
	ON I.AppVendorId = AV.AppVendorId
	
	
	--Record doesn't exist in App Vendor
	INSERT INTO AppVendor
	(
		AppVendorId,
		VendorId,
		VendorName,
		VendorName2,
		VendorName3,
		VendorName4,
		VendorNumber,
		VendorNumber2,
		VendorDescription,
		VendorGroup,
		BusinessUnit,
		VendorLanguage,
		VendorType,
		CompanyCode,
		TaxId1,
		TaxId2,
		InactiveDate,
		AuditVendorType,
		Custom,
		IsGroupVendor,
		CreatedBy,
		CreatedDate,
		LastModifiedBy,
		LastModifiedDate
	)
	SELECT
		I.AppVendorId,
		I.VendorId,
		I.VendorName,
		I.VendorName2,
		I.VendorName3,
		I.VendorName4,
		I.VendorNumber,
		I.VendorNumber2,
		I.VendorDescription,
		I.VendorGroup,
		I.BusinessUnit,
		I.VendorLanguage,
		I.VendorType,
		I.CompanyCode,
		I.TaxId1,
		I.TaxId2,
		I.InactiveDate,
		I.AuditVendorType,
		I.Custom,
		I.IsGroupVendor,
		I.CreatedBy,
		I.CreatedDate,
		I.LastModifiedBy,
		I.LastModifiedDate
	FROM INSERTED I
	LEFT JOIN AppVendor AV
	ON I.AppVendorId = AV.AppVendorId
	WHERE AV.AppVendorId IS NULL

END

--rollback  SELECT 1 WHERE 1=0 ;

--changeset Sahil:PS-9212-4

ALTER FUNCTION [dbo].[UF_VenderSelection] 
(
    @ProjectId INT
)
RETURNS TABLE
AS
RETURN
	SELECT 
	[Id] = CONVERT(VARCHAR(100),vwAV.[AppVendorId]) + '-' + CONVERT(VARCHAR(10), ISNULL(@ProjectId,0)),
	VS.[VendorSelectionId],
	VS.[ProjectId],
	ISNULL(VS.[VendorSelectionStatusId], 3) AS VendorSelectionStatusId,
	vwAV.[AppVendorId],
	vwAV.[VendorId],
	[VendorName],
	[VendorName2],
	[VendorName3],
	[VendorName4],
	[VendorNumber],
	[VendorNumber2],
	[VendorDescription],
	[VendorGroup],
	[BusinessUnit],
	[VendorLanguage],
	[VendorType],
	[CompanyCode],
	[TaxId1],
	[TaxId2],
	[InactiveDate],
	[AuditVendorType],
	[Custom],
	[IsGroupVendor],
	vwAV.[CreatedDate],
	vwAV.[CreatedBy],
	vwAV.[LastModifiedDate],
	vwAV.[LastModifiedBy],
	vwVC.ContactName,
	vwVC.CompanyTitle,
	vwVC.ContactEmail,
	vwVC.OfficePhone,
	vwVC.CellPhone,
	vwVC.OtherPhone,
	vwVC.Fax,
	vwVA.TotalVolume,
	vwVA.NumberTransactions,
	vwVA.NumberCredits
	FROM vwAppVendor vwAV
	LEFT JOIN
	(
		SELECT 
		PVGC.ChildVendorId
		FROM
		ProjectVendorGroup PVG
		INNER JOIN ProjectVendorGroupChild PVGC ON PVG.GroupVendorId = PVGC.GroupVendorId 
		AND PVG.ProjectId = @ProjectId
	) CV
	ON vwAV.AppVendorId = CV.ChildVendorId
	LEFT JOIN ProjectVendorGroup PVG2
	ON PVG2.GroupVendorId = vwAV.AppVendorId AND PVG2.ProjectId = @ProjectId
	LEFT JOIN VendorSelection VS
	ON vwAV.AppVendorId = VS.AppVendorId 
	AND VS.ProjectId= @ProjectId
	LEFT JOIN vwVendorContactLatest vwVC ON vwVC.AppVendorId = vwAV.AppVendorId					
	LEFT JOIN vwVendorAggregateLatest vwVA ON vwVA.VendorGuid = vwAV.AppVendorId  
	WHERE (vwAV.IsGroupVendor = 0 AND CV.ChildVendorId IS NULL)
	OR
	(vwAV.IsGroupVendor = 1 AND PVG2.GroupVendorId IS NOT NULL)

--rollback SELECT 1 WHERE 1=0;

--changeset Sahil:PS-9212-5
CREATE FUNCTION [dbo].[UF_VendorSelectionChild] 
(
    @ProjectId INT,
	@GroupVendorId UNIQUEIDENTIFIER
)
RETURNS TABLE
AS
RETURN
	SELECT 
	[Id] = CONVERT(VARCHAR(100),vwAV.[AppVendorId]) + '-' + CONVERT(VARCHAR(10), ISNULL(@ProjectId,0)),
	VS.[VendorSelectionId],
	VS.[ProjectId],
	ISNULL(VS.[VendorSelectionStatusId], 3) AS VendorSelectionStatusId,
	vwAV.[AppVendorId],
	vwAV.[VendorId],
	[VendorName],
	[VendorName2],
	[VendorName3],
	[VendorName4],
	[VendorNumber],
	[VendorNumber2],
	[VendorDescription],
	[VendorGroup],
	[BusinessUnit],
	[VendorLanguage],
	[VendorType],
	[CompanyCode],
	[TaxId1],
	[TaxId2],
	[InactiveDate],
	[AuditVendorType],
	[Custom],
	[IsGroupVendor],
	vwAV.[CreatedDate],
	vwAV.[CreatedBy],
	vwAV.[LastModifiedDate],
	vwAV.[LastModifiedBy],
	vwVC.ContactName,
	vwVC.CompanyTitle,
	vwVC.ContactEmail,
	vwVC.OfficePhone,
	vwVC.CellPhone,
	vwVC.OtherPhone,
	vwVC.Fax,
	vwVA.TotalVolume,
	vwVA.NumberTransactions,
	vwVA.NumberCredits
	FROM vwAppVendor vwAV
	INNER JOIN
	(
		SELECT 
		PVGC.ChildVendorId
		FROM
		ProjectVendorGroup PVG
		INNER JOIN ProjectVendorGroupChild PVGC ON PVG.GroupVendorId = PVGC.GroupVendorId 
		AND PVG.ProjectId = @ProjectId
		WHERE PVG.GroupVendorId = @GroupVendorId
	) CV
	ON vwAV.AppVendorId = CV.ChildVendorId
	LEFT JOIN VendorSelection VS
	ON vwAV.AppVendorId = VS.AppVendorId 
	AND VS.ProjectId= @ProjectId
	LEFT JOIN vwVendorContactLatest vwVC ON vwVC.AppVendorId = vwAV.AppVendorId					
	LEFT JOIN vwVendorAggregateLatest vwVA ON vwVA.VendorGuid = vwAV.AppVendorId  

--rollback SELECT 1 WHERE 1=0;

--changeset SahilAggarwal:create-PS-10740

CREATE TABLE [dbo].[VendorStatementAction] (
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ActionTaken] [varchar](100),
	[Deleted] [bit] DEFAULT 0,	
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL
	CONSTRAINT PK_VendorStatementAction PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
) ON [PRIMARY]
;

--rollback  DROP TABLE [dbo].[VendorStatementAction];

--changeset NiteshJindal:Alter-PS-10866-2
CREATE UNIQUE NONCLUSTERED INDEX UQ_ObjectField_FieldOrder
ON objectField(objectId, fieldOrder)
WHERE fieldOrder IS NOT NULL;
--rollback drop index UQ_ObjectField_FieldOrder on objectField

--changeset NiteshJadon:create-PS-10534

CREATE TABLE [dbo].[ProjectVendorStatementAction](
	[Id] [BIGINT] IDENTITY(1,1) NOT NULL,
	[ProjectVendorId] [BIGINT] NOT NULL,
	[ActionTakenValueId] [BIGINT] NULL,
	[AssignToId] [BIGINT] NULL,
	[FollowUpDate] DATETIME2 NULL,
	[Deleted] [bit] DEFAULT 0,
	[CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
	
CONSTRAINT PK_ProjectVendorStatementAction PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_ProjectVendorStatementAction_ProjectVendor FOREIGN KEY (ProjectVendorId)
    REFERENCES ProjectVendor(Id),
	CONSTRAINT FK_ProjectVendorStatementAction_VendorStatementAction FOREIGN KEY (ActionTakenValueId)
    REFERENCES VendorStatementAction(id),
) ON [PRIMARY]
;  

--rollback  DROP TABLE [dbo].[ProjectVendorStatementAction] ;

--changeset VarunMehta:PostSchema-PS-10049

ALTER TABLE [dbo].[ObjectField] 
ALTER COLUMN [DisplayName] VARCHAR(50) NOT NULL
;

--rollback  ALTER TABLE [dbo].[ObjectField] ALTER COLUMN [DisplayName] VARCHAR(50) NULL

--changeset SiddharthSharma:PostSchema-PS-9375
IF(OBJECT_ID('fkAuditServiceline', 'F') IS NULL)
ALTER TABLE [dbo].[Audit] WITH CHECK ADD CONSTRAINT fkAuditServiceline FOREIGN KEY(ServiceLineId) REFERENCES dbo.ServiceLine(ServiceLineId)

--rollback  SELECT 1 WHERE 1=0;

--changeset SiddharthSharma:PostSchema-PS-9375-1
ALTER TABLE [dbo].[Audit]
ALTER COLUMN ServiceLineId bigint not null

--rollback  ALTER TABLE [dbo].[Audit] ALTER COLUMN ServiceLineId bigint null


--changeset JaspreetSingh:Alter-PS-11332
ALTER TABLE [dbo].[ProjectDataSet] ADD [CardId] INT NULL;
ALTER TABLE [dbo].[ProjectDataSet] ADD [ProjectDataSetOrderInCard] INT NULL;

CREATE TABLE [dbo].[ProjectDataSetCard](
	[ProjectDataSetCardId] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectId] [bigint] NOT NULL,
	[Name] [varchar](255) NULL,
	[CardNumber] [bigint] NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
CONSTRAINT PK_ProjectDataSetCard PRIMARY KEY CLUSTERED 
(
	[ProjectDataSetCardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_ProjectDataSetCard_Project FOREIGN KEY (ProjectID)
    REFERENCES Project(ProjectID),
) ON [PRIMARY];  

--rollback DROP TABLE [dbo].[ProjectDataSetCard];
--rollback ALTER TABLE [dbo].[ProjectDataSet] DROP COLUMN [ProjectDataSetOrderInCard];
--rollback ALTER TABLE [dbo].[ProjectDataSet] DROP COLUMN [CardId];

--changeset JaspreetSingh:Alter-PS-11332-1
DROP TABLE [dbo].[ProjectDataSetCard];
ALTER TABLE [dbo].[ProjectDataSet] DROP COLUMN [ProjectDataSetOrderInCard];
ALTER TABLE [dbo].[ProjectDataSet] DROP COLUMN [CardId];


ALTER TABLE [dbo].[ProjectDataSet] ADD [CardId] BIGINT NULL;
ALTER TABLE [dbo].[ProjectDataSet] ADD [OrderInCard] INT NULL;

CREATE TABLE [dbo].[ProjectDataSetCard](
	[Id] [BIGINT] IDENTITY(1,1) NOT NULL,
	[ProjectId] [BIGINT] NOT NULL,
	[Name] [varchar](255) NULL,
	[CardNumber] [INT] NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
CONSTRAINT PK_ProjectDataSetCard PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_ProjectDataSetCard_Project FOREIGN KEY (ProjectID)
    REFERENCES Project(ProjectID),
) ON [PRIMARY];

--rollback  SELECT 1 WHERE 1=0;


--liquibase formatted sql

--changeset mvp:create-1.0

CREATE TABLE [dbo].[TableConfig](
	[TableConfigId] [bigint] IDENTITY(1,1) NOT NULL,
	[TableConfigType] [int] NOT NULL, -- 1=origin history, 2=origin snapshot, 3=building block, 4=composite, 5=exception 
	[TableConfigName] [varchar](50) NOT NULL,
	[TableConfigDesc] [varchar](50) NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[Storage] [varchar](50) NOT NULL, --1= Physical or 2= In-Memory
	[ObjectType] [varchar](50) NOT NULL, --InvoiceHeader, InvoiceDetail, etc
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
	CONSTRAINT PK_TableConfig PRIMARY  KEY CLUSTERED 
(
	[TableConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];



CREATE TABLE [dbo].[FieldConfig](
	[FieldConfigId] [bigint] IDENTITY(1,1) NOT NULL,
	[TableConfigId] [bigint] NOT NULL,
	[FieldTypeId] [int] NOT NULL,   --1=Data, 2=Calculated
	[OriginName] [varchar](50) NOT NULL,
	[CommonName] [varchar](50) NULL,
	[ClientAlias] [varchar](50) NULL,
	[DataType] [varchar](50) NOT NULL,  
	[Formula] [varchar](50) NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
	CONSTRAINT PK_FieldConfig PRIMARY  KEY CLUSTERED 
(
	[FieldConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_FieldConfig_TableConfig FOREIGN KEY (TableConfigID)
    REFERENCES TableConfig(TableConfigID)
) ON [PRIMARY]


;


CREATE TABLE [dbo].[DataView](
	[DataViewId] [bigint] IDENTITY(1,1) NOT NULL,
	[DataViewName] [varchar](255) NULL,
	[DataViewDesc] [varchar](255) NULL,
	[TableConfigId] [bigint] NOT NULL,
	[ViewTypeId] [bigint] NULL, -- 1=Default, 2=Standard, 3=Custom
	[WhereClause] [varchar](255) NULL,
	[OrderByColumn] [varchar](255) NULL,
	[GroupByColumn] [varchar](255) NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
	CONSTRAINT PK_DataView PRIMARY KEY CLUSTERED 
	(
		[DataViewID] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
	IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 	ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_DataView_TableConfig FOREIGN KEY (TableConfigId)
    REFERENCES TableConfig(TableConfigId)
) ON [PRIMARY]

;


CREATE TABLE [dbo].[DataViewField](
	[DataViewFieldId] [bigint] IDENTITY(1,1) NOT NULL,
	[DataViewId] [bigint] NOT NULL,
	[FieldTypeId] [bigint] NULL,	-- 1=Data, 2=Calculated, 3=Spacer
	[FieldConfigId] [bigint] NULL,  -- NULL=Custom Field, (Value)=FK to FieldConfig
	[FieldLabel] [varchar](255) NULL,
	[ColumnOrder] [varchar](255) NULL,
	[BgColor] [varchar](255) NULL,	--Color for spacer columns
	[Formula] [varchar](255) NULL,	--Calculated columns
	[Hidden] [bit] NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
	CONSTRAINT PK_DataViewField PRIMARY KEY CLUSTERED 
	(
		[DataViewFieldID] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
	IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_DataViewField_DataView FOREIGN KEY (DataViewId)
    REFERENCES DataView(DataViewId),
	CONSTRAINT FK_DataViewField_FieldConfig FOREIGN KEY (FieldConfigId)
    REFERENCES FieldConfig(FieldConfigId)
) ON [PRIMARY]

;

CREATE TABLE [dbo].[ProjectType](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[ActiveDate] [datetime2](7) NULL,
	[InactiveDate] [datetime2](7) NULL,
	CONSTRAINT PK_ProjectType PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
) ON [PRIMARY]



;


CREATE TABLE [dbo].[Audit](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NULL,
	[ShortName] [varchar](255) NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[ActiveDate] [datetime2](7) NULL,
	[InactiveDate] [datetime2](7) NULL,
	CONSTRAINT PK_Audit PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

;


CREATE TABLE [dbo].[Project](
	[ProjectId] [bigint] IDENTITY(1,1) NOT NULL,	
	[ProjectName] [varchar](255) NULL,
	[ProjectType] [bigint] NOT NULL,
	[ProjectStart] [datetime2](7) NULL,
	[ProjectEnd] [datetime2](7) NULL,
	[ScopeStart] [datetime2](7) NULL,
	[ScopeEnd] [datetime2](7) NULL,
	[AuditId] [bigint] NOT NULL,    
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
CONSTRAINT PK_PROJECT PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_Project_ProjectType FOREIGN KEY (ProjectType)
    REFERENCES ProjectType(Id),
	CONSTRAINT FK_Project_AuditID FOREIGN KEY (AuditId)
    REFERENCES Audit(Id)
) ON [PRIMARY]



;


CREATE TABLE [dbo].[ProjectDataSet](
	[ProjectDataSetId] [bigint] IDENTITY(1,1) NOT NULL,
	[DataSetId] [bigint] NOT NULL, --table config id
	[ProjectId] [bigint] NOT NULL,
	[DefaultTabName] [varchar](255) NULL,
	[DefaultDataViewId] [bigint] NOT NULL,
	[Display] [bigint] NULL, --1 = By Record, 2 or other values = By Record Group	
	[Grouping] [varchar](255) NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
CONSTRAINT PK_ProjectDataSet PRIMARY KEY CLUSTERED 
(
	[ProjectDataSetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_ProjectDataSet_DataSetID FOREIGN KEY (DataSetId)
    REFERENCES TableConfig(TableConfigID),
	CONSTRAINT FK_ProjectDataSet_Project FOREIGN KEY (ProjectID)
    REFERENCES Project(ProjectID),
	CONSTRAINT FK_ProjectDataSet_DataView FOREIGN KEY (DefaultDataViewId)
    REFERENCES DataView(DataViewId)
) ON [PRIMARY]

;  


--rollback  DROP TABLE [dbo].[ProjectDataSet] ;

--rollback DROP TABLE [dbo].[Project] ;

--rollback  DROP TABLE [dbo].[Audit] ;

--rollback  DROP TABLE [dbo].[ProjectType] ;

--rollback  DROP TABLE [dbo].[DataViewField] ;

--rollback  DROP TABLE [dbo].[DataView] ;

--rollback  DROP TABLE [dbo].[FieldConfig] ;

--rollback  DROP TABLE [dbo].[TableConfig] ;


--changeset mvp:create-ServiceLine

CREATE TABLE [dbo].[ServiceLine](
	[ServiceLineId] [bigint] IDENTITY(1,1) NOT NULL, 
	[ServiceLineName] [varchar](100) NOT NULL UNIQUE,
	[ActiveDate] [datetime2](7) NULL,
	[InactiveDate] [datetime2](7) NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	CONSTRAINT PK_ServiceLine PRIMARY  KEY CLUSTERED 
(
	[ServiceLineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
;

--rollback  DROP TABLE [dbo].[ServiceLine] ;

--changeset NiteshJadon:create-CS-736

CREATE TABLE [dbo].[RootCause](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](255) NULL,
	[ServiceLineId] [bigint] NOT NULL, 
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
	CONSTRAINT PK_RootCause PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_RootCause_ServiceLine FOREIGN KEY (ServiceLineId)
    REFERENCES ServiceLine(ServiceLineId),
) ON [PRIMARY]

; 

--rollback  DROP TABLE [dbo].[RootCause] ;

--changeset NavalPrabhakar:create-CS-747

CREATE TABLE [dbo].[ExceptionClaimMapping](
	[ExceptionClaimMappingID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectID] [bigint] NOT NULL, --table config id
	[DataSetConfigID] [bigint] NOT NULL,
	[Deleted] [bit] DEFAULT 0,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
CONSTRAINT PK_ExceptionClaimMapping PRIMARY KEY CLUSTERED 
(
	[ExceptionClaimMappingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],

	CONSTRAINT FK_ExceptionClaimMapping_TableConfig FOREIGN KEY (DataSetConfigID)
    REFERENCES TableConfig(TableConfigID),

	CONSTRAINT FK_ExceptionClaimMapping_Project FOREIGN KEY (ProjectID)
    REFERENCES Project(ProjectID),
	
	CONSTRAINT UC_ExceptionClaimMapping UNIQUE (ProjectID, DataSetConfigID)

) ON [PRIMARY]

;  

CREATE TABLE [dbo].[ExceptionClaimMappingDetail](
	[ExceptionClaimMappingDetailID] [bigint] IDENTITY(1,1) NOT NULL,
	[ExceptionClaimMappingID] [bigint] NOT NULL,
	[ExceptionFieldID] [bigint] NOT NULL,
	[ClaimFieldName] [varchar](255),
	[MappingType] [varchar](20),
	[Deleted] [bit] DEFAULT 0,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
CONSTRAINT PK_ExceptionClaimMappingDetail PRIMARY KEY CLUSTERED 
(
	[ExceptionClaimMappingDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],

	CONSTRAINT FK_ExceptionClaimMappingDetail_ExceptionClaimMapping FOREIGN KEY (ExceptionClaimMappingID)
    REFERENCES ExceptionClaimMapping(ExceptionClaimMappingID),

	CONSTRAINT FK_ExceptionClaimMappingDetail_FieldConfig FOREIGN KEY (ExceptionFieldID)
    REFERENCES FieldConfig(FieldConfigID)
) ON [PRIMARY]

;


--rollback  DROP TABLE [dbo].[ExceptionClaimMappingDetail] ;
--rollback  DROP TABLE [dbo].[ExceptionClaimMapping] ;

--changeset SiddharthSharma:create-PS-5901

create table [dbo].[DataSetOption]
(
Id bigint not null IDENTITY(1,1),
CreatedBy varchar(255) not null, 
CreatedDate datetime2 not null,
InactiveDate datetime2, 
AllApplicable bit not null, 
LastModifiedBy varchar(255), 
LastModifiedDate datetime2, 
Name varchar(255) unique not null, 
Type varchar(255) not null, 
primary key (Id)
)


create table [dbo].[DataSetOptionsDataTypes]
(
OptionId bigint not null, 
ApplicableDataTypes varchar(255),
CONSTRAINT FK_DataSetOptionsDataTypes_DataSetOption FOREIGN KEY (OptionId)
    REFERENCES DataSetOption(Id)
)

--rollback DROP TABLE DataSetOptionsDataTypes
--rollback DROP TABLE DataSetOption

--changeset NIteshJindal:create-PS-5193

CREATE TABLE [dbo].[Object]
(
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [Name] VARCHAR(255),
    [CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
    CONSTRAINT PK_Object PRIMARY  KEY CLUSTERED 
    (
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
    CONSTRAINT UQ_Object_Name UNIQUE(Name) 
)

CREATE TABLE [dbo].[ObjectFieldType]
(
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [Name] VARCHAR(255),
    [InactiveDate] DATETIME2,
    [CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
    CONSTRAINT PK_ObjectFieldType PRIMARY  KEY CLUSTERED 
    (
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)


CREATE TABLE [dbo].[ObjectField]
(
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [Name] VARCHAR(255),
    [FieldType] VARCHAR(255),
    [DefaultValue] VARCHAR(255),
    [IsRequired] BIT,
    [ObjectId] BIGINT NOT NULL,
    [ObjectFieldTypeId] BIGINT NOT NULL,
    [CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
    CONSTRAINT PK_ObjectField PRIMARY  KEY CLUSTERED 
    (
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_ObjectField_ObjectFieldType FOREIGN KEY (ObjectFieldTypeId)
    REFERENCES [dbo].[ObjectFieldType](Id),
    CONSTRAINT FK_ObjectField_Object FOREIGN KEY(ObjectId)
    REFERENCES [dbo].[Object](Id),
    CONSTRAINT UQ_ObjectField_Name UNIQUE(Name, ObjectId)
)


CREATE TABLE [dbo].[ObjectFieldValue]
(
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [Value] VARCHAR(255),
    [ValueOrder] INTEGER,
    [ObjectFieldId] BIGINT NOT NULL,
    CONSTRAINT PK_ObjectFieldValue PRIMARY  KEY CLUSTERED 
    (
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_ObjectFieldValue_ObjectField FOREIGN KEY(ObjectFieldId)
    REFERENCES [dbo].[ObjectField](Id)
)


CREATE TABLE [dbo].[ObjectFieldServiceLine]
(
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [ServiceLineId] BIGINT NOT NULL,
    [DefaultValue] VARCHAR(255),
    [FieldAlias] VARCHAR(255),
    [IsRequired] BIT,
    [SortAlphabetically] BIT,
    [ObjectFieldId] BIGINT NOT NULL,
    [CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
    CONSTRAINT PK_ObjectFieldServiceLine PRIMARY  KEY CLUSTERED 
    (
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT UQ_ObjectFieldServiceLine_Name UNIQUE(ObjectFieldId, ServiceLineId),
    CONSTRAINT FK_ObjectFieldServiceLine_ObjectField FOREIGN KEY(ObjectFieldId)
    REFERENCES [dbo].[ObjectField](Id)
)



CREATE TABLE [dbo].[ObjectFieldServiceLineValue]
(
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [ValueOrder] INTEGER,
    [ObjectFieldServiceLineId] BIGINT,
    [ObjectFieldValueId] BIGINT,
    CONSTRAINT PK_ObjectFieldServiceLineValue PRIMARY  KEY CLUSTERED 
    (
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
    CONSTRAINT FK_ObjectFieldServiceLineValue_ObjectFieldServiceLine FOREIGN KEY(ObjectFieldServiceLineId)
    REFERENCES [dbo].[ObjectFieldServiceLine](Id),
    CONSTRAINT FK_ObjectFieldServiceLineValue_ObjectFieldValue FOREIGN KEY(ObjectFieldValueId)
    REFERENCES [dbo].[ObjectFieldValue](Id)
)

--rollback  DROP TABLE [dbo].[ObjectFieldServiceLineValue];
--rollback  DROP TABLE [dbo].[ObjectFieldServiceLine];
--rollback  DROP TABLE [dbo].[ObjectFieldValue];
--rollback  DROP TABLE [dbo].[ObjectField];
--rollback  DROP TABLE [dbo].[ObjectFieldType];
--rollback  DROP TABLE [dbo].[Object];

--changeset Om Parkash:create-PS-5976

CREATE TABLE [dbo].[AttachmentContext](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](64) NULL,
	[Context] [varchar](1650) NULL,
    [Type] [varchar](50) NULL,
CONSTRAINT PK_AttachmentContext PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	
	CONSTRAINT uc_context_with_type UNIQUE NONCLUSTERED (Context, Type)

) ON [PRIMARY]
;  

--rollback  DROP TABLE [dbo].[AttachmentContext] ;

--changeset NIteshJindal:create-PS-5193-2

DROP TABLE [dbo].[ObjectFieldServiceLineValue];
DROP TABLE [dbo].[ObjectFieldServiceLine];
DROP TABLE [dbo].[ObjectFieldValue];
DROP TABLE [dbo].[ObjectField];
DROP TABLE [dbo].[ObjectFieldType];
DROP TABLE [dbo].[Object];

CREATE TABLE [dbo].[Object]
(
    [Id] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [Name] VARCHAR(255),
    [CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
    CONSTRAINT PK_Object PRIMARY  KEY CLUSTERED 
    (
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
    CONSTRAINT UQ_Object_Name UNIQUE(Name) 
)

CREATE TABLE [dbo].[ObjectFieldType]
(
    [Id] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [Name] VARCHAR(255),
    [InactiveDate] DATETIME2,
    [CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
    CONSTRAINT PK_ObjectFieldType PRIMARY  KEY CLUSTERED 
    (
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)


CREATE TABLE [dbo].[ObjectField]
(
    [Id] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [Name] VARCHAR(255),
    [FieldType] VARCHAR(255),
    [DefaultValue] VARCHAR(255),
    [IsRequired] BIT,
    [ObjectId] UNIQUEIDENTIFIER NOT NULL,
    [ObjectFieldTypeId] UNIQUEIDENTIFIER NOT NULL,
    [CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
    CONSTRAINT PK_ObjectField PRIMARY  KEY CLUSTERED 
    (
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_ObjectField_ObjectFieldType FOREIGN KEY (ObjectFieldTypeId)
    REFERENCES [dbo].[ObjectFieldType](Id),
    CONSTRAINT FK_ObjectField_Object FOREIGN KEY(ObjectId)
    REFERENCES [dbo].[Object](Id),
    CONSTRAINT UQ_ObjectField_Name UNIQUE(Name, ObjectId)
)


CREATE TABLE [dbo].[ObjectFieldValue]
(
    [Id] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [Value] VARCHAR(255),
    [ValueOrder] INTEGER,
    [ObjectFieldId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT PK_ObjectFieldValue PRIMARY  KEY CLUSTERED 
    (
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_ObjectFieldValue_ObjectField FOREIGN KEY(ObjectFieldId)
    REFERENCES [dbo].[ObjectField](Id)
)


CREATE TABLE [dbo].[ObjectFieldServiceLine]
(
    [Id] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [ServiceLineId] BIGINT NOT NULL,
    [DefaultValue] VARCHAR(255),
    [FieldAlias] VARCHAR(255),
    [IsRequired] BIT,
    [SortAlphabetically] BIT,
    [ObjectFieldId] UNIQUEIDENTIFIER NOT NULL,
    [CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
    CONSTRAINT PK_ObjectFieldServiceLine PRIMARY  KEY CLUSTERED 
    (
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT UQ_ObjectFieldServiceLine_Name UNIQUE(ObjectFieldId, ServiceLineId),
    CONSTRAINT FK_ObjectFieldServiceLine_ObjectField FOREIGN KEY(ObjectFieldId)
    REFERENCES [dbo].[ObjectField](Id)
)



CREATE TABLE [dbo].[ObjectFieldServiceLineValue]
(
    [Id] UNIQUEIDENTIFIER DEFAULT NEWID(),
    [ValueOrder] INTEGER,
    [ObjectFieldServiceLineId] UNIQUEIDENTIFIER,
    [ObjectFieldValueId] UNIQUEIDENTIFIER,
    CONSTRAINT PK_ObjectFieldServiceLineValue PRIMARY  KEY CLUSTERED 
    (
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
    CONSTRAINT FK_ObjectFieldServiceLineValue_ObjectFieldServiceLine FOREIGN KEY(ObjectFieldServiceLineId)
    REFERENCES [dbo].[ObjectFieldServiceLine](Id),
    CONSTRAINT FK_ObjectFieldServiceLineValue_ObjectFieldValue FOREIGN KEY(ObjectFieldValueId)
    REFERENCES [dbo].[ObjectFieldValue](Id)
)

--rollback SELECT 1 WHERE 1=0; 


--changeset Sahil Aggrawal:create-PS-6490

CREATE TABLE [dbo].[Vendor](
	[VendorGuid] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[VenID] [int] UNIQUE NOT NULL,
	[VenName] [nvarchar](100) NULL,
	[VenName2] [nvarchar](100) NULL,
	[VenName3] [nvarchar](100) NULL,
	[VenName4] [nvarchar](100) NULL,
	[VenNum] [nvarchar](50) NULL,
	[VenNum2] [nvarchar](50) NULL,
	[VenDesc] [nvarchar](100) NULL,
	[VenGroup] [nvarchar](100) NULL,
	[BusUnit] [nvarchar](50) NULL,
	[VenLang] [nvarchar](50) NULL,
	[VenType] [nvarchar](100) NULL,
	[CompCd] [nvarchar](50) NULL,
	[TaxID1] [nvarchar](50) NULL,
	[TaxID2] [nvarchar](50) NULL,
	[ClientSystem]  [nvarchar](50) NULL,
	[Landscape] [nvarchar](25) NULL,
	[InactiveDt] [date] NULL,
	[CreatedDt] [date] NULL,
	[CreatedBy] [varchar](25) NULL,
	[ModifiedDt] [date] NULL,
	[ModifiedBy] [varchar](25) NULL,
	[VATReg] [nvarchar](50) NULL
CONSTRAINT PK_Vendor PRIMARY  KEY CLUSTERED 
(
	[VendorGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
;

CREATE TABLE [dbo].[VendorAddresses](
    [VenAddressGuid] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[VenID] [int] NOT NULL,
	[VenAddressID] [int] NOT NULL,
	[AddrName] [nvarchar](50) NULL,
	[Addr1] [nvarchar](50) NULL,
	[Addr2] [nvarchar](50) NULL,
	[Addr3] [nvarchar](50) NULL,
	[Addr4] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[District] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[Zip] [varchar](10) NULL,
	[County] [nvarchar](50) NULL,
	[CreatedDt] [date] NULL,
	[CreatedBy] [varchar](25) NULL,
	[ModifiedDt] [date] NULL,
	[ModifiedBy] [varchar](25) NULL
CONSTRAINT PK_VendorAddresses PRIMARY  KEY CLUSTERED 
(
	[VenAddressGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_VendorAddresses_Vendor FOREIGN KEY (VenID)
    REFERENCES Vendor(VenID)
) ON [PRIMARY]
;

CREATE TABLE [dbo].[VendorContacts](
	[VenContactGuid] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
    [VenID] [int] NOT NULL,
	[VenContactID] [int] NOT NULL,
	[FName] [nvarchar](50) NULL,
	[LName] [nvarchar](50) NULL,
	[Greeting] [nvarchar](50) NULL,
	[Title] [nvarchar](50) NULL,
	[Email] [varchar](100) NULL,
	[Office] [varchar](50) NULL,
	[OfficePrefix] [varchar](3) NULL,
	[Cell] [varchar](25) NULL,
	[CellPrefix] [varchar](3) NULL,
	[Other] [varchar](25) NULL,
	[OtherPrefix] [varchar](3) NULL,
	[Fax] [varchar](50) NULL,
	[FaxPrefix] [varchar](3) NULL,
	[CreatedDt] [date] NULL,
	[CreatedBy] [varchar](25) NULL,
	[ModifiedDt] [date] NULL,
	[ModifiedBy] [varchar](25) NULL
CONSTRAINT PK_VendorContacts PRIMARY  KEY CLUSTERED 
(
	[VenContactGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_VendorContacts_Vendor FOREIGN KEY (VenID)
    REFERENCES Vendor(VenID)
) ON [PRIMARY]
;

CREATE TABLE [dbo].[VendorAggregates](
	[VenAggregateGuid] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
    [VenID] [int] NOT NULL,
	[VenAggID] [int] NOT NULL,
	[VenNum] [nvarchar](50) NULL,
	[AggStartDt] [date] NULL,
	[AggEndDt] [date] NULL,
	[ClientSystem] [nvarchar](50) NULL,
	[Landscape] [nvarchar](50) NULL,
	[Entity] [nvarchar](50) NULL,
	[Region] [nvarchar](50) NULL,
	[Division] [nvarchar](50) NULL,
	[LastInvDt] [date] NULL,
	[LastInvNum] [nvarchar](50) NULL,
	[LastPayDt] [date] NULL,
	[AvgVolByMo] [decimal](18, 2) NULL,
	[TotVol] [decimal](18, 2) NULL,
	[Yr1Vol] [decimal](18, 2) NULL,
	[Yr2Vol] [decimal](18, 2) NULL,
	[Yr3Vol] [decimal](18, 2) NULL,
	[Yr4Vol] [decimal](18, 2) NULL,
	[TotCt] [int] NULL,
	[Yr1Ct] [int] NULL,
	[Yr2Ct] [int] NULL,
	[Yr3Ct] [int] NULL,
	[Yr4Ct] [int] NULL,
	[TotCr] [decimal](18, 2) NULL,
	[Yr1Cr] [decimal](18, 2) NULL,
	[Yr2Cr] [decimal](18, 2) NULL,
	[Yr3Cr] [decimal](18, 2) NULL,
	[Yr4Cr] [decimal](18, 2) NULL,
	[TotCrCt] [int] NULL,
	[Yr1CrCt] [int] NULL,
	[Yr2CrCt] [int] NULL,
	[Yr3CrCt] [int] NULL,
	[Yr4CrCt] [int] NULL,
	[CreatedDt] [date] NULL,
	[CreatedBy] [varchar](25) NULL,
	[ModifiedDt] [date] NULL,
	[ModifiedBy] [varchar](25) NULL
CONSTRAINT PK_VendorAggregates PRIMARY  KEY CLUSTERED 
(
	[VenAggregateGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_VendorAggregates_Vendor FOREIGN KEY (VenID)
    REFERENCES Vendor(VenID)
) ON [PRIMARY]
;

CREATE TABLE [dbo].[VendorAccounts](
	[VenAccountGuid] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
    [VenID] [int] NOT NULL,
	[VenAccountID] [int] NOT NULL,
	[VenCompCd] [nvarchar](50) NULL,
	[VenTermCd] [nvarchar](50) NULL,
	[CreatedDt] [date] NULL,
	[CreatedBy] [varchar](25) NULL,
	[ModifiedDt] [date] NULL,
	[ModifiedBy] [varchar](25) NULL
CONSTRAINT PK_VendorAccounts PRIMARY  KEY CLUSTERED 
(
	[VenAccountGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_VendorAccounts_Vendor FOREIGN KEY (VenID)
    REFERENCES Vendor(VenID)
) ON [PRIMARY]
;

--rollback  DROP TABLE [dbo].[Vendor];
--rollback  DROP TABLE [dbo].[VendorAddresses];
--rollback  DROP TABLE [dbo].[VendorContacts];
--rollback  DROP TABLE [dbo].[VendorAggregates];
--rollback  DROP TABLE [dbo].[VendorAccounts];
 

--changeset Nitesh Jadon:create-PS-6402

CREATE TABLE [dbo].[AppVendor](
	[AppVendorId] [uniqueidentifier] NOT NULL,
	[VendorId] [INT] NULL,
	[VendorName] [NVARCHAR](100) NULL,
	[VendorName2] [NVARCHAR](100) NULL,
	[VendorName3] [NVARCHAR](100) NULL,
	[VendorName4] [NVARCHAR](100) NULL,
	[VendorNumber] [NVARCHAR](50) NULL,
	[VendorNumber2] [NVARCHAR](50) NULL,
	[VendorDescription] [NVARCHAR](100) NULL,
	[VendorGroup] [NVARCHAR](100) NULL,
	[BusinessUnit] [NVARCHAR](50) NULL,
	[VendorLanguage] [NVARCHAR](50) NULL,
	[VendorType] [NVARCHAR](100) NULL,
	[CompanyCode] [NVARCHAR](50) NULL,
	[TaxId1] [NVARCHAR](50) NULL,
	[TaxId2] [NVARCHAR](50) NULL,
	[InactiveDate] DATETIME2 NULL,
	[AuditVendorType] [VARCHAR](50) NULL,
	[Custom] [VARCHAR](MAX) NULL,
	[CreatedBy] VARCHAR(255),
    [CreatedDate] DATETIME2,
    [LastModifiedBy] VARCHAR(255),
    [LastModifiedDate] DATETIME2,
	SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL ,
	SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
	PERIOD FOR SYSTEM_TIME (SysStartTime,SysEndTime),
	CONSTRAINT PK_AppVendor PRIMARY  KEY CLUSTERED(AppVendorId)
) WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.AppVendorHistory, DATA_CONSISTENCY_CHECK = ON));  

--rollback  DROP TABLE [dbo].[AppVendor] ;

--changeset Nitesh Jadon:create-PS-6402-1
CREATE VIEW [dbo].[vwAppVendor] 
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
	ISNULL(AV.CreatedDate, V.CreatedDt) as CreatedDate,
	ISNULL(AV.CreatedBy, V.CreatedBy) as CreatedBy,
	ISNULL(AV.LastModifiedDate, V.ModifiedDt) as LastModifiedDate,
	ISNULL(AV.LastModifiedBy, V.ModifiedBy) as LastModifiedBy

FROM Vendor V
FULL OUTER JOIN AppVendor AV
ON AV.VendorId = V.VenID

--rollback  DROP VIEW [dbo].[vwAppVendor] ;

--changeset Nitesh Jadon:create-PS-6402-2
CREATE TRIGGER [dbo].[TRG_vwAppVendor_InsteadOfInsert]  
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
		CreatedBy,
		CreatedDate,
		LastModifiedBy,
		LastModifiedDate
	FROM Inserted	
END
--rollback  DROP TRIGGER [dbo].[TRG_vwAppVendor_InsteadOfInsert] ;


--changeset Nitesh Jadon:create-PS-6402-3
CREATE TRIGGER [dbo].[TRG_vwAppVendor_InsteadOfUpdate]
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
		I.CreatedBy,
		I.CreatedDate,
		I.LastModifiedBy,
		I.LastModifiedDate
	FROM INSERTED I
	LEFT JOIN AppVendor AV
	ON I.AppVendorId = AV.AppVendorId
	WHERE AV.AppVendorId IS NULL

END
--rollback  DROP TRIGGER [dbo].[TRG_vwAppVendor_InsteadOfUpdate] ;


--changeset ShreyaMalhotra:create-PS-6457

CREATE TABLE [dbo].[VendorSelectionStatus](
	[VendorSelectionStatusId] [bigint] IDENTITY(1,1) NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
	[VendorSelectionStatusValue] [varchar](255) unique not null,
	CONSTRAINT PK_VendorSelectionStatus PRIMARY KEY CLUSTERED 
(
	[VendorSelectionStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--rollback  DROP TABLE [dbo].[VendorSelectionStatus] ;


--changeset ShreyaMalhotra:create-PS-6413

CREATE TABLE [dbo].[VendorSelection](
	[VendorSelectionId] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectId] [bigint] NOT NULL, 
	[VendorId] [int]  NULL,
	[AppVendorId] [uniqueidentifier] NOT NULL, 	
	[VendorSelectionStatusId] [bigint] NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
	CONSTRAINT PK_VendorSelection PRIMARY KEY CLUSTERED 
(
	[VendorSelectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],

	CONSTRAINT FK_VendorSelection_Project FOREIGN KEY (ProjectId)
    REFERENCES Project(ProjectId),
	
	CONSTRAINT UC_VendorSelection UNIQUE (ProjectId, AppVendorId)

) ON [PRIMARY]

--rollback  DROP TABLE [dbo].[VendorSelection] ;

--changeset ShreyaMalhotra:create-PS-6424
CREATE View [dbo].[vwVendorSelection]
AS

	SELECT 
	[Id] = CONVERT(VARCHAR(100), vwAV.[AppVendorId]) + '-' + '0',
	NULL AS [VendorSelectionId],
	NULL [ProjectId],
	NULL [VendorSelectionStatusId],
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
	vwAV.[LastModifiedBy] 
	FROM vwAppVendor vwAV
	
	UNION
	
	SELECT 
	[Id] = CONVERT(VARCHAR(100),vwAV.[AppVendorId]) + '-' + CONVERT(VARCHAR(10), [ProjectId]),
	VS.[VendorSelectionId],
	VS.[ProjectId],
	VS.[VendorSelectionStatusId],
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
	vwAV.[LastModifiedBy] 
	FROM vwAppVendor vwAV
	JOIN VendorSelection VS
	ON vwAV.AppVendorId = VS.AppVendorId 
	
--rollback  DROP VIEW [dbo].[vwVendorSelection] ;

--changeset ShreyaMalhotra:create-PS-6424-1	
CREATE FUNCTION [dbo].[UF_VenderSelection] 
(
    @ProjectId INT
)
RETURNS TABLE
AS
RETURN
	SELECT 
	* 
	FROM vwVendorSelection
	WHERE ProjectId = @ProjectId
	
	UNION 
	
	SELECT * 
	FROM vwVendorSelection
	WHERE ProjectId IS NULL 
	AND AppVendorId NOT IN 
	(
		SELECT AppVendorId 
		FROM vwVendorSelection
		WHERE ProjectId = @ProjectId
	)
	
--rollback  DROP FUNCTION [dbo].[UF_VenderSelection] ;

--changeset Nitesh Jadon:create-PS-5890	

CREATE TABLE [dbo].[ModuleConfig](
	[Id] [bigint] IDENTITY(1,1) NOT NULL, 
	[ModuleName] [VARCHAR](50) NOT NULL UNIQUE,
	[Configuration] [VARCHAR](20) NULL,
	[InactiveDate] [DATETIME2](7) NULL,
	[CreatedBy] [VARCHAR](255) NULL,
	[CreatedDate] [DATETIME2](7) NULL,
	[LastModifiedBy] [VARCHAR](255) NULL,
	[LastModifiedDate] [DATETIME2](7) NULL,
	CONSTRAINT PK_ModuleConfig PRIMARY  KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
;
--rollback  DROP TABLE [dbo].[ModuleConfig] ;

--changeset NiteshJindal:create-PS-6720

CREATE TABLE [dbo].[ClusterClaimMapping] (
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectId] [bigint] NOT NULL,
	[ViewId] [bigint] NOT NULL,
	[ClusterId] varchar(100),
	[ClaimId] [bigint] NOT NULL,
	[InactiveDate] [datetime2](7) NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
	CONSTRAINT PK_ClusterClaimMapping PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_ClusterClaimMapping_Project FOREIGN KEY (ProjectId)
    REFERENCES Project(ProjectId),
	CONSTRAINT FK_ClusterClaimMapping_DataView FOREIGN KEY (ViewId)
    REFERENCES DataView(DataViewId),
	INDEX IDX_ClusterClaimMapping NONCLUSTERED (ViewId, ClusterId)
) ON [PRIMARY]


Create TABLE [dbo].[RecordClaimMapping] (
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ClusterClaimMappingId] [bigint] NOT NULL,
	[PkeyId] [varchar](100),
	[Invalid] [varchar](10),
	[DataSetConfigId] [bigint] NOT NULL,
	[InactiveDate] [datetime2](7) NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[Deleted] [bit] DEFAULT 0,
	CONSTRAINT PK_RecordClaimMapping PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	CONSTRAINT FK_RecordClaimMapping_ClusterClaimMapping FOREIGN KEY (ClusterClaimMappingId)
    REFERENCES ClusterClaimMapping(Id),
	CONSTRAINT FK_RecordClaimMapping_TableConfig FOREIGN KEY (DataSetConfigID)
    REFERENCES TableConfig(TableConfigId),
	INDEX IDX_RecordClaimMapping NONCLUSTERED (PkeyId, DataSetConfigID)
) ON [PRIMARY]

--rollback  DROP TABLE [dbo].[RecordClaimMapping];
--rollback  DROP TABLE [dbo].[ClusterClaimMapping];

--changeset GauravGulati:update-PS-7086-1
CREATE FUNCTION [dbo].[UF_CheckCount] (@name varchar(255), @id bigint)
RETURNS int
AS 
BEGIN
  DECLARE @retval int
    SELECT @retval =count(*)
    FROM DataView
    WHERE DataViewName = @name and TableConfigId = @id and (Deleted = 0 or Deleted is null)
  RETURN @retval
END;

--rollback  DROP FUNCTION [dbo].[UF_CheckCount] ;

--changeset ShreyaMalhotra:create-PS-5627
CREATE TABLE [dbo].[ProjectModuleConfig](
	[ProjectModuleConfigId] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectId] [bigint] NOT NULL,
	[ModuleId] [bigint] NOT NULL,
	[ModuleOrder] [bigint] NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
CONSTRAINT PK_ProjectModuleConfig PRIMARY KEY CLUSTERED 
(
	[ProjectModuleConfigId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],

	CONSTRAINT FK_ProjectModuleConfig_ModuleConfig FOREIGN KEY (ModuleId)
    REFERENCES ModuleConfig(Id),

	CONSTRAINT FK_ProjectModuleConfig_Project FOREIGN KEY (ProjectId)
    REFERENCES Project(ProjectId),
	
	CONSTRAINT UC_ProjectModuleConfig_ProjectId_ModuleId UNIQUE (ProjectId, ModuleId),
	CONSTRAINT UC_ProjectModuleConfig_ProjectId_ModuleOrder UNIQUE (ProjectId, ModuleOrder)

) ON [PRIMARY]

--rollback  DROP TABLE [dbo].[ProjectModuleConfig] ;

--changeset GauravGulati:create-PS-9855

CREATE TABLE [dbo].[FieldConfigMapping](
	[FieldConfigMappingId] [bigint] IDENTITY(1,1) NOT NULL,
	[ColumnOrder] [bigint] NOT NULL,
	[DisplayName] [varchar](255) NULL,
	[Editable] [bit] NULL,
	[DataObjectId] [uniqueidentifier] NULL,
	[DataObjectFieldId] [uniqueidentifier] NULL,
	[FieldConfigId] [bigint] NOT NULL UNIQUE,
	[CreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [varchar](255) NULL,
	[LastModifiedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_FieldConfigMapping] PRIMARY KEY CLUSTERED 
(
	[FieldConfigMappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],

 CONSTRAINT [FK_FieldConfigMapping_FieldConfig] FOREIGN KEY([FieldConfigId])
 REFERENCES [dbo].[FieldConfig] ([FieldConfigId])
 
) ON [PRIMARY]


--rollback  DROP TABLE [dbo].[FieldConfigMapping] ;



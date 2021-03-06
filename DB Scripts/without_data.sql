USE [master]
GO
/****** Object:  Database [PCOHRAppDB]    Script Date: 12/31/2020 3:23:30 PM ******/
CREATE DATABASE [PCOHRAppDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PCOHRAppDB', FILENAME = N'E:\DB\PCOHRAppDB.mdf' , SIZE = 9216KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PCOHRAppDB_log', FILENAME = N'D:\PCOHRAppDB_log.ldf' , SIZE = 11200KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PCOHRAppDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PCOHRAppDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PCOHRAppDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PCOHRAppDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PCOHRAppDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PCOHRAppDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PCOHRAppDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET RECOVERY FULL 
GO
ALTER DATABASE [PCOHRAppDB] SET  MULTI_USER 
GO
ALTER DATABASE [PCOHRAppDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PCOHRAppDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PCOHRAppDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PCOHRAppDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [PCOHRAppDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PCOHRAppDB', N'ON'
GO
USE [PCOHRAppDB]
GO
/****** Object:  UserDefinedTableType [dbo].[CollectionList]    Script Date: 12/31/2020 3:23:30 PM ******/
CREATE TYPE [dbo].[CollectionList] AS TABLE(
	[collectionId] [int] NOT NULL,
	[customerSL] [varchar](20) NULL,
	[pageNo] [varchar](20) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[IDList]    Script Date: 12/31/2020 3:23:30 PM ******/
CREATE TYPE [dbo].[IDList] AS TABLE(
	[id] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ProjectCatetakerList]    Script Date: 12/31/2020 3:23:30 PM ******/
CREATE TYPE [dbo].[ProjectCatetakerList] AS TABLE(
	[projectId] [int] NOT NULL,
	[careTakerId] [int] NOT NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[getCompanyAddress]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 26 Jun 2020
-- =============================================
CREATE FUNCTION [dbo].[getCompanyAddress]
(
	@companyId int
)
RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @companyAddress nvarchar(300)

	-- Add the T-SQL statements to compute the return value here
	SELECT @companyAddress = companyAddress FROM tblCompanyInfo

	-- Return the result of the function
	RETURN @companyAddress

END

GO
/****** Object:  UserDefinedFunction [dbo].[getCompanyName]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 26 Jun 2020
-- =============================================
CREATE FUNCTION [dbo].[getCompanyName] 
(
	@companyId int
)
RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @companyName nvarchar(50)

	-- Add the T-SQL statements to compute the return value here
	SELECT @companyName = companyName FROM tblCompanyInfo

	-- Return the result of the function
	RETURN @companyName

END

GO
/****** Object:  Table [dbo].[cus1]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cus1](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customerId] [varchar](20) NOT NULL,
	[customerSerialId] [int] NOT NULL,
	[customerName] [nvarchar](100) NOT NULL,
	[customerPhone] [nvarchar](15) NOT NULL,
	[customerAddress] [nvarchar](200) NULL,
	[hostId] [int] NOT NULL,
	[zoneId] [int] NOT NULL,
	[assignedUserId] [int] NULL,
	[connFee] [decimal](8, 2) NULL,
	[monthBill] [decimal](8, 2) NULL,
	[othersAmount] [decimal](8, 2) NULL,
	[description] [nvarchar](300) NULL,
	[connMonth] [varchar](20) NULL,
	[connYear] [int] NULL,
	[isDisconnected] [bit] NOT NULL CONSTRAINT [DF_cus1_isDisconnected]  DEFAULT ((0)),
	[disconnectionEffectiveDate] [datetime] NULL,
	[disconnectionRequestId] [int] NULL,
	[isActive] [bit] NOT NULL CONSTRAINT [DF_cus1_isActive]  DEFAULT ((1)),
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCareTaker]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCareTaker](
	[careTakerId] [int] IDENTITY(1,1) NOT NULL,
	[careTakerName] [nvarchar](50) NOT NULL,
	[phoneNo] [varchar](20) NOT NULL,
	[email] [varchar](50) NULL,
	[presentAddress] [nvarchar](200) NULL,
	[permanentAddress] [nvarchar](200) NOT NULL,
	[nid] [varchar](20) NULL,
	[joiningDate] [datetime] NULL,
	[salary] [numeric](10, 2) NULL,
	[isActive] [bit] NOT NULL CONSTRAINT [DF_tblCareTaker_isActive]  DEFAULT ((1)),
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
 CONSTRAINT [PK_tblCareTaker] PRIMARY KEY CLUSTERED 
(
	[careTakerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCompanyInfo]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCompanyInfo](
	[companyId] [int] IDENTITY(1,1) NOT NULL,
	[companyName] [nvarchar](50) NOT NULL,
	[companyAddress] [nvarchar](300) NOT NULL,
 CONSTRAINT [PK_tblCompanyInfo] PRIMARY KEY CLUSTERED 
(
	[companyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblCustomerRequestType]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCustomerRequestType](
	[requestTypeId] [int] IDENTITY(1,1) NOT NULL,
	[requestName] [varchar](20) NOT NULL,
	[requestTypeGroup] [varchar](20) NOT NULL,
	[isForUI] [bit] NOT NULL CONSTRAINT [DF_tblCustomerRequestType_isForUI]  DEFAULT ((1)),
 CONSTRAINT [PK_tblCustomerRequestType] PRIMARY KEY CLUSTERED 
(
	[requestTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCustomerSerial]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCustomerSerial](
	[customerSerialId] [int] IDENTITY(1,1) NOT NULL,
	[customerSerialName] [char](10) NOT NULL,
 CONSTRAINT [PK_tbCustomerSerial] PRIMARY KEY CLUSTERED 
(
	[customerSerialId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDeltPassword]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDeltPassword](
	[ID] [int] NULL,
	[Password] [nvarchar](50) NULL,
	[PageName] [nvarchar](500) NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDesignations]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDesignations](
	[designationId] [int] IDENTITY(1,1) NOT NULL,
	[designationName] [nvarchar](50) NOT NULL,
	[isActive] [bit] NOT NULL CONSTRAINT [DF_tblDesignations_isActive]  DEFAULT ((0)),
 CONSTRAINT [PK_tblDesignation] PRIMARY KEY CLUSTERED 
(
	[designationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDishBillCollection]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDishBillCollection](
	[collectionId] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NOT NULL,
	[connFee] [decimal](8, 2) NOT NULL,
	[reConnFee] [decimal](8, 2) NOT NULL,
	[othersAmount] [decimal](8, 2) NOT NULL,
	[monthlyFee] [decimal](8, 2) NOT NULL,
	[fromMonth] [datetime] NULL,
	[toMonth] [datetime] NULL,
	[shiftingCharge] [decimal](8, 2) NOT NULL,
	[description] [nvarchar](300) NULL,
	[netAmount] [decimal](8, 2) NOT NULL,
	[rcvAmount] [decimal](8, 2) NOT NULL,
	[adjustAdvance] [decimal](8, 2) NOT NULL,
	[discount] [decimal](8, 2) NULL,
	[customerSL] [int] NULL,
	[pageNo] [int] NULL,
	[isAmountCollected] [bit] NOT NULL CONSTRAINT [DF_tblDishBillCollection_isAmountCollected]  DEFAULT ((0)),
	[pageNoDate] [date] NULL,
	[collectionDate] [datetime] NOT NULL,
	[collectionYear] [int] NOT NULL,
	[collectedBy] [int] NOT NULL,
	[receivedBy] [int] NOT NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblDishBillCollection] PRIMARY KEY CLUSTERED 
(
	[collectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_dish_collectedBy_pageNo_customerSL_] UNIQUE NONCLUSTERED 
(
	[pageNo] ASC,
	[customerSL] ASC,
	[receivedBy] ASC,
	[collectionYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDishBillCollectionDeleteHist]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDishBillCollectionDeleteHist](
	[collectionId] [int] NOT NULL,
	[cid] [int] NOT NULL,
	[connFee] [decimal](8, 2) NOT NULL,
	[reConnFee] [decimal](8, 2) NOT NULL,
	[othersAmount] [decimal](8, 2) NOT NULL,
	[monthlyFee] [decimal](8, 2) NOT NULL,
	[fromMonth] [datetime] NULL,
	[toMonth] [datetime] NULL,
	[shiftingCharge] [decimal](8, 2) NOT NULL,
	[description] [nvarchar](300) NULL,
	[netAmount] [decimal](8, 2) NOT NULL,
	[rcvAmount] [decimal](8, 2) NOT NULL,
	[adjustAdvance] [decimal](8, 2) NOT NULL,
	[customerSL] [varchar](20) NULL,
	[pageNo] [varchar](20) NULL,
	[isAmountCollected] [bit] NOT NULL CONSTRAINT [DF_tblDishBillCollectionDeleteHist_isAmountCollected]  DEFAULT ((0)),
	[collectionDate] [datetime] NULL,
	[collectedBy] [int] NULL,
	[receivedBy] [int] NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblDishBillCollectionDeleteHist] PRIMARY KEY CLUSTERED 
(
	[collectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDishBillDetails]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDishBillDetails](
	[billDetailId] [int] IDENTITY(1,1) NOT NULL,
	[billSummaryId] [int] NOT NULL,
	[month] [varchar](20) NOT NULL,
	[yearId] [int] NOT NULL,
	[cid] [int] NOT NULL,
	[billAmount] [decimal](8, 2) NOT NULL,
	[createId] [int] NOT NULL,
	[createDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
	[isClosed] [bit] NOT NULL CONSTRAINT [DF_tblDishBillDetails_isClosed]  DEFAULT ((0)),
	[collectionId] [int] NULL,
 CONSTRAINT [PK_tbDishBillDetails] PRIMARY KEY CLUSTERED 
(
	[billDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDishBillSummary]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDishBillSummary](
	[billSummaryId] [int] IDENTITY(1,1) NOT NULL,
	[isBatch] [bit] NOT NULL,
	[month] [varchar](20) NOT NULL,
	[yearId] [int] NOT NULL,
	[remarks] [varchar](200) NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblDishBillSummarry] PRIMARY KEY CLUSTERED 
(
	[billSummaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDishCustomerBalance]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDishCustomerBalance](
	[customerBalanceId] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NOT NULL,
	[totalDebit] [decimal](8, 2) NOT NULL CONSTRAINT [DF_tblDishCustomerBalance_totalDebit]  DEFAULT ((0)),
	[totalCredit] [decimal](8, 2) NOT NULL CONSTRAINT [DF_tblDishCustomerBalance_totalCredit]  DEFAULT ((0)),
	[totalDiscount] [decimal](8, 0) NOT NULL CONSTRAINT [DF_tblDishCustomerBalance_totalDiscount]  DEFAULT ((0)),
	[totalBalance] [decimal](8, 2) NOT NULL CONSTRAINT [DF_tblDishCustomerBalance_totalBalance]  DEFAULT ((0)),
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
 CONSTRAINT [PK_tblDishCustomerBalance] PRIMARY KEY CLUSTERED 
(
	[customerBalanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDishCustomerRequest]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDishCustomerRequest](
	[requestId] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NOT NULL,
	[requestTypeId] [int] NOT NULL,
	[requestCharge] [decimal](8, 2) NOT NULL,
	[updatedMontlyBill] [decimal](8, 2) NULL,
	[remarks] [nvarchar](300) NULL,
	[hostId] [int] NULL,
	[zoneId] [int] NULL,
	[customerAddress] [nvarchar](200) NULL,
	[assignedUserId] [int] NULL,
	[requestMonth] [varchar](20) NULL,
	[requestYear] [int] NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
	[isClosed] [bit] NOT NULL CONSTRAINT [DF_tblDishCustomerRequest_isClosed]  DEFAULT ((0)),
	[collectionId] [int] NULL,
 CONSTRAINT [PK_tblDishCustomerRequest] PRIMARY KEY CLUSTERED 
(
	[requestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDishCustomerRequestHistory]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDishCustomerRequestHistory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NOT NULL,
	[requestId] [int] NOT NULL,
	[customerId] [varchar](20) NOT NULL,
	[customerSerialId] [int] NOT NULL,
	[customerName] [nvarchar](100) NOT NULL,
	[customerPhone] [nvarchar](15) NOT NULL,
	[customerAddress] [nvarchar](200) NULL,
	[hostId] [int] NOT NULL,
	[zoneId] [int] NOT NULL,
	[assignedUserId] [int] NULL,
	[connFee] [decimal](8, 2) NULL,
	[monthBill] [decimal](8, 2) NULL,
	[othersAmount] [decimal](8, 2) NULL,
	[description] [nvarchar](300) NULL,
	[connMonth] [varchar](20) NULL,
	[connYear] [int] NULL,
	[isActive] [bit] NOT NULL,
	[isDisconnected] [bit] NOT NULL,
	[disconnectionEffectiveDate] [datetime] NULL,
	[disconnectionRequestId] [int] NULL,
 CONSTRAINT [PK_tblDishCustomerRequestHistory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDishCustomers]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDishCustomers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customerId] [varchar](20) NOT NULL,
	[customerSerialId] [int] NOT NULL,
	[customerName] [nvarchar](100) NOT NULL,
	[customerPhone] [nvarchar](15) NOT NULL,
	[customerAddress] [nvarchar](200) NULL,
	[hostId] [int] NOT NULL,
	[zoneId] [int] NOT NULL,
	[assignedUserId] [int] NULL,
	[connFee] [decimal](8, 2) NULL,
	[monthBill] [decimal](8, 2) NULL,
	[othersAmount] [decimal](8, 2) NULL,
	[description] [nvarchar](300) NULL,
	[connMonth] [varchar](20) NULL,
	[connYear] [int] NULL,
	[isDisconnected] [bit] NOT NULL CONSTRAINT [DF_tblDishCustomers_isDisconnected]  DEFAULT ((0)),
	[disconnectionEffectiveDate] [datetime] NULL,
	[disconnectionRequestId] [int] NULL,
	[isActive] [bit] NOT NULL CONSTRAINT [DF_tblCableCustomers_isActive]  DEFAULT ((1)),
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
 CONSTRAINT [PK_tblDishCustomers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_tblDishCustomers_cid_sid] UNIQUE NONCLUSTERED 
(
	[customerId] ASC,
	[customerSerialId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_tblDishCustomers_phoneNumber] UNIQUE NONCLUSTERED 
(
	[customerPhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDishTransactionMaster]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDishTransactionMaster](
	[transactionMasterId] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NOT NULL,
	[transactionType] [varchar](5) NOT NULL,
	[transactionAmount] [decimal](8, 2) NOT NULL,
	[customerRequestId] [int] NULL,
	[billDetailId] [int] NULL,
	[isConFee] [bit] NOT NULL CONSTRAINT [DF_tblDishTransactionMaster_isConFee]  DEFAULT ((0)),
	[isOtherFee] [bit] NOT NULL CONSTRAINT [DF_tblDishTransactionMaster_isOtherFee]  DEFAULT ((0)),
	[transactionMonth] [varchar](20) NULL,
	[transactionYear] [int] NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
	[isClosed] [bit] NOT NULL CONSTRAINT [DF_tblDishTransactionMaster_isClosed]  DEFAULT ((0)),
	[transactionDate] [datetime] NULL,
	[collectionId] [int] NULL,
 CONSTRAINT [PK_tblDishTransactionMaster] PRIMARY KEY CLUSTERED 
(
	[transactionMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblHosts]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHosts](
	[hostId] [int] IDENTITY(1,1) NOT NULL,
	[hostName] [nvarchar](50) NOT NULL,
	[hostAddress] [nvarchar](200) NOT NULL,
	[hostPhone] [nvarchar](15) NOT NULL,
	[isActive] [bit] NOT NULL CONSTRAINT [DF_tblHosts_isActive]  DEFAULT ((1)),
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
 CONSTRAINT [PK_tblHosts] PRIMARY KEY CLUSTERED 
(
	[hostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_tblHosts] UNIQUE NONCLUSTERED 
(
	[hostName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblHouse]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHouse](
	[houseId] [int] IDENTITY(1,1) NOT NULL,
	[houseName] [nvarchar](20) NOT NULL,
	[projectId] [int] NOT NULL,
	[houseType] [nvarchar](20) NOT NULL,
	[monthlyRent] [decimal](8, 2) NOT NULL,
	[description] [nvarchar](300) NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[houseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [employees_unique] UNIQUE NONCLUSTERED 
(
	[projectId] ASC,
	[houseName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblHouse1]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHouse1](
	[houseId] [int] IDENTITY(1,1) NOT NULL,
	[houseName] [nvarchar](20) NOT NULL,
	[projectId] [int] NOT NULL,
	[houseType] [nvarchar](20) NOT NULL,
	[monthlyRent] [decimal](8, 2) NOT NULL,
	[description] [nvarchar](300) NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
 CONSTRAINT [PK_tblHouse] PRIMARY KEY CLUSTERED 
(
	[houseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [ConstraintName] UNIQUE NONCLUSTERED 
(
	[houseName] ASC,
	[projectId] ASC,
	[houseType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblInternetBillCollection]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInternetBillCollection](
	[collectionId] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NOT NULL,
	[connFee] [decimal](8, 2) NOT NULL,
	[reConnFee] [decimal](8, 2) NOT NULL,
	[othersAmount] [decimal](8, 2) NOT NULL,
	[monthlyFee] [decimal](8, 2) NOT NULL,
	[fromMonth] [datetime] NULL,
	[toMonth] [datetime] NULL,
	[shiftingCharge] [decimal](8, 2) NOT NULL,
	[description] [nvarchar](300) NULL,
	[netAmount] [decimal](8, 2) NOT NULL,
	[rcvAmount] [decimal](8, 2) NOT NULL,
	[adjustAdvance] [decimal](8, 2) NOT NULL,
	[discount] [decimal](8, 2) NULL,
	[customerSL] [int] NULL,
	[pageNo] [int] NULL,
	[isAmountCollected] [bit] NOT NULL,
	[pageNoDate] [date] NULL,
	[collectionDate] [datetime] NOT NULL,
	[collectionYear] [int] NOT NULL,
	[collectedBy] [int] NOT NULL,
	[receivedBy] [int] NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblInternetBillCollection] PRIMARY KEY CLUSTERED 
(
	[collectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_internett_collectedBy_pageNo_customerSL_] UNIQUE NONCLUSTERED 
(
	[pageNo] ASC,
	[customerSL] ASC,
	[receivedBy] ASC,
	[collectionYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblInternetBillCollectionDeleteHist]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblInternetBillCollectionDeleteHist](
	[collectionId] [int] NOT NULL,
	[cid] [int] NOT NULL,
	[connFee] [decimal](8, 2) NOT NULL,
	[reConnFee] [decimal](8, 2) NOT NULL,
	[othersAmount] [decimal](8, 2) NOT NULL,
	[monthlyFee] [decimal](8, 2) NOT NULL,
	[fromMonth] [datetime] NULL,
	[toMonth] [datetime] NULL,
	[shiftingCharge] [decimal](8, 2) NOT NULL,
	[description] [nvarchar](300) NULL,
	[netAmount] [decimal](8, 2) NOT NULL,
	[rcvAmount] [decimal](8, 2) NOT NULL,
	[adjustAdvance] [decimal](8, 2) NOT NULL,
	[customerSL] [varchar](20) NULL,
	[pageNo] [varchar](20) NULL,
	[isAmountCollected] [bit] NOT NULL,
	[collectionDate] [datetime] NULL,
	[collectedBy] [int] NULL,
	[receivedBy] [int] NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblInternetBillCollectionDeleteHist] PRIMARY KEY CLUSTERED 
(
	[collectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblInternetBillDetails]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblInternetBillDetails](
	[billDetailId] [int] IDENTITY(1,1) NOT NULL,
	[billSummaryId] [int] NOT NULL,
	[month] [varchar](20) NOT NULL,
	[yearId] [int] NOT NULL,
	[cid] [int] NOT NULL,
	[billAmount] [decimal](8, 2) NOT NULL,
	[createId] [int] NOT NULL,
	[createDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
	[isClosed] [bit] NOT NULL,
	[collectionId] [int] NULL,
 CONSTRAINT [PK_tblInternetBillDetails] PRIMARY KEY CLUSTERED 
(
	[billDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblInternetBillSummary]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblInternetBillSummary](
	[billSummaryId] [int] IDENTITY(1,1) NOT NULL,
	[isBatch] [bit] NOT NULL,
	[month] [varchar](20) NOT NULL,
	[yearId] [int] NOT NULL,
	[remarks] [varchar](200) NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblInternetBillSummarry] PRIMARY KEY CLUSTERED 
(
	[billSummaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblInternetCustomerBalance]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInternetCustomerBalance](
	[customerBalanceId] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NOT NULL,
	[totalDebit] [decimal](8, 2) NOT NULL CONSTRAINT [DF_tblInternetCustomerBalance_totalDebit]  DEFAULT ((0)),
	[totalCredit] [decimal](8, 2) NOT NULL CONSTRAINT [DF_tblInternetCustomerBalance_totalCredit]  DEFAULT ((0)),
	[totalBalance] [decimal](8, 2) NOT NULL CONSTRAINT [DF_tblInternetCustomerBalance_totalBalance]  DEFAULT ((0)),
	[totalDiscount] [decimal](8, 2) NULL CONSTRAINT [DF_tblInternetCustomerBalance_totalDiscount]  DEFAULT ((0)),
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
 CONSTRAINT [PK_tblInternetCustomerBalance] PRIMARY KEY CLUSTERED 
(
	[customerBalanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblInternetCustomerRequest]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblInternetCustomerRequest](
	[requestId] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NOT NULL,
	[requestTypeId] [int] NOT NULL,
	[requestCharge] [decimal](8, 2) NOT NULL,
	[updatedMontlyBill] [decimal](8, 2) NULL,
	[requiredNet] [varchar](20) NULL,
	[remarks] [nvarchar](300) NULL,
	[hostId] [int] NULL,
	[zoneId] [int] NULL,
	[customerAddress] [nvarchar](200) NULL,
	[assignedUserId] [int] NULL,
	[requestMonth] [varchar](20) NULL,
	[requestYear] [int] NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
	[isClosed] [bit] NOT NULL CONSTRAINT [DF_tblInternetCustomerRequest_isClosed]  DEFAULT ((0)),
	[collectionId] [int] NULL,
 CONSTRAINT [PK_tblInternetCustomerRequest] PRIMARY KEY CLUSTERED 
(
	[requestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblInternetCustomerRequestHistory]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblInternetCustomerRequestHistory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NOT NULL,
	[requestId] [int] NOT NULL,
	[customerId] [varchar](20) NOT NULL,
	[customerSerialId] [int] NOT NULL,
	[customerName] [nvarchar](100) NOT NULL,
	[customerPhone] [nvarchar](15) NOT NULL,
	[customerAddress] [nvarchar](200) NULL,
	[requiredNet] [varchar](20) NULL,
	[ipAddress] [varchar](20) NULL,
	[hostId] [int] NOT NULL,
	[zoneId] [int] NOT NULL,
	[assignedUserId] [int] NULL,
	[connFee] [decimal](8, 2) NULL,
	[monthBill] [decimal](8, 2) NULL,
	[othersAmount] [decimal](8, 2) NULL,
	[description] [nvarchar](300) NULL,
	[connMonth] [varchar](20) NULL,
	[connYear] [int] NULL,
	[isActive] [bit] NOT NULL,
	[isDisconnected] [bit] NOT NULL,
	[disconnectionEffectiveDate] [datetime] NULL,
	[disconnectionRequestId] [int] NULL,
 CONSTRAINT [PK_tblInternetCustomerRequestHistory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblInternetCustomers]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblInternetCustomers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customerId] [varchar](20) NOT NULL,
	[customerSerialId] [int] NOT NULL,
	[customerName] [nvarchar](100) NOT NULL,
	[customerPhone] [nvarchar](15) NOT NULL,
	[customerAddress] [nvarchar](200) NULL,
	[requiredNet] [varchar](20) NULL,
	[ipAddress] [varchar](20) NULL,
	[hostId] [int] NOT NULL,
	[zoneId] [int] NOT NULL,
	[assignedUserId] [int] NULL,
	[connFee] [decimal](8, 2) NULL,
	[monthBill] [decimal](8, 2) NULL,
	[othersAmount] [decimal](8, 2) NULL,
	[description] [nvarchar](300) NULL,
	[connMonth] [varchar](20) NULL,
	[connYear] [int] NULL,
	[isActive] [bit] NOT NULL,
	[isDisconnected] [bit] NOT NULL CONSTRAINT [DF_tblInternetCustomers_isDisconnected]  DEFAULT ((0)),
	[disconnectionEffectiveDate] [datetime] NULL,
	[disconnectionRequestId] [int] NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
 CONSTRAINT [PK_tblInternetCustomers_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_tblInternetCustomers_cid_sid] UNIQUE NONCLUSTERED 
(
	[customerId] ASC,
	[customerSerialId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_tblInternetCustomers_phoneNumber] UNIQUE NONCLUSTERED 
(
	[customerPhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblInternetTransactionMaster]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblInternetTransactionMaster](
	[transactionMasterId] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NOT NULL,
	[transactionType] [varchar](5) NOT NULL,
	[transactionAmount] [decimal](8, 2) NOT NULL,
	[customerRequestId] [int] NULL,
	[billDetailId] [int] NULL,
	[isConFee] [bit] NOT NULL,
	[isOtherFee] [bit] NOT NULL,
	[transactionMonth] [varchar](20) NULL,
	[transactionYear] [int] NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
	[isClosed] [bit] NOT NULL,
	[transactionDate] [datetime] NULL,
	[collectionId] [int] NULL,
 CONSTRAINT [PK_tblTransactionMaster] PRIMARY KEY CLUSTERED 
(
	[transactionMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblLordInfo]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblLordInfo](
	[lordId] [int] IDENTITY(1,1) NOT NULL,
	[ownerName] [nvarchar](50) NOT NULL,
	[companyName] [nvarchar](50) NOT NULL,
	[companyAddress] [nvarchar](200) NOT NULL,
	[phoneNo] [varchar](20) NULL,
	[email] [varchar](50) NULL,
	[nid] [varchar](20) NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
 CONSTRAINT [PK_tblLordInfo] PRIMARY KEY CLUSTERED 
(
	[lordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPages]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPages](
	[pageId] [int] IDENTITY(1,1) NOT NULL,
	[pageName] [nvarchar](50) NOT NULL,
	[pageUrl] [nvarchar](300) NOT NULL,
	[pageType] [varchar](20) NOT NULL,
	[pageSubType] [varchar](20) NULL,
	[isActive] [bit] NOT NULL,
	[isPageForAdmin] [bit] NOT NULL,
	[orderId] [int] NULL,
 CONSTRAINT [PK_tblPages] PRIMARY KEY CLUSTERED 
(
	[pageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblProject]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblProject](
	[projectId] [int] IDENTITY(1,1) NOT NULL,
	[projectName] [nvarchar](50) NOT NULL,
	[projectType] [varchar](30) NOT NULL,
	[projectAddress] [nvarchar](300) NOT NULL,
	[projectDescription] [nvarchar](300) NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
 CONSTRAINT [PK_tblProject] PRIMARY KEY CLUSTERED 
(
	[projectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_tblProject] UNIQUE NONCLUSTERED 
(
	[projectName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblProjectCareTaker]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProjectCareTaker](
	[projectId] [int] NOT NULL,
	[careTakerId] [int] NOT NULL,
 CONSTRAINT [PK_tblProjectCareTaker] PRIMARY KEY CLUSTERED 
(
	[projectId] ASC,
	[careTakerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUserPage]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUserPage](
	[userId] [int] NOT NULL,
	[pageId] [int] NOT NULL,
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[userId] [int] IDENTITY(1,1) NOT NULL,
	[password] [nvarchar](20) NOT NULL,
	[userName] [nvarchar](100) NOT NULL,
	[email] [nvarchar](100) NULL,
	[phoneNumber] [nvarchar](15) NULL,
	[address] [nvarchar](300) NULL,
	[isAdmin] [bit] NOT NULL CONSTRAINT [DF_tblUser_isAdmin]  DEFAULT ((0)),
	[isCableUser] [bit] NOT NULL CONSTRAINT [DF_tblUser_isCableUser]  DEFAULT ((0)),
	[isHouseRentUser] [bit] NOT NULL CONSTRAINT [DF_tblUser_isHouseRentUser]  DEFAULT ((0)),
	[designationId] [int] NOT NULL,
	[userFullName] [nvarchar](100) NOT NULL,
	[isActive] [bit] NOT NULL,
	[isManagement] [bit] NOT NULL CONSTRAINT [DF_tblUsers_isManagement]  DEFAULT ((0)),
	[createdBy] [int] NULL,
	[createdDate] [datetime] NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_tblUser] UNIQUE NONCLUSTERED 
(
	[userName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblYear]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblYear](
	[yearId] [int] IDENTITY(1,1) NOT NULL,
	[yearName] [decimal](4, 0) NOT NULL,
 CONSTRAINT [PK_tblYear] PRIMARY KEY CLUSTERED 
(
	[yearId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblZones]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblZones](
	[zoneId] [int] IDENTITY(1,1) NOT NULL,
	[zoneName] [nvarchar](50) NOT NULL,
	[isActive] [bit] NULL CONSTRAINT [DF_tblZones_isActive]  DEFAULT ((1)),
	[createdBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[editedBy] [int] NULL,
	[editedDate] [datetime] NULL,
 CONSTRAINT [PK_tblZones] PRIMARY KEY CLUSTERED 
(
	[zoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_tblZones] UNIQUE NONCLUSTERED 
(
	[zoneName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[GetMonthListBetweenDates]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 11-Aug-2020
-- =============================================
CREATE FUNCTION [dbo].[GetMonthListBetweenDates]
(
	@startDate DATE
    ,@endDate DATE
)
RETURNS TABLE
	AS RETURN
		 WITH CTE AS
		(
			 SELECT CONVERT(DATE, @startDate) AS Dates
  
			 UNION ALL
  
			 SELECT DATEADD(MONTH, 1, Dates)
			 FROM CTE
			 WHERE CONVERT(DATE, Dates) <= CONVERT(DATE, @endDate)
		 )
 
		SELECT DATENAME(MONTH,Dates) as betweenMonthName,y.yearId betweenYearName FROM CTE
		INNER JOIN tblYear y on DATENAME(YEAR, CTE.Dates) = y.yearName

GO
ALTER TABLE [dbo].[tblInternetBillCollection] ADD  CONSTRAINT [DF_tblInternetBillCollection_isAmountCollected]  DEFAULT ((0)) FOR [isAmountCollected]
GO
ALTER TABLE [dbo].[tblInternetBillCollectionDeleteHist] ADD  CONSTRAINT [DF_tblInternetBillCollectionDeleteHist_isAmountCollected]  DEFAULT ((0)) FOR [isAmountCollected]
GO
ALTER TABLE [dbo].[tblInternetBillDetails] ADD  CONSTRAINT [DF_tblInternetBillDetails_isClosed]  DEFAULT ((0)) FOR [isClosed]
GO
ALTER TABLE [dbo].[tblInternetTransactionMaster] ADD  CONSTRAINT [DF_tblInternetTransactionMaster_isConFee]  DEFAULT ((0)) FOR [isConFee]
GO
ALTER TABLE [dbo].[tblInternetTransactionMaster] ADD  CONSTRAINT [DF_tblInternetTransactionMaster_isOtherFee]  DEFAULT ((0)) FOR [isOtherFee]
GO
ALTER TABLE [dbo].[tblInternetTransactionMaster] ADD  CONSTRAINT [DF_tblInternetTransactionMaster_isClosed]  DEFAULT ((0)) FOR [isClosed]
GO
/****** Object:  StoredProcedure [dbo].[dsp_deleteDishBill]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 17th May 2020
-- =============================================
CREATE PROCEDURE [dbo].[dsp_deleteDishBill]
	@billDetailId int,
	@createdBy int
AS
BEGIN
	DECLARE @billAmount decimal(8,2);
	DECLARE @cid int;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	DECLARE @isClosed bit;
	SET NOCOUNT ON;

	BEGIN TRY
	BEGIN TRANSACTION tranc;

		SELECT @billAmount = bd.billAmount, @cid = bd.cid, @isClosed = bd.isClosed from tblDishBillDetails bd
		where bd.billDetailId = @billDetailId;

		IF(@isClosed = 0)
		BEGIN
			UPDATE tblDishCustomerBalance
			SET totalDebit = totalDebit - @billAmount,
			totalBalance = totalBalance + @billAmount,
			editedBy = @createdBy,
			editedDate = GETDATE()
			WHERE cid = @cid

			DELETE FROM tblDishTransactionMaster
			where transactionType = 'Dr.'
			and billDetailId = @billDetailId

			DELETE FROM tblDishBillDetails
			where billDetailId = @billDetailId

		END
		ELSE
		BEGIN
			RAISERROR('This data has already been processed, can not be deleted!!',16,1)
		END

		COMMIT TRANSACTION trac;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[dsp_deleteDishBillCollection]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 5 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[dsp_deleteDishBillCollection]
	@collectionId int,
	@createdBy int
AS
BEGIN
	DECLARE @billCharge decimal(8,2);
	DECLARE @discountCharge decimal(8,2);
	DECLARE @cid int;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	

	SELECT @billCharge = bc.rcvAmount,@cid = bc.cid,@discountCharge = discount from tblDishBillCollection bc
	where bc.collectionId = @collectionId



	SET NOCOUNT ON;

	BEGIN TRY
	BEGIN TRANSACTION tranc;
		
		--update bill details---
		update tblDishBillDetails
		set collectionId = null,
		isClosed = 0,
		editedBy = @createdBy,
		editedDate = GETDATE()
		where collectionId = @collectionId
		--update bill details ends---

		--update request---
		update tblDishCustomerRequest
		set collectionId = null,
		isClosed = 0,
		editedBy = @createdBy,
		editedDate = GETDATE()
		where collectionId = @collectionId
		--update request ends---

		--update transaction master debit row--
		update tblDishTransactionMaster
		set isClosed = 0,
		collectionId = @collectionId
		where collectionId = @collectionId and transactionType = 'Dr.'
		--update transaction master debit row ends-- 

		--delete credit row from transaction master--
		delete tblDishTransactionMaster
		where collectionId = @collectionId and transactionType = 'Cr.'
		--delete credit row from transaction master ends--

		--update customer balance--
		update tblDishCustomerBalance
		set totalCredit = totalCredit - @billCharge,
		totalBalance = totalBalance - @billCharge - @discountCharge,
		totalDiscount = totalDiscount - @discountCharge
		where cid = @cid
		--update customer balance ends--

		--insert into history table--
		INSERT INTO tblDishBillCollectionDeleteHist
           ([collectionId]
		   ,[cid]
           ,[connFee]
           ,[reConnFee]
           ,[othersAmount]
           ,[monthlyFee]
           ,[fromMonth]
           ,[toMonth]
           ,[shiftingCharge]
           ,[description]
           ,[netAmount]
           ,[rcvAmount]
           ,[adjustAdvance]
           ,[customerSL]
           ,[pageNo]
		   ,[isAmountCollected]
		   ,[collectionDate]
           ,[collectedBy]
           ,[receivedBy]
           ,[createdBy]
           ,[createdDate])
     SELECT 
            [collectionId]
		   ,[cid]
           ,[connFee]
           ,[reConnFee]
           ,[othersAmount]
           ,[monthlyFee]
           ,[fromMonth]
           ,[toMonth]
           ,[shiftingCharge]
           ,[description]
           ,[netAmount]
           ,[rcvAmount]
           ,[adjustAdvance]
           ,[customerSL]
           ,[pageNo]
		   ,[isAmountCollected]
		   ,[collectionDate]
           ,[collectedBy]
           ,[receivedBy]
           ,@createdBy
           ,getdate()
	 FROM tblDishBillCollection where collectionId = @collectionId
	 --insert into history table ends--

	 --delete from main table--
	 delete tblDishBillCollection
	 where collectionId = @collectionId
	 --delete from main table ends--


		COMMIT TRANSACTION trac;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[dsp_deleteDishCustomerRequest]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 16th May 2020
-- =============================================
CREATE PROCEDURE [dbo].[dsp_deleteDishCustomerRequest]
	@requestId int,
	@createdBy int
AS
BEGIN
	DECLARE @requestTypeName varchar(20);
	DECLARE @requestCharge decimal(8,2);
	DECLARE @cid int;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	DECLARE @isClosed bit;

	SELECT @requestTypeName = crt.requestName from tblDishCustomerRequest cr
	inner join tblCustomerRequestType crt on cr.requestTypeId = crt.requestTypeId
	where cr.requestId = @requestId

	SELECT @cid = cr.cid,@requestCharge = cr.requestCharge,@isClosed = cr.isClosed from tblDishCustomerRequest cr
	where cr.requestId = @requestId

	SET NOCOUNT ON;

	BEGIN TRY
	BEGIN TRANSACTION tranc;
		IF(@isClosed = 0)
		BEGIN
			IF @requestTypeName = 'Discontinue'
			BEGIN 
				UPDATE tblDishCustomers
				SET isDisconnected = 0,
				disconnectionRequestId = null,
				disconnectionEffectiveDate = null,
				editedBy = @createdBy,
				editedDate = GETDATE()
				WHERE id = @cid
			END
			IF @requestTypeName = 'Reconnect' 
			BEGIN
				UPDATE ic  
				SET ic.isDisconnected = icr.isDisconnected,
				ic.disconnectionEffectiveDate = icr.disconnectionEffectiveDate,
				ic.disconnectionRequestId = icr.disconnectionRequestId,
				ic.editedBy = @createdBy,
				ic.editedDate = GETDATE()
				FROM tblDishCustomers as ic
				INNER JOIN tblDishCustomerRequestHistory icr on ic.id = icr.cid and icr.requestId = @requestId
				WHERE ic.id = @cid
			
			END
			IF @requestTypeName = 'Shifting' 
			BEGIN
				UPDATE ic  
				SET ic.hostId = icr.hostId,
				ic.zoneId = icr.zoneId,
				ic.customerAddress = icr.customerAddress,
				ic.assignedUserId = icr.assignedUserId,
				ic.editedBy = @createdBy,
				ic.editedDate = GETDATE()
				FROM tblDishCustomers as ic
				INNER JOIN tblDishCustomerRequestHistory icr on ic.id = icr.cid and icr.requestId = @requestId
				WHERE ic.id = @cid
			
			END
			IF @requestTypeName = 'Bill Upgrade'
			BEGIN
				UPDATE ic  
				SET ic.monthBill = icr.monthBill,
				ic.editedBy = @createdBy,
				ic.editedDate = GETDATE()
				FROM tblDishCustomers as ic
				INNER JOIN tblDishCustomerRequestHistory icr on ic.id = icr.cid and icr.requestId = @requestId
				WHERE ic.id = @cid
			
			END
			IF @requestCharge > 0
			BEGIN
				DELETE FROM tblDishTransactionMaster
				WHERE customerRequestId = @requestId
				and cid = @cid
				and transactionType = 'Dr.'

				UPDATE tblDishCustomerBalance
				SET totalDebit = totalDebit - @requestCharge,
				totalBalance = totalBalance + @requestCharge
				WHERE cid = @cid
			END

			DELETE FROM tblDishCustomerRequest
			WHERE requestId = @requestId;
		END
		ELSE
		BEGIN
			RAISERROR('This data is already processed, can not be deleted!!',16,1)
		END

		COMMIT TRANSACTION trac;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[dsp_deleteDishPrimaryBill]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 1st Oct 2020
-- =============================================
CREATE PROCEDURE [dbo].[dsp_deleteDishPrimaryBill]
	@cid int,
	@connFee numeric(8,2),
	@monthlyBill numeric(8,2),
	@connMonth varchar(20),
	@connYear int,	
	@createdBy int
AS
BEGIN
	DECLARE @previousFee numeric(8,2) = 0;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	
	SET NOCOUNT ON;

	BEGIN TRY
	BEGIN TRANSACTION tranc;
----------------validation starts---------------------
	IF EXISTS(SELECT * FROM tblDishTransactionMaster WHERE cid = @cid and isConFee = 1 and transactionType = 'Dr.' and isClosed = 1)
	BEGIN
		RAISERROR('Connection Fee has already been collected, can not be Modified!!',16,1)
	END
	IF EXISTS(SELECT * FROM tblDishTransactionMaster WHERE cid = @cid and billDetailId is not null and transactionType = 'Dr.' and isClosed = 1)
	BEGIN
		RAISERROR('Monthly Fee has already been collected, can not be Modified!!',16,1)
	END
---------------validation ends------------------------------


SELECT @previousFee = SUM(transactionAmount) FROM tblDishTransactionMaster WHERE cid = @cid and (isConFee = 1 or billDetailId is not null) and transactionType = 'Dr.' and isClosed = 0

--------------delete from transaction table----------------
	
	delete from tblDishTransactionMaster
	where (isConFee = 1 or billDetailId is not null)
	and cid = @cid
	and isClosed = 0
	and transactionType = 'Dr.'

	delete from tblDishBillDetails
	where cid = @cid
	and isClosed = 0

------------delete from transaction table ends--------------


--------------update customer table-------------------
	update tblDishCustomers
	set monthBill = @monthlyBill,
	connFee = @connFee,
	connMonth = @connMonth,
	connYear = @connYear,
	editedBy = @createdBy,
	editedDate = GETDATE()
	where id = @cid
--------------update customer table ends-------------------

-----------update customer Balance------------------------

	UPDATE tblDishCustomerBalance
	SET totalDebit = totalDebit - @previousFee,
	totalBalance = totalBalance - @previousFee,
	editedBy = @createdBy,
	editedDate = GETDATE()
	WHERE cid = @cid
-----------update customer Balance ends------------------------


----------Insert conn Fee in transaction Master-----------------
IF @connFee > 0
BEGIN
	INSERT INTO [dbo].[tblDishTransactionMaster]
				([cid]
				,[transactionType]
				,[transactionAmount]
				,[isConFee]
				,[transactionMonth]
				,[transactionYear]
				,[createdBy]
				,[createdDate]
				)
			VALUES
				(@cid
				,'Dr.'
				,@connFee
				,1
				,@connMonth
				,@connYear
				,@createdBy
				,GETDATE()
				)
	INSERT INTO [dbo].[tblDishCustomerBalance]
				([cid]
				,[totalDebit]
				,[totalCredit]
				,[totalBalance]
				,[createdBy]
				,[createdDate]
				)
				VALUES
				(@cid
				,@connFee
				,0
				,0-(@connFee)
				,@createdBy
				,GETDATE())
END;

----------Insert conn Fee in transaction Master ends-----------------

----------Process Monthly bill---------------------------------------
IF @monthlyBill > 0
BEGIN
	DECLARE @connYearName varchar(20);
	SELECT @connYearName =  y.yearName FROM tblDishCustomers c
			INNER JOIN tblYear y on c.connYear = y.yearId
			WHERE id = @cid;

			DECLARE @betweenMonthName varchar(20);
			DECLARE @betweenYearName int;
			DECLARE billGenCursor CURSOR 
			FOR Select betweenMonthName,betweenYearName from GetMonthListBetweenDates('01-'+@connMonth+'-' +CAST (@connYearName as varchar),DATEADD(month, -1, getdate()))

			OPEN billGenCursor
			FETCH NEXT FROM billGenCursor INTO
				@betweenMonthName
			   ,@betweenYearName
			WHILE @@FETCH_STATUS = 0
			BEGIN
				print @betweenMonthName
				print @betweenYearName
				EXEC isp_DishCustomerBillGenerate @cid,0,@betweenMonthName,@betweenYearName,'Generated While Customer Setup',@createdBy
				FETCH NEXT FROM billGenCursor INTO
				@betweenMonthName
			   ,@betweenYearName 
			END
			CLOSE billGenCursor;
			DEALLOCATE billGenCursor;
END

----------process monthly bill ends-----------------------------------
	
	COMMIT TRANSACTION trac;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END


GO
/****** Object:  StoredProcedure [dbo].[dsp_deleteInternetBill]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 15th May 2020
-- =============================================
CREATE PROCEDURE [dbo].[dsp_deleteInternetBill]
	@billDetailId int,
	@createdBy int
AS
BEGIN
	DECLARE @billAmount decimal(8,2);
	DECLARE @cid int;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	DECLARE @isClosed bit;
	SET NOCOUNT ON;

	BEGIN TRY
	BEGIN TRANSACTION tranc;

		SELECT @billAmount = bd.billAmount, @cid = bd.cid , @isClosed = bd.isClosed from tblInternetBillDetails bd
		where bd.billDetailId = @billDetailId;

		IF(@isClosed = 0)
		BEGIN
			UPDATE tblInternetCustomerBalance
			SET totalDebit = totalDebit - @billAmount,
			totalBalance = totalBalance + @billAmount,
			editedBy = @createdBy,
			editedDate = GETDATE()
			WHERE cid = @cid

			DELETE FROM tblInternetTransactionMaster
			where transactionType = 'Dr.'
			and billDetailId = @billDetailId

			DELETE FROM tblInternetBillDetails
			where billDetailId = @billDetailId
		END
		ELSE
		BEGIN
			RAISERROR('This data has already been processed, can not be deleted!!',16,1)
		END

		COMMIT TRANSACTION trac;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[dsp_deleteInternetBillCollection]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 5 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[dsp_deleteInternetBillCollection]
	@collectionId int,
	@createdBy int
AS
BEGIN
	DECLARE @billCharge decimal(8,2);
	DECLARE @discountCharge decimal(8,2);
	DECLARE @cid int;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	

	SELECT @billCharge = bc.rcvAmount,@cid = bc.cid,@discountCharge = discount from tblInternetBillCollection bc
	where bc.collectionId = @collectionId



	SET NOCOUNT ON;

	BEGIN TRY
	BEGIN TRANSACTION tranc;
		
		--update bill details---
		update tblInternetBillDetails
		set collectionId = null,
		isClosed = 0,
		editedBy = @createdBy,
		editedDate = GETDATE()
		where collectionId = @collectionId
		--update bill details ends---

		--update request---
		update tblInternetCustomerRequest
		set collectionId = null,
		isClosed = 0,
		editedBy = @createdBy,
		editedDate = GETDATE()
		where collectionId = @collectionId
		--update request ends---

		--update transaction master debit row--
		update tblInternetTransactionMaster
		set isClosed = 0,
		collectionId = @collectionId
		where collectionId = @collectionId and transactionType = 'Dr.'
		--update transaction master debit row ends-- 

		--delete credit row from transaction master--
		delete tblInternetTransactionMaster
		where collectionId = @collectionId and transactionType = 'Cr.'
		--delete credit row from transaction master ends--

		--update customer balance--
		update tblInternetCustomerBalance
		set totalCredit = totalCredit - @billCharge,
		totalBalance = totalBalance - @billCharge - @discountCharge,
		totalDiscount = totalDiscount - @discountCharge
		where cid = @cid
		--update customer balance ends--

		--insert into history table--
		INSERT INTO tblInternetBillCollectionDeleteHist
           ([collectionId]
		   ,[cid]
           ,[connFee]
           ,[reConnFee]
           ,[othersAmount]
           ,[monthlyFee]
           ,[fromMonth]
           ,[toMonth]
           ,[shiftingCharge]
           ,[description]
           ,[netAmount]
           ,[rcvAmount]
           ,[adjustAdvance]
           ,[customerSL]
           ,[pageNo]
		   ,[isAmountCollected]
		   ,[collectionDate]
           ,[collectedBy]
           ,[receivedBy]
           ,[createdBy]
           ,[createdDate])
     SELECT 
            [collectionId]
		   ,[cid]
           ,[connFee]
           ,[reConnFee]
           ,[othersAmount]
           ,[monthlyFee]
           ,[fromMonth]
           ,[toMonth]
           ,[shiftingCharge]
           ,[description]
           ,[netAmount]
           ,[rcvAmount]
           ,[adjustAdvance]
           ,[customerSL]
           ,[pageNo]
		   ,[isAmountCollected]
		   ,[collectionDate]
           ,[collectedBy]
           ,[receivedBy]
           ,@createdBy
           ,getdate()
	 FROM tblInternetBillCollection where collectionId = @collectionId
	 --insert into history table ends--

	 --delete from main table--
	 delete tblInternetBillCollection
	 where collectionId = @collectionId
	 --delete from main table ends--


		COMMIT TRANSACTION trac;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[dsp_deleteInternetCustomerRequest]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 12th May 2020
-- =============================================
CREATE PROCEDURE [dbo].[dsp_deleteInternetCustomerRequest]
	@requestId int,
	@createdBy int
AS
BEGIN
	DECLARE @requestTypeName varchar(20);
	DECLARE @requestCharge decimal(8,2);
	DECLARE @cid int;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	DECLARE @isClosed bit;

	SELECT @requestTypeName = crt.requestName from tblInternetCustomerRequest cr
	inner join tblCustomerRequestType crt on cr.requestTypeId = crt.requestTypeId
	where cr.requestId = @requestId

	SELECT @cid = cr.cid, @requestCharge = cr.requestCharge,@isClosed = isClosed from tblInternetCustomerRequest cr
	where cr.requestId = @requestId

	SET NOCOUNT ON;

	BEGIN TRY
	BEGIN TRANSACTION tranc;
		
		IF(@isClosed = 0)
		BEGIN
			IF @requestTypeName = 'Discontinue'
			BEGIN 
				UPDATE tblInternetCustomers
				SET isDisconnected = 0,
				disconnectionRequestId = null,
				disconnectionEffectiveDate = null,
				editedBy = @createdBy,
				editedDate = GETDATE()
				WHERE id = @cid
			END
			IF @requestTypeName = 'Reconnect' 
			BEGIN
				UPDATE ic  
				SET ic.isDisconnected = icr.isDisconnected,
				ic.disconnectionEffectiveDate = icr.disconnectionEffectiveDate,
				ic.disconnectionRequestId = icr.disconnectionRequestId,
				ic.editedBy = @createdBy,
				ic.editedDate = GETDATE()
				FROM tblInternetCustomers as ic
				INNER JOIN tblInternetCustomerRequestHistory icr on ic.id = icr.cid and icr.requestId = @requestId
				WHERE ic.id = @cid
			
			END
			IF @requestTypeName = 'Shifting' 
			BEGIN
				UPDATE ic  
				SET ic.hostId = icr.hostId,
				ic.zoneId = icr.zoneId,
				ic.customerAddress = icr.customerAddress,
				ic.assignedUserId = icr.assignedUserId,
				ic.editedBy = @createdBy,
				ic.editedDate = GETDATE()
				FROM tblInternetCustomers as ic
				INNER JOIN tblInternetCustomerRequestHistory icr on ic.id = icr.cid and icr.requestId = @requestId
				WHERE ic.id = @cid
			
			END
			IF @requestTypeName = 'Bandwidth Upgrade' or @requestTypeName = 'Bandwidth Downgrade'
			BEGIN
				UPDATE ic  
				SET ic.requiredNet = icr.requiredNet,
				ic.monthBill = icr.monthBill,
				ic.editedBy = @createdBy,
				ic.editedDate = GETDATE()
				FROM tblInternetCustomers as ic
				INNER JOIN tblInternetCustomerRequestHistory icr on ic.id = icr.cid and icr.requestId = @requestId
				WHERE ic.id = @cid
			
			END
			IF @requestCharge > 0
			BEGIN
				DELETE FROM tblInternetTransactionMaster
				WHERE customerRequestId = @requestId
				and cid = @cid
				and transactionType = 'Dr.'

				UPDATE tblInternetCustomerBalance
				SET totalDebit = totalDebit - @requestCharge,
				totalBalance = totalBalance + @requestCharge
				WHERE cid = @cid
			END

			DELETE FROM tblInternetCustomerRequest
			WHERE requestId = @requestId;
		END
		ELSE
		BEGIN
			RAISERROR('This data is already processed, can not be deleted!!',16,1)
		END
		COMMIT TRANSACTION trac;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END

GO
/****** Object:  StoredProcedure [dbo].[dsp_deleteInternetPrimaryBill]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 1st Oct 2020
-- =============================================
CREATE PROCEDURE [dbo].[dsp_deleteInternetPrimaryBill]
	@cid int,
	@connFee numeric(8,2),
	@monthlyBill numeric(8,2),
	@connMonth varchar(20),
	@connYear int,	
	@createdBy int
AS
BEGIN
	DECLARE @previousFee numeric(8,2) = 0;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	
	SET NOCOUNT ON;

	BEGIN TRY
	BEGIN TRANSACTION tranc;
----------------validation starts---------------------
	IF EXISTS(SELECT * FROM tblInternetTransactionMaster WHERE cid = @cid and isConFee = 1 and transactionType = 'Dr.' and isClosed = 1)
	BEGIN
		RAISERROR('Connection Fee has already been collected, can not be Modified!!',16,1)
	END
	IF EXISTS(SELECT * FROM tblInternetTransactionMaster WHERE cid = @cid and billDetailId is not null and transactionType = 'Dr.' and isClosed = 1)
	BEGIN
		RAISERROR('Monthly Fee has already been collected, can not be Modified!!',16,1)
	END
---------------validation ends------------------------------


SELECT @previousFee = SUM(transactionAmount) FROM tblInternetTransactionMaster WHERE cid = @cid and (isConFee = 1 or billDetailId is not null) and transactionType = 'Dr.' and isClosed = 0

--------------delete from transaction table----------------
	
	delete from tblInternetTransactionMaster
	where (isConFee = 1 or billDetailId is not null)
	and cid = @cid
	and isClosed = 0
	and transactionType = 'Dr.'

	delete from tblInternetBillDetails
	where cid = @cid
	and isClosed = 0

------------delete from transaction table ends--------------


--------------update customer table-------------------
	update tblInternetCustomers
	set monthBill = @monthlyBill,
	connFee = @connFee,
	connMonth = @connMonth,
	connYear = @connYear,
	editedBy = @createdBy,
	editedDate = GETDATE()
	where id = @cid
--------------update customer table ends-------------------

-----------update customer Balance------------------------

	UPDATE tblInternetCustomerBalance
	SET totalDebit = totalDebit - @previousFee,
	totalBalance = totalBalance - @previousFee,
	editedBy = @createdBy,
	editedDate = GETDATE()
	WHERE cid = @cid
-----------update customer Balance ends------------------------


----------Insert conn Fee in transaction Master-----------------
IF @connFee > 0
BEGIN
	INSERT INTO [dbo].[tblInternetTransactionMaster]
				([cid]
				,[transactionType]
				,[transactionAmount]
				,[isConFee]
				,[transactionMonth]
				,[transactionYear]
				,[createdBy]
				,[createdDate]
				)
			VALUES
				(@cid
				,'Dr.'
				,@connFee
				,1
				,@connMonth
				,@connYear
				,@createdBy
				,GETDATE()
				)
	INSERT INTO [dbo].[tblInternetCustomerBalance]
				([cid]
				,[totalDebit]
				,[totalCredit]
				,[totalBalance]
				,[createdBy]
				,[createdDate]
				)
				VALUES
				(@cid
				,@connFee
				,0
				,0-(@connFee)
				,@createdBy
				,GETDATE())
END;

----------Insert conn Fee in transaction Master ends-----------------

----------Process Monthly bill---------------------------------------
IF @monthlyBill > 0
BEGIN
	DECLARE @connYearName varchar(20);
	SELECT @connYearName =  y.yearName FROM tblInternetCustomers c
			INNER JOIN tblYear y on c.connYear = y.yearId
			WHERE id = @cid;

			DECLARE @betweenMonthName varchar(20);
			DECLARE @betweenYearName int;
			DECLARE billGenCursor CURSOR 
			FOR Select betweenMonthName,betweenYearName from GetMonthListBetweenDates('01-'+@connMonth+'-' +CAST (@connYearName as varchar),DATEADD(month, -1, getdate()))

			OPEN billGenCursor
			FETCH NEXT FROM billGenCursor INTO
				@betweenMonthName
			   ,@betweenYearName
			WHILE @@FETCH_STATUS = 0
			BEGIN
				print @betweenMonthName
				print @betweenYearName
				EXEC isp_InternetCustomerBillGenerate @cid,0,@betweenMonthName,@betweenYearName,'Generated While Customer Setup',@createdBy
				FETCH NEXT FROM billGenCursor INTO
				@betweenMonthName
			   ,@betweenYearName 
			END
			CLOSE billGenCursor;
			DEALLOCATE billGenCursor;
END

----------process monthly bill ends-----------------------------------
	
	COMMIT TRANSACTION trac;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END


GO
/****** Object:  StoredProcedure [dbo].[dsp_DishMonthlyBillDelete]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 02 Oct 2020
-- =============================================
CREATE PROCEDURE [dbo].[dsp_DishMonthlyBillDelete]
	@cid int,
	 @billCollectionDetailIds AS dbo.IDList READONLY,
	 @createdBy int

AS
BEGIN
	DECLARE @totalBill numeric(8,2) = 0;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;

	SET NOCOUNT ON;

	BEGIN TRY
	BEGIN TRANSACTION tranc;
	SELECT @totalBill = sum(billAmount) from tblDishBillDetails bd
	inner join @billCollectionDetailIds b on bd.billDetailId = b.id 



	-----------update customer Balance------------------------

	UPDATE tblDishCustomerBalance
	SET totalDebit = totalDebit - @totalBill,
	totalBalance = totalBalance - @totalBill,
	editedBy = @createdBy,
	editedDate = GETDATE()
	WHERE cid = @cid
-----------update customer Balance ends------------------------

--------------delete from transaction table----------------
	
	delete tm
	from tblDishTransactionMaster tm
	inner join @billCollectionDetailIds b on tm.billDetailId = b.id
	and cid = @cid
	and isClosed = 0
	and tm.transactionType = 'Dr.'

	delete  bd
	from tblDishBillDetails bd
	inner join @billCollectionDetailIds b on bd.billDetailId = b.id
	where cid = @cid
	and isClosed = 0
--------------delete from transaction table ends----------------
COMMIT TRANSACTION trac;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[dsp_InternetMonthlyBillDelete]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 02 Oct 2020
-- =============================================
CREATE PROCEDURE [dbo].[dsp_InternetMonthlyBillDelete]
	@cid int,
	 @billCollectionDetailIds AS dbo.IDList READONLY,
	 @createdBy int

AS
BEGIN
	DECLARE @totalBill numeric(8,2) = 0;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;

	SET NOCOUNT ON;

	BEGIN TRY
	BEGIN TRANSACTION tranc;
	SELECT @totalBill = sum(billAmount) from tblInternetBillDetails bd
	inner join @billCollectionDetailIds b on bd.billDetailId = b.id 



	-----------update customer Balance------------------------

	UPDATE tblInternetCustomerBalance
	SET totalDebit = totalDebit - @totalBill,
	totalBalance = totalBalance - @totalBill,
	editedBy = @createdBy,
	editedDate = GETDATE()
	WHERE cid = @cid
-----------update customer Balance ends------------------------

--------------delete from transaction table----------------
	
	delete tm
	from tblInternetTransactionMaster tm
	inner join @billCollectionDetailIds b on tm.billDetailId = b.id
	and cid = @cid
	and isClosed = 0
	and tm.transactionType = 'Dr.'

	delete  bd
	from tblInternetBillDetails bd
	inner join @billCollectionDetailIds b on bd.billDetailId = b.id
	where cid = @cid
	and isClosed = 0
--------------delete from transaction table ends----------------
COMMIT TRANSACTION trac;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getBills]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 15 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getBills]
	@month varchar(20),
	@year int
AS
BEGIN
	SELECT 
	billDetailId
	,[month]
	,y.yearName
	,c.customerName
	,ltrim(rtrim(cs.customerSerialName))+ ltrim(rtrim(c.customerId)) as customerSerial
	,bd.billAmount 
	FROM tblInternetBillDetails bd 
	INNER JOIN tblYear y on bd.yearId = y.yearId
	INNER JOIN tblInternetCustomers c on c.id = bd.cid
	INNER JOIN tblCustomerSerial cs on c.customerSerialId = cs.customerSerialId
	WHERE [month] = @month and bd.yearId = @year

END
GO
/****** Object:  StoredProcedure [dbo].[gsp_getCareTakers]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 18 July 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getCareTakers]
	@careTakerId int = 0
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	SELECT 
		 @companyName as rptCompanyName
		,@companyAddress as rptCompanyAddress
		,careTakerId
		,careTakerName
		,isnull(presentAddress,'') presentAddress
		,permanentAddress
		,phoneNo
		,isnull(email,'') email
		,isnull(nid,'') nid
		,joiningDate
		,case when joiningDate is null then '' else FORMAT(joiningDate, 'dd-MMM-yy') end as joiningDateString
		,isnull(salary,0) salary
		,isActive
		,case when isActive = 1 then 'Yes' else 'No' end isActiveString
		,createdBy
		,createdDate
    FROM tblCareTaker
	WHERE @careTakerId = 0 or careTakerId = @careTakerId

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getCustomerRequestTypes]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 05 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getCustomerRequestTypes]
	@requestTypeGroup varchar(20)
AS
BEGIN
	SELECT 
		[requestTypeId]
		,[requestName]
        ,[requestTypeGroup]
    FROM tblCustomerRequestType
	WHERE requestTypeGroup = @requestTypeGroup and isForUI = 1

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getCustomerSerials]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 21 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getCustomerSerials]
	
AS
BEGIN
select
	[customerSerialId] as id,
	[customerSerialName] as text
from [dbo].[tblCustomerSerial]

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getDesignations]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 14 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getDesignations]
	

AS
BEGIN
	SELECT designationId,designationName,isActive FROM tblDesignations 
END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getDishBillCollections]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 05 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getDishBillCollections]
	
AS
BEGIN
	SELECT 
	   'VN-'+ltrim(rtrim(cast(bc.collectionId as varchar(10)))) as voucherNo
	  ,bc.collectionId
      ,bc.cid
	  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
	  ,tc.customerName 
      ,bc.connFee
      ,bc.reConnFee
      ,bc.othersAmount
      ,bc.monthlyFee
      ,bc.fromMonth 
	  ,case when bc.fromMonth is null then '' else FORMAT(bc.fromMonth, 'MMM-yy') end as fromMonthYear
      ,bc.toMonth
	  ,case when bc.toMonth is null then '' else FORMAT(bc.toMonth, 'MMM-yy') end as toMonthYear
      ,bc.shiftingCharge
      ,bc.netAmount
      ,bc.rcvAmount
	  ,bc.description
      ,bc.adjustAdvance
      ,bc.customerSL
      ,bc.pageNo
      ,bc.collectedBy
      ,bc.receivedBy
	  ,case when bc.collectionDate is null then '' else convert(varchar, bc.collectionDate, 103) end as collectedDateString
  FROM tblDishBillCollection bc
  inner join tblDishCustomers tc on bc.cid = tc.id
  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
  

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getDishBills]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 17 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getDishBills]
	@month varchar(20),
	@year int
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	SELECT 
	 @companyName as companyName
	,@companyAddress as companyAddress
	,billDetailId
	,[month]
	,y.yearName
	,c.customerName
	,c.customerPhone
	,c.customerAddress
	,z.zoneName
	,case when bd.isClosed = 1 then 'Yes' else 'No' end as isClosedString
	,ltrim(rtrim(cs.customerSerialName))+ ltrim(rtrim(c.customerId)) as customerSerial
	,bd.billAmount 
	FROM tblDishBillDetails bd 
	INNER JOIN tblYear y on bd.yearId = y.yearId
	INNER JOIN tblDishCustomers c on c.id = bd.cid
	INNER JOIN tblZones z on c.zoneId = z.zoneId
	INNER JOIN tblCustomerSerial cs on c.customerSerialId = cs.customerSerialId
	WHERE [month] = @month and bd.yearId = @year

END
GO
/****** Object:  StoredProcedure [dbo].[gsp_getDishCustomerByCustomeridAndSerialprefix]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 03 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getDishCustomerByCustomeridAndSerialprefix]
	@customerId varchar(20),
	@serialPrefixId int
AS
BEGIN
	SELECT 
			id,
			customerId,
			dc.customerSerialId,
			cast(ltrim(rtrim(customerSerialName)) as varchar)+cast(dc.customerId as varchar(20)) as customerSerial,
			customerName,
			customerPhone,
			customerAddress,
			hostId,
			zoneId,
			assignedUserId,
			connFee,
			monthBill,
			othersAmount,
			[description],
			connMonth,
			connYear,
			isActive
    FROM tblDishCustomers dc
	inner join tblCustomerSerial tc on tc.customerSerialId = dc.customerSerialId
	WHERE customerId = @customerId and dc.customerSerialId = @serialPrefixId
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getDishCustomerById]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 19 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getDishCustomerById]
	@id int
AS
BEGIN
	SELECT 
			id,
			customerId,
			dc.customerSerialId,
			cast(ltrim(rtrim(customerSerialName)) as varchar)+cast(dc.customerId as varchar(20)) as customerSerial,
			customerName,
			customerPhone,
			customerAddress,
			dc.hostId,
			h.hostName,
			h.hostPhone,
			dc.zoneId,
			z.zoneName,
			assignedUserId,
			isnull(u.userName,'') as assignedUserName,
			assignedUserId,
			connFee,
			monthBill,
			othersAmount,
			[description],
			connMonth,
			connYear,
			y.yearName as connYearName,
			dc.isActive
    FROM tblDishCustomers dc
	inner join tblCustomerSerial tc on tc.customerSerialId = dc.customerSerialId
	left join tblHosts h on dc.hostId = h.hostId
	left join tblZones z on dc.zoneId = z.zoneId
	left join tblUsers u on dc.assignedUserId = u.userId
	left join tblYear y on dc.connYear = y.yearId
	WHERE id = @id 
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getDishCustomerRequests]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 16 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getDishCustomerRequests]
	
AS
BEGIN
	SELECT 
		cid,
		ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial,
		tc.customerName as customerName,
		tc.customerPhone as customerPhone,
		requestId,
		requestCharge,
		case when requestMonth = null then '' else requestMonth end requestMonth,
		icr.requestTypeId,
		cr.requestName,
		isnull(requestYear,0) requestYear,
		case when y.yearName = null then '' else CAST(y.yearName as varchar) end as requestYearName,
		isnull(remarks,'') as remarks,
		isnull(updatedMontlyBill,0) as updatedMontlyBill
	FROM
	tblDishCustomerRequest icr
	inner join tblDishCustomers tc on icr.cid = tc.id
	inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
	inner join tblCustomerRequestType cr on icr.requestTypeId = cr.requestTypeId
	left join tblYear y on icr.requestYear = y.yearId 
	


END



GO
/****** Object:  StoredProcedure [dbo].[gsp_getDishCustomers]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 19 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getDishCustomers]
	
AS
BEGIN
	SELECT 
			id,
			customerId,
			dc.customerSerialId,
			cast(ltrim(rtrim(customerSerialName)) as varchar) + cast(dc.customerId as varchar(20)) as customerSerial, 
			customerName,
			customerPhone,
			customerAddress,
			dc.hostId,
			h.hostName,
			dc.zoneId,
			z.zoneName,
			assignedUserId,
			isnull(u.userName,'') as assignedUserName,
			connFee,
			monthBill,
			othersAmount,
			[description],
			connMonth,
			connYear,
			y.yearName as connYearName,
			dc.isActive,
			case when dc.isActive = 1 then 'Yes' else 'No' end isActiveString
    FROM tblDishCustomers dc
	INNER JOIN tblCustomerSerial cs on dc.customerSerialId = cs.customerSerialId
	left join tblHosts h on dc.hostId = h.hostId
	left join tblZones z on dc.zoneId = z.zoneId
	left join tblUsers u on dc.assignedUserId = u.userId
	left join tblYear y on dc.connYear = y.yearId
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getDishDashboarddata]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 09 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getDishDashboarddata]
	
AS
BEGIN
	DECLARE @totalActiveUsers int,
			@totalInactiveUser int,
			@discontinuedUserThisMonth int,
			@generatedBillThisMonth decimal(8,2),
			@collectedThisMonth decimal(8,2),
			@todaysCollectedAmount decimal(8,2),
			@currentMonthName varchar(10),
			@currentYear int

	
	SELECT  @totalActiveUsers = count(*) from tblDishCustomers
	where isActive = 1 and (isDisconnected = 0 or (disconnectionEffectiveDate > GETDATE()))

	SELECT  @totalInactiveUser = count(*) from tblDishCustomers
	where isActive = 0 or (isDisconnected = 1 and disconnectionEffectiveDate < GETDATE())

	SELECT  @discontinuedUserThisMonth = count(*) from tblDishCustomers
	where isDisconnected = 1 and month(disconnectionEffectiveDate) = month(GETDATE()) and year(disconnectionEffectiveDate) = year(GETDATE())


	
    SELECT @currentMonthName =  FORMAT(getdate(), 'MMMMMMMMM'), @currentYear = YEAR(getdate())


	SELECT @generatedBillThisMonth = sum(transactionAmount) from tblDishTransactionMaster tm
	inner join tblYear y on tm.transactionYear = y.yearId
	where tm.transactionType = 'Dr.' and format(createdDate,'MMM-yyyy') = format(getdate(),'MMM-yyyy')

	select @collectedThisMonth = sum(monthlyFee)+sum(connFee)+sum(reConnFee)+sum(shiftingCharge) from tblDishBillCollection
	where format(createdDate,'MMM-yyyy') = format(getdate(),'MMM-yyyy')

	select @todaysCollectedAmount = sum(monthlyFee)+sum(connFee)+sum(reConnFee)+sum(shiftingCharge) from tblDishBillCollection
	where format(createdDate,'dd-MMM-yyyy') = format(getdate(),'dd-MMM-yyyy')

	select isnull(@totalActiveUsers,0) as totalActiveUsers,
		   isnull(@totalInactiveUser,0) as totalInactiveUser,
		   isnull(@discontinuedUserThisMonth,0) as discontinuedUserThisMonth,
		   isnull(@generatedBillThisMonth,0) as generatedBillThisMonth,
		   isnull(@collectedThisMonth,0) as collectedThisMonth,
		   isnull(@todaysCollectedAmount,0) as todaysCollectedAmount 

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getDishMonthlyBill]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 09 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getDishMonthlyBill]
	@cid int,
	@fromMonthDate datetime,
	@toMonthDate datetime
AS
BEGIN
	

	select sum(isnull(transactionAmount,0)) totalMonthlyBill from tblDishTransactionMaster
	where cid = @cid 
		and transactionType = 'Dr.' 
		and billDetailId is not null 
		and isClosed = 0
		and transactionDate between @fromMonthDate and  dateadd(day,1,@toMonthDate)
	
END
	



GO
/****** Object:  StoredProcedure [dbo].[gsp_getDishMonthlyBillByCollectionId]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 02 Oct 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getDishMonthlyBillByCollectionId]
	@billCollectionDetailIds AS dbo.IDList READONLY
AS
BEGIN
	

	select sum(isnull(transactionAmount,0)) totalMonthlyBill from tblDishTransactionMaster tm
	inner join @billCollectionDetailIds b on tm.billDetailId = b.id
	where  transactionType = 'Dr.' 
	and isClosed = 0
		
	
END
	



GO
/****** Object:  StoredProcedure [dbo].[gsp_getDishPagesByYear]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 03 Oct 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getDishPagesByYear]
	@yearId int,
	@receivedBy	int
AS
BEGIN
select
	 distinct pageNo 
	 from tblDishBillCollection
	 where collectionYear = @yearId
	 and receivedBy = @receivedBy
END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getDishRemaingBillByCid]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 05 Jun 2020
-- =============================================

--exec [dbo].[gsp_getDishRemaingBillByCid] 12
CREATE PROCEDURE [dbo].[gsp_getDishRemaingBillByCid]
	@id int
AS
BEGIN
	DECLARE @advanceAmount DECIMAL,
			@totalDebit DECIMAL,
			@totalCredit DECIMAL,
			@pendingAmount DECIMAL,
			@totalClosedDebit DECIMAL,
			@totalDiscount DECIMAL 

	select @totalDebit = isnull(sum(tm.transactionAmount),0) from tblDishTransactionMaster tm where tm.transactionType = 'Dr.' and tm.cid = @id
	select @totalCredit = isnull(sum(tm.transactionAmount),0) from tblDishTransactionMaster tm where tm.transactionType = 'Cr.' and tm.cid = @id
	select @totalClosedDebit = isnull(sum(tm.transactionAmount),0) from tblDishTransactionMaster tm where tm.transactionType = 'Dr.' and tm.cid = @id and isClosed = 1
	select @totalDiscount = sum(isnull(totalDiscount,0)) from tblDishCustomerBalance where cid = @id
	SET @pendingAmount = @totalDebit - @totalCredit

	select @advanceAmount = @totalCredit - @totalClosedDebit + @totalDiscount

	select 
		isnull(tm.billDetailId,0) billDetailId,
		tm.cid,
		c.customerName,
		ltrim(rtrim(cs.customerSerialName)) + ltrim(rtrim(c.customerId)) as customerSerial,
		isnull(crt.requestName,'') requestName,
		tm.transactionAmount,
		isnull(tm.customerRequestId,0) customerRequestId,
		@pendingAmount as pendingAmount,
		isnull(@advanceAmount,0) as advanceAmount,
		case when isConFee = 1 then 'Connection Fee' else case when isOtherFee = 1 then 'Others Fee' else case when tm.billDetailId is null then crt.requestName else 'Monthly Bill' end end end as collectionType,
		isnull(tm.transactionMonth,'') transactionMonth,
		case when y.yearName is null then '' else cast(y.yearName as varchar) end as yearName,
		isnull(tm.transactionYear,0) as transactionYear
		from tblDishTransactionMaster tm
		inner join tblDishCustomers c on tm.cid = c.id
		inner join tblCustomerSerial cs on c.customerSerialId = cs.customerSerialId
		left join tblYear y on tm.transactionYear = y.yearId
		left join tblDishCustomerRequest cr on tm.customerRequestId = cr.requestId
		left join tblCustomerRequestType crt on cr.requestTypeId = crt.requestTypeId
	where tm.transactionType = 'Dr.' and tm.isClosed = 0 and tm.cid = @id
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getDishUnCollections]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 23 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getDishUnCollections]
	@fromDate datetime,
	@toDate datetime,
	@receivedBy int
AS
BEGIN
	SELECT 
	   'VN-'+ltrim(rtrim(cast(bc.collectionId as varchar(10)))) as voucherNo
	  ,bc.collectionId
      ,bc.cid
	  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
	  ,tc.customerName 
      ,bc.connFee
      ,bc.reConnFee
      ,bc.othersAmount
      ,bc.monthlyFee
      ,bc.fromMonth 
	  ,case when bc.fromMonth is null then '' else FORMAT(bc.fromMonth, 'MMM-yy') end as fromMonthYear
      ,bc.toMonth
	  ,case when bc.toMonth is null then '' else FORMAT(bc.toMonth, 'MMM-yy') end as toMonthYear
      ,bc.shiftingCharge
      ,bc.netAmount
      ,bc.rcvAmount
	  ,bc.description
      ,bc.adjustAdvance
      ,bc.customerSL
      ,bc.pageNo
      ,bc.collectedBy
      ,bc.receivedBy
	  ,bc.createdDate
	  ,cast(FORMAT (bc.collectionDate, 'dd/MM/yyyy ') as varchar) as stringCreatedDate
  FROM tblDishBillCollection bc
  inner join tblDishCustomers tc on bc.cid = tc.id
  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
  where bc.collectionDate between @fromdate and DATEADD(day,1,@toDate) and isAmountCollected = 0
  and (bc.collectionId is null or bc.collectedBy = @receivedBy)

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getHostById]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 17 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getHostById]
	@hostId int
AS
BEGIN
	SELECT 
		[hostId]
		,[hostName]
        ,[hostPhone]
        ,[hostAddress]
		,[isActive]
    FROM tblHosts
	WHERE hostId = @hostId
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getHosts]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 17 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getHosts]
	
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)
	SELECT 
		 @companyName as companyName
		,@companyAddress as companyAddress
		,[hostId]
		,[hostName]
        ,[hostPhone]
        ,[hostAddress]
		,[isActive]
		,case when isActive = 1 then 'Yes' else 'No' end isActiveString
    FROM tblHosts

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getHouseByProjectIdAndId]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 20 July 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getHouseByProjectIdAndId]
	@houseId int
	,@projectId int
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)
	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	SELECT
		@companyName as rptCompanyName,
		@companyAddress as rptCompanyAddress,
		h.houseId,
		h.houseName,
		h.projectId,
		h.houseType,
		h.monthlyRent,
		h.[description],
		h.createdBy,
		h.createdDate,
		p.projectName
	FROM 
	tblHouse h
	INNER JOIN tblProject p on h.projectId = p.projectId
	WHERE (@projectId = 0 or h.projectId = @projectId)
	and (@houseId = 0 or h.houseId = @houseId)

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getInternetBillCollections]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 05 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getInternetBillCollections]
	
AS
BEGIN
	SELECT 
	   'VN-'+ltrim(rtrim(cast(bc.collectionId as varchar(10)))) as voucherNo
	  ,bc.collectionId
      ,bc.cid
	  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
	  ,tc.customerName 
      ,bc.connFee
      ,bc.reConnFee
      ,bc.othersAmount
      ,bc.monthlyFee
      ,bc.fromMonth 
	  ,case when bc.fromMonth is null then '' else FORMAT(bc.fromMonth, 'MMM-yy') end as fromMonthYear
      ,bc.toMonth
	  ,case when bc.toMonth is null then '' else FORMAT(bc.toMonth, 'MMM-yy') end as toMonthYear
      ,bc.shiftingCharge
      ,bc.netAmount
      ,bc.rcvAmount
	  ,bc.description
      ,bc.adjustAdvance
      ,bc.customerSL
      ,bc.pageNo
      ,bc.collectedBy
      ,bc.receivedBy
	  ,case when bc.collectionDate is null then '' else convert(varchar, bc.collectionDate, 103) end as collectedDateString
  FROM tblInternetBillCollection bc
  inner join tblInternetCustomers tc on bc.cid = tc.id
  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
  

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getInternetBills]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 17 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getInternetBills]
	@month varchar(20),
	@year int
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	SELECT 
	 @companyName as companyName
	,@companyAddress as companyAddress
	,billDetailId
	,[month]
	,y.yearName
	,c.customerName
	,c.customerPhone
	,c.customerAddress
	,z.zoneName
	,case when bd.isClosed = 1 then 'Yes' else 'No' end as isClosedString
	,ltrim(rtrim(cs.customerSerialName))+ ltrim(rtrim(c.customerId)) as customerSerial
	,bd.billAmount 
	FROM tblInternetBillDetails bd 
	INNER JOIN tblYear y on bd.yearId = y.yearId
	INNER JOIN tblInternetCustomers c on c.id = bd.cid
	INNER JOIN tblZones z on c.zoneId = z.zoneId
	INNER JOIN tblCustomerSerial cs on c.customerSerialId = cs.customerSerialId
	WHERE [month] = @month and bd.yearId = @year

END
GO
/****** Object:  StoredProcedure [dbo].[gsp_getInternetCustomerByCustomeridAndSerialprefix]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 25 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getInternetCustomerByCustomeridAndSerialprefix]
		@customerId varchar(20),
		@serialPrefixId int
AS
BEGIN
	SELECT 
			id,
			customerId,
			dc.customerSerialId,
			cast(ltrim(rtrim(customerSerialName)) as varchar)+cast(dc.customerId as varchar(20)) as customerSerial,
			customerName,
			customerPhone,
			customerAddress,
			requiredNet,
			ipAddress,
			hostId,
			zoneId,
			assignedUserId,
			connFee,
			monthBill,
			othersAmount,
			[description],
			connMonth,
			connYear,
			isActive
    FROM tblInternetCustomers dc
	inner join tblCustomerSerial tc on tc.customerSerialId = dc.customerSerialId
	WHERE customerId = @customerId and dc.customerSerialId = @serialPrefixId
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getInternetCustomerById]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 25 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getInternetCustomerById]
		@id int
AS
BEGIN
	SELECT 
			id,
			customerId,
			dc.customerSerialId,
			cast(ltrim(rtrim(customerSerialName)) as varchar)+cast(dc.customerId as varchar(20)) as customerSerial,
			customerName,
			customerPhone,
			customerAddress,
			requiredNet,
			ipAddress,
			dc.hostId,
			h.hostName,
			h.hostPhone,
			dc.zoneId,
			z.zoneName,
			assignedUserId,
			isnull(u.userName,'') as assignedUserName,
			assignedUserId,
			connFee,
			monthBill,
			othersAmount,
			[description],
			connMonth,
			connYear,
			y.yearName as connYearName,
			dc.isActive
    FROM tblInternetCustomers dc
	inner join tblCustomerSerial tc on tc.customerSerialId = dc.customerSerialId
	left join tblHosts h on dc.hostId = h.hostId
	left join tblZones z on dc.zoneId = z.zoneId
	left join tblUsers u on dc.assignedUserId = u.userId
	left join tblYear y on dc.connYear = y.yearId
	WHERE id = @id 
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getInternetCustomerRequests]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 09 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getInternetCustomerRequests]
	
AS
BEGIN
	SELECT 
		cid,
		ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial,
		tc.customerName as customerName,
		tc.customerPhone as customerPhone,
		requestId,
		requestCharge,
		case when requestMonth = null then '' else requestMonth end requestMonth,
		icr.requestTypeId,
		cr.requestName,
		isnull(requestYear,0) requestYear,
		case when y.yearName = null then '' else CAST(y.yearName as varchar) end as requestYearName,
		isnull(icr.requiredNet,'') as requiredNet,
		isnull(remarks,'') as remarks,
		isnull(updatedMontlyBill,0) as updatedMontlyBill
	FROM
	tblInternetCustomerRequest icr
	inner join tblInternetCustomers tc on icr.cid = tc.id
	inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
	inner join tblCustomerRequestType cr on icr.requestTypeId = cr.requestTypeId
	left join tblYear y on icr.requestYear = y.yearId 
	


END



GO
/****** Object:  StoredProcedure [dbo].[gsp_getInternetCustomers]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 25 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getInternetCustomers]
	
AS
BEGIN
	SELECT 
			id,
			customerId,
			dc.customerSerialId,
			cast(ltrim(rtrim(customerSerialName)) as varchar) + cast(dc.customerId as varchar(20)) as customerSerial, 
			customerName,
			customerPhone,
			customerAddress,
			requiredNet,
			ipAddress,
			dc.hostId,
			h.hostName,
			dc.zoneId,
			z.zoneName,
			assignedUserId,
			isnull(u.userName,'') as assignedUserName,
			connFee,
			monthBill,
			othersAmount,
			[description],
			connMonth,
			connYear,
			y.yearName as connYearName,
			dc.isActive,
			case when dc.isActive = 1 then 'Yes' else 'No' end isActiveString
    FROM tblInternetCustomers dc
	INNER JOIN tblCustomerSerial cs on dc.customerSerialId = cs.customerSerialId
	left join tblHosts h on dc.hostId = h.hostId
	left join tblZones z on dc.zoneId = z.zoneId
	left join tblUsers u on dc.assignedUserId = u.userId
	left join tblYear y on dc.connYear = y.yearId
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getInternetDashboarddata]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 09 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getInternetDashboarddata]
	
AS
BEGIN
	DECLARE @totalActiveUsers int,
			@totalInactiveUser int,
			@discontinuedUserThisMonth int,
			@generatedBillThisMonth decimal(8,2),
			@collectedThisMonth decimal(8,2),
			@todaysCollectedAmount decimal(8,2),
			@currentMonthName varchar(10),
			@currentYear int

	
	SELECT  @totalActiveUsers = count(*) from tblInternetCustomers
	where isActive = 1 and (isDisconnected = 0 or (disconnectionEffectiveDate > GETDATE()))

	SELECT  @totalInactiveUser = count(*) from tblInternetCustomers
	where isActive = 0 or (isDisconnected = 1 and disconnectionEffectiveDate < GETDATE())

	SELECT  @discontinuedUserThisMonth = count(*) from tblInternetCustomers
	where isDisconnected = 1 and month(disconnectionEffectiveDate) = month(GETDATE()) and year(disconnectionEffectiveDate) = year(GETDATE())


	
    SELECT @currentMonthName =  FORMAT(getdate(), 'MMMMMMMMM'), @currentYear = YEAR(getdate())


	SELECT @generatedBillThisMonth = sum(transactionAmount) from tblInternetTransactionMaster tm
	inner join tblYear y on tm.transactionYear = y.yearId
	where tm.transactionType = 'Dr.' and format(createdDate,'MMM-yyyy') = format(getdate(),'MMM-yyyy')

	select @collectedThisMonth = sum(monthlyFee)+sum(connFee)+sum(reConnFee)+sum(shiftingCharge) from tblInternetBillCollection
	where format(createdDate,'MMM-yyyy') = format(getdate(),'MMM-yyyy')

	select @todaysCollectedAmount = sum(monthlyFee)+sum(connFee)+sum(reConnFee)+sum(shiftingCharge) from tblInternetBillCollection
	where format(createdDate,'dd-MMM-yyyy') = format(getdate(),'dd-MMM-yyyy')

	select isnull(@totalActiveUsers,0) as totalActiveUsers,
		   isnull(@totalInactiveUser,0) as totalInactiveUser,
		   isnull(@discontinuedUserThisMonth,0) as discontinuedUserThisMonth,
		   isnull(@generatedBillThisMonth,0) as generatedBillThisMonth,
		   isnull(@collectedThisMonth,0) as collectedThisMonth,
		   isnull(@todaysCollectedAmount,0) as todaysCollectedAmount 

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getInternetMOnthlyBill]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 09 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getInternetMOnthlyBill]
	@cid int,
	@fromMonthDate datetime,
	@toMonthDate datetime
AS
BEGIN
	

	select sum(isnull(transactionAmount,0)) totalMonthlyBill from tblInternetTransactionMaster
	where cid = @cid 
		and transactionType = 'Dr.' 
		and billDetailId is not null 
		and isClosed = 0
		and transactionDate between @fromMonthDate and  dateadd(day,1,@toMonthDate)
	
END
	



GO
/****** Object:  StoredProcedure [dbo].[gsp_getInternetMonthlyBillByCollectionId]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 02 Oct 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getInternetMonthlyBillByCollectionId]
	@billCollectionDetailIds AS dbo.IDList READONLY
AS
BEGIN
	

	select sum(isnull(transactionAmount,0)) totalMonthlyBill from tblInternetTransactionMaster tm
	inner join @billCollectionDetailIds b on tm.billDetailId = b.id
	where  transactionType = 'Dr.' 
	and isClosed = 0
		
	
END
	



GO
/****** Object:  StoredProcedure [dbo].[gsp_getInternetPagesByYear]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 03 Oct 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getInternetPagesByYear]
	@yearId int,
	@receivedBy	int
AS
BEGIN
select
	 distinct pageNo 
	 from tblInternetBillCollection
	 where collectionYear = @yearId
	 and receivedBy = @receivedBy
END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getInternetRemaingBillByCid]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 05 Jun 2020
-- =============================================

--exec [dbo].[gsp_getInternetRemaingBillByCid] 12
CREATE PROCEDURE [dbo].[gsp_getInternetRemaingBillByCid]
	@id int
AS
BEGIN
	DECLARE @advanceAmount DECIMAL,
			@totalDebit DECIMAL,
			@totalCredit DECIMAL,
			@pendingAmount DECIMAL,
			@totalClosedDebit DECIMAL,
			@totalDiscount DECIMAL 

	select @totalDebit = isnull(sum(tm.transactionAmount),0) from tblInternetTransactionMaster tm where tm.transactionType = 'Dr.' and tm.cid = @id
	select @totalCredit = isnull(sum(tm.transactionAmount),0) from tblInternetTransactionMaster tm where tm.transactionType = 'Cr.' and tm.cid = @id
	select @totalClosedDebit = isnull(sum(tm.transactionAmount),0) from tblInternetTransactionMaster tm where tm.transactionType = 'Dr.' and tm.cid = @id and isClosed = 1
	select @totalDiscount = sum(isnull(totalDiscount,0)) from tblInternetCustomerBalance where cid = @id
	SET @pendingAmount = @totalDebit - @totalCredit

	select @advanceAmount = @totalCredit - @totalClosedDebit + @totalDiscount

	select 
		isnull(tm.billDetailId,0) billDetailId,
		tm.cid,
		c.customerName,
		ltrim(rtrim(cs.customerSerialName)) + ltrim(rtrim(c.customerId)) as customerSerial,
		isnull(crt.requestName,'') requestName,
		tm.transactionAmount,
		isnull(tm.customerRequestId,0) customerRequestId,
		@pendingAmount as pendingAmount,
		isnull(@advanceAmount,0) as advanceAmount,
		case when isConFee = 1 then 'Connection Fee' else case when isOtherFee = 1 then 'Others Fee' else case when tm.billDetailId is null then crt.requestName else 'Monthly Bill' end end end as collectionType,
		isnull(tm.transactionMonth,'') transactionMonth,
		case when y.yearName is null then '' else cast(y.yearName as varchar) end as yearName,
		isnull(tm.transactionYear,0) as transactionYear
		from tblInternetTransactionMaster tm
		inner join tblInternetCustomers c on tm.cid = c.id
		inner join tblCustomerSerial cs on c.customerSerialId = cs.customerSerialId
		left join tblYear y on tm.transactionYear = y.yearId
		left join tblInternetCustomerRequest cr on tm.customerRequestId = cr.requestId
		left join tblCustomerRequestType crt on cr.requestTypeId = crt.requestTypeId
	where tm.transactionType = 'Dr.' and tm.isClosed = 0 and tm.cid = @id
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getInternetUnCollections]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 23 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getInternetUnCollections]
	@fromDate datetime,
	@toDate datetime,
	@receivedBy int
AS
BEGIN
	SELECT 
	   'VN-'+ltrim(rtrim(cast(bc.collectionId as varchar(10)))) as voucherNo
	  ,bc.collectionId
      ,bc.cid
	  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
	  ,tc.customerName 
      ,bc.connFee
      ,bc.reConnFee
      ,bc.othersAmount
      ,bc.monthlyFee
      ,bc.fromMonth 
	  ,case when bc.fromMonth is null then '' else FORMAT(bc.fromMonth, 'MMM-yy') end as fromMonthYear
      ,bc.toMonth
	  ,case when bc.toMonth is null then '' else FORMAT(bc.toMonth, 'MMM-yy') end as toMonthYear
      ,bc.shiftingCharge
      ,bc.netAmount
      ,bc.rcvAmount
	  ,bc.description
      ,bc.adjustAdvance
      ,bc.customerSL
      ,bc.pageNo
      ,bc.collectedBy
      ,bc.receivedBy
	  ,bc.createdDate
	  ,cast(FORMAT (bc.collectionDate, 'dd/MM/yyyy ') as varchar) as stringCreatedDate
  FROM tblInternetBillCollection bc
  inner join tblInternetCustomers tc on bc.cid = tc.id
  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
  where bc.collectionDate between @fromdate and DATEADD(day,1,@toDate) and isAmountCollected = 0
  and (bc.collectionId is null or bc.collectedBy = @receivedBy)

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getLastPayedBillForDish]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 20 Sep 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getLastPayedBillForDish]
	@id int
AS
BEGIN
	select top 1
	bd.billAmount,
	bd.month,
	y.yearName,
	bc.customerSL,
	bc.pageNo,
	convert(varchar,bc.collectionDate,105) as receivedDateString,
	u.userName as receivedByString
	from tblDishBillDetails bd
	inner join tblYear y on y.yearId = bd.yearId
	inner join tblDishBillCollection bc on bd.collectionId = bc.collectionId
	inner join tblUsers u on u.userId = bc.receivedBy
	where bd.cid = @id
	and bd.isClosed = 1
	order by bd.billDetailId desc

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getLastPayedBillForInternet]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 20 Sep 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getLastPayedBillForInternet]
	@id int
AS
BEGIN
	select top 1
	bd.billAmount,
	bd.month,
	y.yearName,
	bc.customerSL,
	bc.pageNo,
	convert(varchar,bc.collectionDate,105) as receivedDateString,
	u.userName as receivedByString
	from tblInternetBillDetails bd
	inner join tblYear y on y.yearId = bd.yearId
	inner join tblInternetBillCollection bc on bd.collectionId = bc.collectionId
	inner join tblUsers u on u.userId = bc.receivedBy
	where bd.cid = @id
	and bd.isClosed = 1
	order by bd.billDetailId desc

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getLoadMenuByUserAndType]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 17 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getLoadMenuByUserAndType]
	@userId int,
	@userType varchar(20)	

AS
BEGIN
	select t.pageId,t.pageName,t.pageUrl,t.pageType,t.pageSubType from tblPages t
	inner join tblUserPage tup on t.pageId = tup.pageId and tup.userId = @userId
	where t.pageType like '%'+@userType+'%' or t.pageType = 'Admin' and t.isActive = 1
	order by orderId
END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getLordInfoById]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 16 Jul 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getLordInfoById]
	@lordId int
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	SELECT 
			 @companyName as rptCompanyName
		    ,@companyAddress as rptCompanyAddress
			,lordId
			,ownerName
			,companyName
			,companyAddress
			,phoneNo
			,email
			,nid
			,createdBy
			,createdDate
    FROM tblLordInfo
	WHERE lordId = @lordId
END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getLordInfoes]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 16 July 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getLordInfoes]
	
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	SELECT 
		 @companyName as rptCompanyName
		,@companyAddress as rptCompanyAddress
		,lordId
		,ownerName
		,companyName
		,companyAddress
		,phoneNo
		,email
		,nid
		,createdBy
		,createdDate
    FROM tblLordInfo

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getProjectById]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 20 July 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getProjectById]
	@projectId int
AS
BEGIN
	
	SELECT
		 p.projectId
		,p.projectName
		,p.projectAddress
		,p.projectDescription
		,p.projectType
		,pc.careTakerId
		,c.careTakerName
		,c.permanentAddress careTakerAddress
		,c.phoneNo as careTakerMobile
	FROM 
	tblProject p 
	LEFT JOIN tblProjectCareTaker pc on p.projectId =  pc.projectId
	LEFT JOIN tblCareTaker c on pc.careTakerId = c.careTakerId
	WHERE p.projectId = @projectId
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getProjects]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 19 Jul 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getProjects]
	
AS
DECLARE @rptCompanyName nvarchar(50),
		@rptCompanyAddress nvarchar(300)

	SET @rptCompanyName = dbo.getCompanyName(1)
	SET @rptCompanyAddress = dbo.getCompanyAddress(1)
BEGIN
	SELECT
		 @rptCompanyName as rptCompanyName
		,@rptCompanyAddress as rptCompanyAddress
		,projectId
		,projectName
		,projectAddress
		,projectDescription
		,projectType
	FROM 
	tblProject

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getUserById]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 14 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getUserById]
	@userId int
AS
BEGIN
	SELECT 
		userId
        ,[userName]
        ,isnull(email,'') as email
        ,isnull(phoneNumber,'') as phoneNumber
        ,isnull([address],'') as [address]
        ,[isAdmin]
        ,[isCableUser]
        ,[isHouseRentUser]
		,designationId
		,[userFullName]
		,[password]
		,[isActive]
    FROM tblusers
	WHERE userId = @userId
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getUserByUserNameAndPass]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 16 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getUserByUserNameAndPass]
	@userName nvarchar(100),
	@password nvarchar(20),
	@userType varchar(5)
AS
BEGIN
	if @userType = 'c'
		SELECT 
			userId
			,[userName]
			,isnull(email,'') as email
			,isnull(phoneNumber,'') as phoneNumber
			,isnull([address],'') as [address]
			,[isAdmin]
			,[isCableUser]
			,[isHouseRentUser]
			,designationId
			,[userFullName]
			,[password]
			,[isActive]
			,'Cable' as userType
			FROM tblusers
			WHERE lower(userName) = lower(@userName) and [password] = @password and isActive = 1 and isCableUser = 1
		
		else if @userType = 'h'
			SELECT 
			userId
			,[userName]
			,isnull(email,'') as email
			,isnull(phoneNumber,'') as phoneNumber
			,isnull([address],'') as [address]
			,[isAdmin]
			,[isCableUser]
			,[isHouseRentUser]
			,designationId
			,[userFullName]
			,[password]
			,[isActive]
			,'House' as userType
			FROM tblusers
			WHERE lower(userName) = lower(@userName) and [password] = @password and isActive = 1 and isHouseRentUser = 1
		--else
		--SELECT 
		--	userId
		--	,[userName]
		--	,isnull(email,'') as email
		--	,isnull(phoneNumber,'') as phoneNumber
		--	,isnull([address],'') as [address]
		--	,[isAdmin]
		--	,[isCableUser]
		--	,[isHouseRentUser]
		--	,designationId
		--	,[userFullName]
		--	,[password]
		--	,[isActive]
		--	,'a' as userType
		--	FROM tblusers
		--	WHERE lower(userName) = lower(@userName) and [password] = @password and isActive = 1 and isAdmin = 1

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getUsers]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 14 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getUsers]
	
AS
BEGIN
	SELECT 
		userId
        ,[userName]
        ,isnull(email,'') as email
        ,isnull(phoneNumber,'') as phoneNumber
        ,isnull([address],'') as [address]
        ,[isAdmin]
        ,[isCableUser]
        ,[isHouseRentUser]
		,tblDesignations.designationId
		,tblDesignations.designationName
		,tblUsers.isActive
		,[userFullName]
		,isManagement
    FROM tblusers
	inner join tblDesignations on tblUsers.designationId = tblDesignations.designationId;


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getYears]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 21 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getYears]
	
AS
BEGIN
select
	yearId as id,
	yearName as text
from [dbo].[tblYear]

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getZoneById]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 17 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getZoneById]
	@zoneId int
AS
BEGIN
	SELECT
		[zoneId] 
		,[zoneName]
		,[isActive]
    FROM tblZones
	WHERE zoneId = @zoneId
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_getZones]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 17 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_getZones]
	
AS
BEGIN
	SELECT 
		[zoneId]
		,[zoneName]
		,[isActive]
    FROM tblZones

END

GO
/****** Object:  StoredProcedure [dbo].[gsp_menusByUser]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 15 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_menusByUser]
	@userId int
AS
BEGIN
	declare @isHouseRentUser bit , @isCableUser bit, @isAdmin bit
	select @isHouseRentUser = isHouseRentUser, @isCableUser = isCableUser,@isAdmin = isAdmin from tblUsers where userId = @userId
	print @isHouseRentUser
	print @isCableUser

	select pageId,pageName,pageUrl,pageType,orderId,isPermitted from
	(select 
	tp.pageId,
	tp.pageName,
	tp.pageUrl,
	tp.pageType,
	tp.orderId,
	case when tup.pageId is null then 0 else 1 end as isPermitted
	from tblPages tp
	left join tblUserPage tup on tp.pageId = tup.pageId 
	where  tp.pageType = 'House'

	union all

	select 
	tp.pageId,
	tp.pageName,
	tp.pageUrl,
	tp.pageType,
	tp.orderId,
	case when tup.pageId is null then 0 else 1 end as isPermitted
	from tblPages tp
	left join tblUserPage tup on tp.pageId = tup.pageId and tup.userId = @userId
	where  @isCableUser = 1 and (tp.pageType = 'Cable'  or tp.pageType = 'CableReports')

	union all
	
	select 
	tp.pageId,
	tp.pageName,
	tp.pageUrl,
	tp.pageType,
	tp.orderId,
	case when tup.pageId is null then 0 else 1 end as isPermitted
	from tblPages tp
	left join tblUserPage tup on tp.pageId = tup.pageId and tup.userId = @userId
	where  tp.pageType = 'Admin' 
	) e
	order by e.pageType,e.orderId
	
	


END

GO
/****** Object:  StoredProcedure [dbo].[gsp_pendingConnFeesByCid]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 03 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[gsp_pendingConnFeesByCid]
	@cid int
AS
BEGIN
	select ROW_NUMBER() 
		over(order by DATEPART(mm,CAST(transactionMonth+ ' 1900' AS DATETIME)),transactionYear  asc) as id ,
	ltrim(rtrim(transactionMonth)) +'-'+ltrim(rtrim(cast(yearName as varchar)))  from tblInternetTransactionMaster
	inner join tblYear on tblInternetTransactionMaster.transactionYear = tblYear.yearId
	where isConFee = 1  and cid = @cid
	order by DATEPART(mm,CAST(transactionMonth+ ' 1900' AS DATETIME)),transactionYear asc

END

GO
/****** Object:  StoredProcedure [dbo].[isp_careTaker]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 18 July 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_careTaker]
	 @careTakerId int = 0
	,@careTakerName nvarchar(50)
	,@presentAddress nvarchar(200)=null
	,@permanentAddress nvarchar(200)
	,@phoneNo varchar(20) = null
	,@email varchar(20) = null
	,@nid varchar(20) =null
	,@joiningDate datetime = null
	,@salary numeric(10,2) = null
	,@isActive bit
	,@createdBy int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	if @careTakerId = 0
	begin
		INSERT INTO tblCareTaker
           (
			 careTakerName
			,presentAddress
			,permanentAddress
			,phoneNo
			,email
			,nid
			,joiningDate
			,salary
			,isActive
			,createdBy
			,createdDate
		   )
     VALUES
           (
		     @careTakerName
			,@presentAddress
			,@permanentAddress
			,@phoneNo
			,@email
			,@nid
			,@joiningDate
			,@salary
			,@isActive
			,@createdBy
		    ,getdate()
		   );

	end

	else
	begin
		UPDATE tblCareTaker 
		set
		careTakerName = @careTakerName ,
		presentAddress = @presentAddress,
		permanentAddress = @permanentAddress,
		phoneNo = @phoneNo,
		email = @email,
		nid = @nid,
		joiningDate = @joiningDate,
		salary = @salary,
		isActive = @isActive,
		editedBy = @createdBy,
		editedDate = getdate()
		where careTakerId = @careTakerId
	end
END

GO
/****** Object:  StoredProcedure [dbo].[isp_DishCustomer]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 19 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_DishCustomer]
	@insertFlag int,
	@customerId varchar(20),
	@customerSerialId int,
	@customerName nvarchar(100),
	@customerPhone nvarchar(15),
	@customerAddress nvarchar(200) = null,
	@hostId int,
	@zoneId int,
	@assignedUserId int,
	@connFee decimal(8, 2) = 0,
	@monthBill decimal(8, 2) = 0,
	@othersAmount decimal(8, 2) = 0,
	@description nvarchar(300) = null,
	@connMonth varchar(20),
	@connYear int,
	@isActive bit,
	@createdBy int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	declare @customerSerial varchar(20) = '';
	DECLARE @cid int;
	DECLARE @requestTypeId int;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	DECLARE @connYearName decimal;

	BEGIN TRY
	BEGIN TRANSACTION tranc;
	SELECT @customerSerial = customerSerialName from tblCustomerSerial where customerSerialId = @customerSerialId;
	SELECT @requestTypeId = requestTypeId from tblCustomerRequestType where requestName = 'Connection Fee';
	if @insertFlag = 1
	begin
		INSERT INTO tblDishCustomers
           (
		   customerId,
		   customerSerialId,
			customerName,
			customerPhone,
			customerAddress,
			hostId,
			zoneId,
			assignedUserId,
			connFee,
			monthBill,
			othersAmount,
			[description],
			connMonth,
			connYear,
			isActive,
			createdBy,
			createdDate
		   )
     VALUES
           (
		   @customerId,
		   @customerSerialId,
		    @customerName,
			@customerPhone,
			@customerAddress,
			@hostId,
			@zoneId,
			@assignedUserId,
			@connFee,
			@monthBill,
			@othersAmount,
			@description,
			@connMonth,
			@connYear,
			@isActive,
			@createdBy,
		    getdate()
			);
		SELECT @cid =  SCOPE_IDENTITY()
		IF @connFee > 0
		BEGIN
			INSERT INTO [dbo].[tblDishTransactionMaster]
				([cid]
				,[transactionType]
				,[transactionAmount]
				,[isConFee]
				,[transactionMonth]
				,[transactionYear]
				,[createdBy]
				,[createdDate]
				)
			VALUES
				(@cid
				,'Dr.'
				,@connFee
				,1
				,@connMonth
				,@connYear
				,@createdBy
				,GETDATE())

			
		END
		IF @othersAmount > 0
			BEGIN
				INSERT INTO [dbo].[tblDishTransactionMaster]
					([cid]
					,[transactionType]
					,[transactionAmount]
					,[isOtherFee]
					,[transactionMonth]
					,[transactionYear]
					,[createdBy]
					,[createdDate]
					)
				VALUES
					(@cid
					,'Dr.'
					,@othersAmount
					,1
					,@connMonth
					,@connYear
					,@createdBy
					,GETDATE())

				
			END
		INSERT INTO [dbo].[tblDishCustomerBalance]
				([cid]
				,[totalDebit]
				,[totalCredit]
				,[totalBalance]
				,[createdBy]
				,[createdDate]
				)
				VALUES
				(@cid
				,@connFee+@othersAmount
				,0
				,0-(@connFee + @othersAmount)
				,@createdBy
				,GETDATE())

		SELECT @connYearName =  y.yearName FROM tblDishCustomers c
			INNER JOIN tblYear y on c.connYear = y.yearId
			WHERE id = @cid;

			DECLARE @betweenMonthName varchar(20);
			DECLARE @betweenYearName int;
			DECLARE billGenCursor CURSOR 
			FOR Select betweenMonthName,betweenYearName from GetMonthListBetweenDates('01-'+@connMonth+'-' +CAST (@connYearName as varchar),DATEADD(month, -1, getdate()))

			OPEN billGenCursor
			FETCH NEXT FROM billGenCursor INTO
				@betweenMonthName
			   ,@betweenYearName
			WHILE @@FETCH_STATUS = 0
			BEGIN
				print @betweenMonthName
				print @betweenYearName
				EXEC isp_DishCustomerBillGenerate @cid,0,@betweenMonthName,@betweenYearName,'Generated While Customer Setup',@createdBy
				FETCH NEXT FROM billGenCursor INTO
				@betweenMonthName
			   ,@betweenYearName 
			END
			CLOSE billGenCursor;
			DEALLOCATE billGenCursor;
	end

	else
	begin
		UPDATE tblDishCustomers 
		set
			customerName = @customerName,
			customerPhone = @customerPhone,
			customerAddress = @customerAddress,
			hostId = @hostId,
			zoneId = @zoneId,
			assignedUserId = @assignedUserId,
			--connFee = @connFee,
			--monthBill = @monthBill,
			--othersAmount = @othersAmount,
			[description] = @description,
			--connMonth = @connMonth,
			--connYear = @connYear,
			isActive = @isActive,
			editedBy = @createdBy,
			editedDate = getdate()
		where customerId = @customerId and customerSerialId = @customerSerialId

		
	end
	SELECT @customerSerial + cast(@customerId as varchar(20)) as customerSerial
	COMMIT TRANSACTION tranc;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH
	
END
GO
/****** Object:  StoredProcedure [dbo].[isp_DishCustomerBillCollection]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 04 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_DishCustomerBillCollection]
	@cid int,
	@connFee decimal(8,2) = 0,
	@reConnFee decimal(8,2) = 0,
	@othersAmount decimal(8,2) = 0,
	@monthlyFee	decimal(8,2) = 0,
	@fromMonth varchar(20) = '0',
	@toMonth varchar(20) = '0',
	@shiftingCharge	decimal(8,2) = 0,
	@description nvarchar(300) = null,
	@netAmount decimal(8,2) = 0,
	@rcvAmount decimal(8,2) = 0,
	@adjustAdvance decimal(8,2) = 0,
	@discount decimal(8,2) = 0,
	@customerSL	varchar(20) = null,
	@pageNo	varchar(20) = null,
	@collectionDate datetime,
	@collectedBy int = null,
	@receivedBy	int = null,
	@createdBy	int

AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@fromMonthDate datetime
			,@toMonthDate datetime
			,@minMonthBillDate datetime
			,@totalMonthlyBill numeric(8,2)
			,@totalConnectionFee numeric(8,2)
			,@totalReconnectionFee numeric(8,2)
			,@totalOtherAmountFee numeric(8,2)
			,@totalShiftingCharge numeric(8,2)
			,@collectionId int = 0
			,@totalDebit numeric(8,2)
			,@totalCredit numeric(8,2)
			,@totalClosedDebit numeric(8,2)
			,@advanceAmount numeric(8,2)
			,@pageNumber int
			,@customerSerial int
			,@totalDiscount numeric(8,2)
			,@serialNoCount int
			,@collectionYear int

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	
	BEGIN TRY
	BEGIN TRANSACTION tranc;
		
		select @totalDebit = isnull(sum(tm.transactionAmount),0) from tblDishTransactionMaster tm where tm.transactionType = 'Dr.' and tm.cid = @cid
		select @totalCredit = isnull(sum(tm.transactionAmount),0) from tblDishTransactionMaster tm where tm.transactionType = 'Cr.' and tm.cid = @cid
		select @totalClosedDebit = isnull(sum(tm.transactionAmount),0) from tblDishTransactionMaster tm where tm.transactionType = 'Dr.' and tm.cid = @cid and isClosed = 1
		select @totalDiscount = sum(isnull(totalDiscount,0)) from tblDishCustomerBalance where cid = @cid
		select @advanceAmount = @totalCredit - @totalClosedDebit + @totalDiscount
		select @collectionYear = yearId from tblYear where yearName = YEAR(@collectionDate)
		if(@netAmount > 0)
		BEGIN
			--validation starts--
			if @pageNo is not null and @customerSL is not null
			begin
				select @serialNoCount = COUNT(1) from tblDishBillCollection where pageNo = @pageNo and YEAR(collectionDate) = YEAR(@collectionDate);

				if(@serialNoCount > 36)
				begin 
					RAISERROR('Serial number cannot be more than 36 pages!!',16,1)
				end
			end
			if(@rcvAmount < (@netAmount - @adjustAdvance))
			begin
				RAISERROR('You have to pay full bill!!',16,1)
			end
			if(@adjustAdvance > @advanceAmount)
			begin
				RAISERROR('Maximum Advance amount is exceed!!' ,16,1)
			end
			if (@monthlyFee > 0)
			begin
			if(@fromMonth = '0' or @toMonth = '0')
			begin
				RAISERROR('Proide monthly fee from month and to month!!',16,1)
			end
			else
			begin 
				set @fromMonthDate = cast(concat('01-',@fromMonth) as datetime)
				set @toMonthDate = cast(concat('01-',@toMonth) as datetime)
				select @minMonthBillDate = min(transactionDate) from tblDishTransactionMaster
				where cid = @cid and transactionType = 'Dr.' and billDetailId is not null and isClosed = 0;

				select @totalMonthlyBill = sum(transactionAmount) from tblDishTransactionMaster
				where cid = @cid 
					and transactionType = 'Dr.' 
					and billDetailId is not null 
					and isClosed = 0
					and transactionDate between @fromMonthDate and @toMonthDate 
				if((@fromMonthDate is not null and @toMonthDate is not null) and (@toMonthDate < @fromMonthDate))
				begin
					RAISERROR('From month cannot be smaller than To month!!',16,1)
				end
				if((@fromMonthDate is not null and @minMonthBillDate is not null) and (@minMonthBillDate < @fromMonthDate)) 
				begin
					RAISERROR('Previous monthly bill for this customer is pending!!',16,1)
				end
				if(@monthlyFee < @totalMonthlyBill)
				begin
					RAISERROR('Please pay full monthly bill',16,1)
				end
		
			end
			end
			if(@connFee > 0)
			begin
				select @totalConnectionFee = isnull(sum(tm.transactionAmount),0)  from tblDishTransactionMaster tm
				where tm.cid = @cid and tm.isConFee = 1 and isClosed = 0 and tm.transactionType = 'Dr.'

				if(@connFee <> @totalConnectionFee)
				begin
					RAISERROR('Please pay actual Connection Fee',16,1)
				end
			end

			if(@othersAmount > 0)
			begin
				select @totalOtherAmountFee = isnull(sum(tm.transactionAmount),0)  from tblDishTransactionMaster tm
				where tm.cid = @cid and tm.isOtherFee = 1 and isClosed = 0 and tm.transactionType = 'Dr.'

				if(@othersAmount <> @totalOtherAmountFee)
				begin
					RAISERROR('Please pay actual Other Fee',16,1)
				end
			end

			if(@reConnFee > 0)
			begin
				select @totalReconnectionFee = isnull(sum(tm.transactionAmount),0)  from tblDishTransactionMaster tm
				inner join tblDishCustomerRequest cr on tm.customerRequestId = cr.requestId
				inner join tblCustomerRequestType rt on cr.requestTypeId = rt.requestTypeId and rt.requestName = 'Reconnect' 
				where tm.cid = @cid and tm.isClosed = 0 and tm.transactionType = 'Dr.'

				if(@reConnFee <> @totalReconnectionFee)
				begin
					RAISERROR('Please pay actual Reconnection Fee',16,1)
				end
			end



			if(@shiftingCharge > 0)
			begin
				select @totalShiftingCharge = isnull(sum(tm.transactionAmount),0)  from tblDishTransactionMaster tm
				inner join tblDishCustomerRequest cr on tm.customerRequestId = cr.requestId
				inner join tblCustomerRequestType rt on cr.requestTypeId = rt.requestTypeId and rt.requestName = 'Shifting' 
				where tm.cid = @cid and tm.isClosed = 0 and tm.transactionType = 'Dr.'

				if(@shiftingCharge <> @totalShiftingCharge )
				begin
					RAISERROR('Please pay actual Shifting Charge',16,1)
				end
			end

			--validation ends--

			--insert into main table
			INSERT INTO [dbo].[tblDishBillCollection]
			   ([cid]
			   ,[connFee]
			   ,[reConnFee]
			   ,[othersAmount]
			   ,[monthlyFee]
			   ,[fromMonth]
			   ,[toMonth]
			   ,[shiftingCharge]
			   ,[description]
			   ,[netAmount]
			   ,[rcvAmount]
			   ,[adjustAdvance]
			   ,[discount]
			   ,[customerSL]
			   ,[pageNo]
			   ,[isAmountCollected]
			   ,[collectionDate]
			   ,[collectionYear]
			   ,[collectedBy]
			   ,[receivedBy]
			   ,[createdBy]
			   ,[createdDate])
			VALUES
			   (@cid
			   ,@connFee
			   ,@reConnFee
			   ,@othersAmount
			   ,@monthlyFee
			   ,@fromMonthDate
			   ,@toMonthDate
			   ,@shiftingCharge
			   ,@description
			   ,@netAmount
			   ,@rcvAmount
			   ,@adjustAdvance
			   ,@discount
			   ,@customerSL
			   ,@pageNo
			   ,case when (@pageNo is not null and @customerSL is not null) then 1 else 0 end
			   ,@collectionDate
			   ,@collectionYear
			   ,@collectedBy
			   ,@receivedBy
			   ,@createdBy
			   ,getdate())

			   SELECT @collectionId =  SCOPE_IDENTITY() ;
			--insert into main table ends--

			--insert into transactionmaster--
			   INSERT INTO [dbo].[tblDishTransactionMaster]
					([cid]
					,[transactionType]
					,[transactionAmount]
					,[collectionId]
					,[createdBy]
					,[createdDate]
					)
				VALUES
					(@cid
					,'Cr.'
					,@rcvAmount
					,@collectionId
					,@createdBy
					,GETDATE())
			--insert into transactionmaster end--

			--update customer balance--
				UPDATE cb
				SET 
				cb.totalCredit = cb.totalCredit + @rcvAmount,
				cb.totalBalance = cb.totalBalance +@rcvAmount,
				cb.editedBy = @createdBy,
				cb.editedDate = getdate()
				from tblDishCustomerBalance cb
				where cid = @cid
			--update customer balance ends--

				if(@monthlyFee > 0)
				begin

				   update bd 
				   set isClosed = 1,
				   collectionId = @collectionId,
				   editedBy = @createdBy,
				   editedDate = getdate()
				   from tblDishBillDetails bd
				   inner join tblDishTransactionMaster tm on tm.billDetailId = bd.billDetailId
				   where tm.billDetailId is not null
				   and tm.transactionType  = 'Dr.' and tm.isClosed = 0
				   and transactionDate between @fromMonthDate and @toMonthDate
				   and tm.cid = @cid


				   update tblDishTransactionMaster
				   set 
				   isClosed = 1,
				   collectionId = @collectionId,
				   editedBy = @createdBy,
				   editedDate = getdate()
				   where cid = @cid
				   and billDetailId is not null
				   and transactionType = 'Dr.' and isClosed = 0
				   and transactionDate between @fromMonthDate and @toMonthDate
				  

				end
			   if(@connFee > 0)
			   begin
				   update tblDishTransactionMaster
				   set 
				   isClosed = 1,
				   collectionId = @collectionId,
				   editedBy = @createdBy,
				   editedDate = getdate()
				   where cid = @cid
				   and isConFee = 1
				   and transactionType = 'Dr.' and isClosed = 0
				end

				if(@othersAmount > 0)
				begin
				   update tblDishTransactionMaster
				   set 
				   isClosed = 1,
				   collectionId = @collectionId,
				   editedBy = @createdBy,
				   editedDate = getdate()
				   where cid = @cid
				   and isOtherFee = 1
				   and transactionType = 'Dr.' and isClosed = 0
				end

			   if(@reConnFee > 0)
			   begin
					
					update  cr
					set cr.isClosed = 1,
					collectionId = @collectionId,
					cr.editedBy = @createdBy,
				    cr.editedDate = getdate()
					from tblDishCustomerRequest cr
					inner join tblDishTransactionMaster tm on cr.requestId = tm.customerRequestId  
					inner join tblCustomerRequestType rt on cr.requestTypeId = rt.requestTypeId and rt.requestName = 'Reconnected' 
					where tm.cid = @cid and tm.isClosed = 0 and tm.transactionType = 'Dr.'

					update tm
					set isClosed = 1,
					collectionId = @collectionId,
					editedBy = @createdBy,
				    editedDate = getdate()
					from tblDishTransactionMaster tm
					inner join tblDishCustomerRequest cr on tm.customerRequestId = cr.requestId
					inner join tblCustomerRequestType rt on cr.requestTypeId = rt.requestTypeId and rt.requestName = 'Reconnected' 
					where tm.cid = @cid and tm.isClosed = 0 and tm.transactionType = 'Dr.'
			   end

			   if(@shiftingCharge > 0)
			   begin
					
					update  cr
					set cr.isClosed = 1,
					collectionId = @collectionId,
					cr.editedBy = @createdBy,
				    cr.editedDate = getdate()
					from tblDishCustomerRequest cr
					inner join tblDishTransactionMaster tm on cr.requestId = tm.customerRequestId  
					inner join tblCustomerRequestType rt on cr.requestTypeId = rt.requestTypeId and rt.requestName = 'Shifting' 
					where tm.cid = @cid and tm.isClosed = 0 and tm.transactionType = 'Dr.'

					update tm
					set isClosed = 1,
					collectionId = @collectionId,
					editedBy = @createdBy,
				    editedDate = getdate()
					from tblDishTransactionMaster tm
					inner join tblDishCustomerRequest cr on tm.customerRequestId = cr.requestId
					inner join tblCustomerRequestType rt on cr.requestTypeId = rt.requestTypeId and rt.requestName = 'Shifting' 
					where tm.cid = @cid and tm.isClosed = 0 and tm.transactionType = 'Dr.'
					

			   end

			   if(@discount > 0)
			   begin
				UPDATE cb
					SET 
					cb.totalDiscount = isnull(cb.totalDiscount,0) + @discount,
					cb.totalBalance = isnull(cb.totalBalance,0) +@discount,
					cb.editedBy = @createdBy,
					cb.editedDate = getdate()
					from tblDishCustomerBalance cb
					where cid = @cid
			   end
			END
			ELSE
			BEGIN
				RAISERROR('No amount to collect',16,1)
			END

		select ('SL-'+ cast(@customerSL as varchar) + '/' + cast(@pageNo as varchar))   as collectionId
		COMMIT TRANSACTION tranc;
		
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[isp_DishCustomerBillGenerate]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Newaz Sharif
-- Create date: 15 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_DishCustomerBillGenerate]
	@cid int = null,
	@isBatch bit,
	@month varchar(20),
	@year int,
	@remarks nvarchar(300) = null, 
	@createdBy int

AS
BEGIN
	DECLARE @billSummaryId int;
	DECLARE @isAreadyExists int = 0;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	DECLARE @yearName varchar(10);
	DECLARE @disconnectionDateChecker DATETIME;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	
	BEGIN TRY
	BEGIN TRANSACTION tranc;
	print cast(@cid as varchar(20)) + '-' + cast(@isBatch as varchar(20)) + '-' + cast(@month as varchar(20)) + '-' + cast(@year as varchar(20))
		SELECT @yearName = yearName FROM tblYear where yearId = @year
		SET @disconnectionDateChecker =  CONVERT(DATETIME,@yearName+'-'+SUBSTRING(@month,1,3)+'-01')
		IF @isBatch = 1
		BEGIN
			SELECT @isAreadyExists =  COUNT(1) 
			FROM tblDishBillSummary 
			where [month] = @month and yearId = @year and isBatch =1
		END
		ELSE
		BEGIN
			SELECT @isAreadyExists =  COUNT(1) 
			FROM tblDishBillDetails
			where [month] = @month and yearId = @year and cid = @cid
		END
		IF @isAreadyExists = 0
		BEGIN

			INSERT INTO [dbo].[tblDishBillSummary]
			   ([isBatch]
			   ,[month]
			   ,[yearId]
			   ,[remarks]
			   ,[createdBy]
			   ,[createdDate])
			VALUES
			   (@isBatch
			   ,@month
			   ,@year
			   ,@remarks
			   ,@createdBy
			   ,GETDATE())

			SELECT @billSummaryId =  SCOPE_IDENTITY() ;
			IF @cid is not null and exists (select * from tblDishCustomers where id = @cid and (isDisconnected = 1 and disconnectionEffectiveDate <= @disconnectionDateChecker)) 
			BEGIN
				RAISERROR('Customer is disconnected!!',16,1) 
			END
			IF(@cid is not null and exists(select * from tblDishCustomers c
			inner join tblYear y on c.connYear = y.yearId where id = @cid
			and @disconnectionDateChecker < CONVERT(DATETIME,cast(yearName as varchar(10))+'-'+SUBSTRING(connMonth,1,3)+'-01')))
			BEGIN
				RAISERROR('Customer was not available at that time!!',16,1) 
			END


			INSERT INTO [dbo].[tblDishBillDetails]
				([billSummaryId]
				,[month]
				,[yearId]
				,[cid]
				,[billAmount]
				,[createId]
				,[createDate])
			SELECT
				@billSummaryId
				,@month
				,@year
				,id
				,monthBill
				,@createdBy
				,GETDATE()
			FROM tblDishCustomers tc
			inner join tblYear y on tc.connYear = y.yearId
			left join tblDishBillDetails bd on tc.id = bd.cid and bd.month = @month and bd.yearId = @year
			WHERE (tc.isActive = 1) and (isDisconnected = 0 or disconnectionEffectiveDate > @disconnectionDateChecker) and (@cid is null or tc.id = @cid)
			and @disconnectionDateChecker >= CONVERT(DATETIME,cast(y.yearName as varchar(10))+'-'+SUBSTRING(tc.connMonth,1,3)+'-01')
			and bd.cid is null
			

			
			UPDATE cb
			SET 
			cb.totalDebit = cb.totalDebit + bd.billAmount,
			cb.totalBalance = cb.totalBalance - bd.billAmount
			from tblDishCustomerBalance cb
			inner join tblDishBillDetails bd on cb.cid = bd.cid and bd.month = @month and bd.yearId = @year
			left join tblDishTransactionMaster tm on bd.billDetailId = tm.billDetailId and tm.transactionType = 'Dr.'
			where (@cid is null or cb.cid = @cid)
			and tm.billDetailId is null
		
			INSERT INTO [dbo].[tblDishTransactionMaster]
					([cid]
					,[transactionType]
					,[transactionAmount]
					,[customerRequestId]
					,[billDetailId]
					,[transactionMonth]
					,[transactionYear]
					,[transactionDate]
					,[createdBy]
					,[createdDate]
					)
				SELECT
					bd.cid,
					'Dr.'
					,billAmount
					,null
					,bd.billDetailId
					,@month
					,@year
					,cast('01'+@month+@yearName as datetime)
					,@createdBy
					,GETDATE()
				FROM [dbo].[tblDishBillDetails] bd
				left join tblDishTransactionMaster tm on bd.billDetailId = tm.billDetailId and tm.isConFee =0 and tm.isOtherFee = 0 and tm.transactionType = 'Dr.'
				WHERE [month] = @month and yearId = @year and (@cid is null or bd.cid = @cid)
				and tm.billDetailId is null

				--and billAmount > 0;



			END
			ELSE
			BEGIN
				DECLARE @cname varchar(20) = cast(@cid as varchar(20))
				RAISERROR(N'This Data is already processed for this month!!',16,1)
			END
			

		COMMIT TRANSACTION tranc;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END


GO
/****** Object:  StoredProcedure [dbo].[isp_DishCustomerDelete]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[isp_DishCustomerDelete]
@cid int,
@createdBy	int
as
BEGIN

         DECLARE @ErrorMessage NVARCHAR(4000)
			     ,@ErrorSeverity INT
    BEGIN TRY
	BEGIN TRANSACTION tranc;

	IF EXISTS (select cid from [dbo].[tblDishBillCollection] where cid = @cid)
    BEGIN
	       RAISERROR('You have Done Transaction with this Client so You will not be able to Delete this Customer !!',16,1)
	END
	ELSE 
	BEGIN
	    DELETE FROM tblDishCustomerRequest
		where cid = @cid

		delete from tblDishCustomerRequestHistory
		where cid = @cid

		delete from tblDishBillDetails
		where cid = @cid

		delete from tblDishTransactionMaster
		where cid = @cid

		delete from tblDishCustomerBalance
		where cid = @cid
		

		delete from tblDishCustomers
		where id = @cid



	END


COMMIT TRANSACTION tranc;
		
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[isp_DishCustomerRequest]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 15 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_DishCustomerRequest]
	@cid int,
	@requestTypeId int,
	@requestCharge decimal(8,2) = 0,
	@updatedMontlyBill decimal(8,2) = null,
	@hostId int = null,
	@zoneId int = null,
	@customerAddress nvarchar(200) = null,
	@assignedUserId int = null,
	@remarks nvarchar(300) = null, 
	@requestMonth varchar(20) = null,
	@requestYear int = null,
	@createdBy int

AS
BEGIN
	DECLARE @requestId int = 0;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	DECLARE @requestTypeName varchar(20);
	DECLARE @requestYearName varchar(10);

	SELECT @requestYearName = yearName FROM tblYear where yearId = @requestYear

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	
	BEGIN TRY
	BEGIN TRANSACTION tranc;
		INSERT INTO [dbo].[tblDishCustomerRequest]
			([cid]
			,[requestTypeId]
			,[requestCharge]
			,[updatedMontlyBill]
			,[hostId]
			,[zoneId]
			,[customerAddress]
			,[assignedUserId]
			,[requestMonth]
			,[requestYear]
			,[remarks]
			,[createdBy]
			,[createdDate]
			)
		VALUES
			(@cid
			,@requestTypeId
			,@requestCharge
			,@updatedMontlyBill
			,@hostId
			,@zoneId
			,@customerAddress
			,@assignedUserId
			,@requestMonth
			,@requestYear
			,@remarks
			,@createdBy
			,getdate());

		SELECT @requestId =  SCOPE_IDENTITY() ;
		
		IF @requestCharge > 0
		BEGIN
			INSERT INTO [dbo].[tblDishTransactionMaster]
				([cid]
				,[transactionType]
				,[transactionAmount]
				,[customerRequestId]
				,[billDetailId]
				,[transactionMonth]
				,[transactionYear]
				,[createdBy]
				,[createdDate]
				)
			VALUES
				(@cid
				,'Dr.'
				,@requestCharge
				,@requestId
				,null
				,@requestMonth
				,@requestYear
				,@createdBy
				,GETDATE())
			IF EXISTS(SELECT * FROM tblDishCustomerBalance WHERE cid = @cid)
			BEGIN
				UPDATE tblDishCustomerBalance
				SET totalDebit = totalDebit + @requestCharge,
				totalBalance = totalCredit-(totalDebit + @requestCharge)
				WHERE cid = @cid
			END
			ELSE
			BEGIN
				INSERT INTO [dbo].[tblDishCustomerBalance]
			   ([cid]
			   ,[totalDebit]
			   ,[totalCredit]
			   ,[totalBalance]
			   ,[createdBy]
			   ,[createdDate]
				)
				VALUES
			   (@cid
			   ,@requestCharge
			   ,0
			   ,0-@requestCharge
			   ,@createdBy
			   ,GETDATE()
			   )
			END
		END
		SELECT @requestTypeName = requestName FROM tblCustomerRequestType where requestTypeId = @requestTypeId
		and requestTypeGroup = 'Dish'
		IF @requestTypeName = 'Discontinue' 
		BEGIN
			UPDATE tblDishCustomers
			SET isDisconnected = 1,
			disconnectionEffectiveDate = CONVERT(DATETIME,@requestYearName+'-'+SUBSTRING(@requestMonth,1,3)+'-01'),
			disconnectionRequestId = @requestId,
			editedBy = @createdBy,
			editedDate = GETDATE()
			WHERE id = @cid
		END
		
		

		IF @requestTypeName = 'Bill Upgrade'  or @requestTypeName = 'Shifting' or @requestTypeName = 'Reconnect'
		BEGIN
			INSERT INTO [dbo].[tblDishCustomerRequestHistory]
			   ([cid]
			   ,[requestId]
			   ,[customerId]
			   ,[customerSerialId]
			   ,[customerName]
			   ,[customerPhone]
			   ,[customerAddress]
			   ,[hostId]
			   ,[zoneId]
			   ,[assignedUserId]
			   ,[connFee]
			   ,[monthBill]
			   ,[othersAmount]
			   ,[description]
			   ,[connMonth]
			   ,[connYear]
			   ,[isActive]
			   ,[isDisconnected]
			   ,[disconnectionEffectiveDate]
			   ,[disconnectionRequestId])
				
			SELECT 
				id
			   ,@requestId
			   ,customerId
			   ,customerSerialId
			   ,customerName
			   ,customerPhone
			   ,customerAddress
			   ,hostId
			   ,zoneId
			   ,assignedUserId
			   ,connFee
			   ,monthBill
			   ,othersAmount
			   ,[description]
			   ,connMonth
			   ,connYear
			   ,isActive
			   ,isDisconnected
			   ,disconnectionEffectiveDate
			   ,disconnectionRequestId
 			FROM tblDishCustomers WHERE id = @cid
			
			IF @requestTypeName = 'Bill Upgrade'
			BEGIN
				UPDATE tblDishCustomers
				SET monthBill = @updatedMontlyBill,
				editedBy = @createdBy,
				editedDate = GETDATE()
				WHERE id = @cid
			END

			IF @requestTypeName = 'Shifting' 
			BEGIN
				UPDATE tblDishCustomers
				SET hostId = @hostId,
				zoneId = @zoneId,
				customerAddress = @customerAddress,
				assignedUserId = @assignedUserId,
				editedBy = @createdBy,
				editedDate = GETDATE()
				WHERE id = @cid 
			END
			IF @requestTypeName = 'Reconnect' 
			BEGIN
				UPDATE tblDishCustomers
				SET isDisconnected = 0,
				disconnectionEffectiveDate = null,
				disconnectionRequestId = null,
				editedBy = @createdBy,
				editedDate = GETDATE()
				WHERE id = @cid
			END
		END

		COMMIT TRANSACTION tranc;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[isp_GetPassword]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[isp_GetPassword]	
@PageName nvarchar(500),
@Password nvarchar(50)
as
Begin
Declare @Status int=0;
if exists(select * from tblDeltPassword where PageName=@PageName and Password=@Password and IsActive=1)
BEGIN
     SET @Status=1;
END
SELECT @Status as  Status
END
GO
/****** Object:  StoredProcedure [dbo].[isp_host]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 17 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_host]
	
	@hostId int = 0,
	@hostName nvarchar(100),
	@hostPhone nvarchar(15) = null,
	@hostAddress nvarchar(300) = null,
	@isActive bit,
	@createdBy int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	if @hostId = 0
	begin
		INSERT INTO tblHosts
           ([hostName]
           ,[hostPhone]
           ,[hostAddress]
		   ,[isActive]
		   ,[createdBy]
		   ,[createdDate]
		   )
     VALUES
           (@hostName
           ,@hostPhone
           ,@hostAddress
           ,@isActive
           ,@createdBy
		   ,getdate());

	end

	else
	begin
		UPDATE tblHosts 
		set
		[hostName] = @hostName ,
		[hostAddress] = @hostAddress,
		[hostPhone] = @hostPhone,
		[isActive] = @isActive,
		editedBy = @createdBy,
		editedDate = getdate()
		where hostId = @hostId
	end
END

GO
/****** Object:  StoredProcedure [dbo].[isp_house]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 22 Aug 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_house]
	@houseId int = 0,
	@houseName nvarchar(20),
	@projectId varchar(30),
	@houseType nvarchar(20),
	@description nvarchar(300)=null,
	@monthlyRent decimal(8,2),
	@createdBy int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;


	BEGIN TRY
	BEGIN TRANSACTION tranc;
	
	if @houseId = 0
	begin
	print'insert'
		INSERT INTO tblHouse
           (
		   houseName,
			projectId,
			houseType,
			monthlyRent,
			[description],
			createdBy,
			createdDate
		   )
     VALUES
           (
		    @houseName,
		    @projectId,
			@houseType,
			@monthlyRent,
			@description,
			@createdBy,
		    getdate()
			);
	end

	else
	begin
	print'update'
		UPDATE tblHouse 
		set
			houseName = @houseName,
			projectId = @projectId,
			houseType = @houseType,
			monthlyRent = @monthlyRent,
			[description] = @description,
			editedBy = @createdBy,
			editedDate = getdate()
		where projectId = @projectId
		
	end
	COMMIT TRANSACTION tranc;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH
	
END
GO
/****** Object:  StoredProcedure [dbo].[isp_InternetCustomer]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 25 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_InternetCustomer]
	@insertFlag int,
	@customerId varchar(20),
	@customerSerialId int,
	@customerName nvarchar(100),
	@customerPhone nvarchar(15),
	@customerAddress nvarchar(200) = null,
	@requiredNet varchar(20) = null,
	@ipAddress varchar(20) = null,
	@hostId int,
	@zoneId int,
	@assignedUserId int,
	@connFee decimal(8, 2) = 0,
	@monthBill decimal(8, 2) = 0,
	@othersAmount decimal(8, 2) = 0,
	@description nvarchar(300) = null,
	@connMonth varchar(20),
	@connYear int,
	@isActive bit,
	@createdBy int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	declare @customerSerial varchar(20) = '';
	DECLARE @cid int;
	DECLARE @requestTypeId int;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	DECLARE @connYearName decimal;

	BEGIN TRY
	BEGIN TRANSACTION tranc;
		SELECT @customerSerial = customerSerialName from tblCustomerSerial where customerSerialId = @customerSerialId;
		SELECT @requestTypeId = requestTypeId from tblCustomerRequestType where requestName = 'Connection Fee';

		if @insertFlag = 1
		begin
			INSERT INTO tblInternetCustomers
			   (
			   customerId,
			   customerSerialId,
				customerName,
				customerPhone,
				customerAddress,
				requiredNet,
				ipAddress,
				hostId,
				zoneId,
				assignedUserId,
				connFee,
				monthBill,
				othersAmount,
				[description],
				connMonth,
				connYear,
				isActive,
				createdBy,
				createdDate
			   )
		 VALUES
			   (
				@customerId,
				@customerSerialId,
				@customerName,
				@customerPhone,
				@customerAddress,
				@requiredNet,
				@ipAddress,
				@hostId,
				@zoneId,
				@assignedUserId,
				@connFee,
				@monthBill,
				@othersAmount,
				@description,
				@connMonth,
				@connYear,
				@isActive,
				@createdBy,
				getdate()
				);
			SELECT @cid =  SCOPE_IDENTITY()
			IF @connFee > 0
			BEGIN
				INSERT INTO [dbo].[tblInternetTransactionMaster]
					([cid]
					,[transactionType]
					,[transactionAmount]
					,[isConFee]
					,[transactionMonth]
					,[transactionYear]
					,[createdBy]
					,[createdDate]
					)
				VALUES
					(@cid
					,'Dr.'
					,@connFee
					,1
					,@connMonth
					,@connYear
					,@createdBy
					,GETDATE())

				
			END
			IF @othersAmount > 0
			BEGIN
				INSERT INTO [dbo].[tblInternetTransactionMaster]
					([cid]
					,[transactionType]
					,[transactionAmount]
					,[isOtherFee]
					,[transactionMonth]
					,[transactionYear]
					,[createdBy]
					,[createdDate]
					)
				VALUES
					(@cid
					,'Dr.'
					,@othersAmount
					,1
					,@connMonth
					,@connYear
					,@createdBy
					,GETDATE())

				
			END
			INSERT INTO [dbo].[tblInternetCustomerBalance]
						([cid]
						,[totalDebit]
						,[totalCredit]
						,[totalBalance]
						,[createdBy]
						,[createdDate]
						)
						VALUES
						(@cid
						,@connFee+@othersAmount
						,0
						,0-(@connFee + @othersAmount)
						,@createdBy
						,GETDATE())

			SELECT @connYearName =  y.yearName FROM tblInternetCustomers c
			INNER JOIN tblYear y on c.connYear = y.yearId
			WHERE id = @cid;

			DECLARE @betweenMonthName varchar(20);
			DECLARE @betweenYearName int;
			DECLARE billGenCursor CURSOR 
			FOR Select betweenMonthName,betweenYearName from GetMonthListBetweenDates('01-'+@connMonth+'-' +CAST (@connYearName as varchar),DATEADD(month, -1, getdate()))

			OPEN billGenCursor
			FETCH NEXT FROM billGenCursor INTO
				@betweenMonthName
			   ,@betweenYearName
			WHILE @@FETCH_STATUS = 0
			BEGIN
				print @betweenMonthName
				print @betweenYearName
				EXEC isp_InternetCustomerBillGenerate @cid,0,@betweenMonthName,@betweenYearName,'Generated While Customer Setup',@createdBy
				FETCH NEXT FROM billGenCursor INTO
				@betweenMonthName
			   ,@betweenYearName 
			END
			CLOSE billGenCursor;
			DEALLOCATE billGenCursor;
		end

		else
		begin
			UPDATE tblInternetCustomers 
			set
				customerName = @customerName,
				customerPhone = @customerPhone,
				customerAddress = @customerAddress,
				requiredNet = @requiredNet,
				ipAddress = @ipAddress,
				hostId = @hostId,
				zoneId = @zoneId,
				assignedUserId = @assignedUserId,
				--monthBill = @monthBill,
				--othersAmount = @othersAmount,
				[description] = @description,
				--connMonth = @connMonth,
				--connYear = @connYear,
				isActive = @isActive,
				editedBy = @createdBy,
				editedDate = getdate()
			where customerId = @customerId and customerSerialId = @customerSerialId

		
		end
		SELECT ltrim(rtrim(@customerSerial)) + cast(@customerId as varchar(20)) as customerSerial
		COMMIT TRANSACTION tranc;
		END TRY
		BEGIN CATCH
			SET @ErrorMessage = ERROR_MESSAGE()
			SET @ErrorSeverity = ERROR_SEVERITY()
			RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
			ROLLBACK TRANSACTION tranc;
		END CATCH
	
END
GO
/****** Object:  StoredProcedure [dbo].[isp_InternetCustomerBillCollection]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 04 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_InternetCustomerBillCollection]
	@cid int,
	@connFee decimal(8,2) = 0,
	@reConnFee decimal(8,2) = 0,
	@othersAmount decimal(8,2) = 0,
	@monthlyFee	decimal(8,2) = 0,
	@fromMonth varchar(20) = '0',
	@toMonth varchar(20) = '0',
	@shiftingCharge	decimal(8,2) = 0,
	@description nvarchar(300) = null,
	@netAmount decimal(8,2) = 0,
	@rcvAmount decimal(8,2) = 0,
	@adjustAdvance decimal(8,2) = 0,
	@discount decimal(8,2) = 0,
	@customerSL	varchar(20) = null,
	@pageNo	varchar(20) = null,
	@collectionDate datetime,
	@collectedBy int = null,
	@receivedBy	int = null,
	@createdBy	int

AS
BEGIN
	DECLARE @ErrorMessage NVARCHAR(4000)
			,@ErrorSeverity INT
			,@fromMonthDate datetime
			,@toMonthDate datetime
			,@minMonthBillDate datetime
			,@totalMonthlyBill numeric(8,2)
			,@totalConnectionFee numeric(8,2)
			,@totalReconnectionFee numeric(8,2)
			,@totalOtherAmountFee numeric(8,2)
			,@totalShiftingCharge numeric(8,2)
			,@collectionId int = 0
			,@totalDebit numeric(8,2)
			,@totalCredit numeric(8,2)
			,@totalClosedDebit numeric(8,2)
			,@advanceAmount numeric(8,2)
			,@pageNumber int
			,@customerSerial int
			,@totalDiscount numeric(8,2)
			,@serialNoCount int
			,@collectionYear int

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	
	BEGIN TRY
	BEGIN TRANSACTION tranc;
		
		select @totalDebit = isnull(sum(tm.transactionAmount),0) from tblInternetTransactionMaster tm where tm.transactionType = 'Dr.' and tm.cid = @cid
		select @totalCredit = isnull(sum(tm.transactionAmount),0) from tblInternetTransactionMaster tm where tm.transactionType = 'Cr.' and tm.cid = @cid
		select @totalClosedDebit = isnull(sum(tm.transactionAmount),0) from tblInternetTransactionMaster tm where tm.transactionType = 'Dr.' and tm.cid = @cid and isClosed = 1
		select @totalDiscount = sum(isnull(totalDiscount,0)) from tblInternetCustomerBalance where cid = @cid
		select @advanceAmount = @totalCredit - @totalClosedDebit + @totalDiscount
		select @collectionYear = yearId from tblYear where yearName = YEAR(@collectionDate)
		if(@netAmount > 0)
		BEGIN
			--validation starts--
			if @pageNo is not null and @customerSL is not null
			begin
				select @serialNoCount = COUNT(1) from tblDishBillCollection where pageNo = @pageNo and YEAR(collectionDate) = YEAR(@collectionDate);

				if(@serialNoCount > 36)
				begin 
					RAISERROR('Serial number cannot be more than 36 pages!!',16,1)
				end
			end
			if(@rcvAmount < (@netAmount - @adjustAdvance))
			begin
				RAISERROR('You have to pay full bill!!',16,1)
			end
			if(@adjustAdvance > @advanceAmount)
			begin
				RAISERROR('Maximum Advance amount is exceed!!' ,16,1)
			end
			if (@monthlyFee > 0)
			begin
			if(@fromMonth = '0' or @toMonth = '0')
			begin
				RAISERROR('Proide monthly fee from month and to month!!',16,1)
			end
			else
			begin 
				set @fromMonthDate = cast(concat('01-',@fromMonth) as datetime)
				set @toMonthDate = cast(concat('01-',@toMonth) as datetime)
				select @minMonthBillDate = min(transactionDate) from tblInternetTransactionMaster
				where cid = @cid and transactionType = 'Dr.' and billDetailId is not null and isClosed = 0;

				select @totalMonthlyBill = sum(transactionAmount) from tblInternetTransactionMaster
				where cid = @cid 
					and transactionType = 'Dr.' 
					and billDetailId is not null 
					and isClosed = 0
					and transactionDate between @fromMonthDate and @toMonthDate 
				if((@fromMonthDate is not null and @toMonthDate is not null) and (@toMonthDate < @fromMonthDate))
				begin
					RAISERROR('From month cannot be smaller than To month!!',16,1)
				end
				if((@fromMonthDate is not null and @minMonthBillDate is not null) and (@minMonthBillDate < @fromMonthDate)) 
				begin
					RAISERROR('Previous monthly bill for this customer is pending!!',16,1)
				end
				if(@monthlyFee < @totalMonthlyBill)
				begin
					RAISERROR('Please pay full monthly bill',16,1)
				end
		
			end
			end
			if(@connFee > 0)
			begin
				select @totalConnectionFee = isnull(sum(tm.transactionAmount),0)  from tblInternetTransactionMaster tm
				where tm.cid = @cid and tm.isConFee = 1 and isClosed = 0 and tm.transactionType = 'Dr.'

				if(@connFee <> @totalConnectionFee)
				begin
					RAISERROR('Please pay actual Connection Fee',16,1)
				end
			end

			if(@othersAmount > 0)
			begin
				select @totalOtherAmountFee = isnull(sum(tm.transactionAmount),0)  from tblInternetTransactionMaster tm
				where tm.cid = @cid and tm.isOtherFee = 1 and isClosed = 0 and tm.transactionType = 'Dr.'

				if(@othersAmount <> @totalOtherAmountFee)
				begin
					RAISERROR('Please pay actual Other Fee',16,1)
				end
			end

			if(@reConnFee > 0)
			begin
				select @totalReconnectionFee = isnull(sum(tm.transactionAmount),0)  from tblInternetTransactionMaster tm
				inner join tblInternetCustomerRequest cr on tm.customerRequestId = cr.requestId
				inner join tblCustomerRequestType rt on cr.requestTypeId = rt.requestTypeId and rt.requestName = 'Reconnect' 
				where tm.cid = @cid and tm.isClosed = 0 and tm.transactionType = 'Dr.'

				if(@reConnFee <> @totalReconnectionFee)
				begin
					RAISERROR('Please pay actual Reconnection Fee',16,1)
				end
			end



			if(@shiftingCharge > 0)
			begin
				select @totalShiftingCharge = isnull(sum(tm.transactionAmount),0)  from tblInternetTransactionMaster tm
				inner join tblInternetCustomerRequest cr on tm.customerRequestId = cr.requestId
				inner join tblCustomerRequestType rt on cr.requestTypeId = rt.requestTypeId and rt.requestName = 'Shifting' 
				where tm.cid = @cid and tm.isClosed = 0 and tm.transactionType = 'Dr.'

				if(@shiftingCharge <> @totalShiftingCharge )
				begin
					RAISERROR('Please pay actual Shifting Charge',16,1)
				end
			end

			--validation ends--

			--insert into main table
			INSERT INTO [dbo].[tblInternetBillCollection]
			   ([cid]
			   ,[connFee]
			   ,[reConnFee]
			   ,[othersAmount]
			   ,[monthlyFee]
			   ,[fromMonth]
			   ,[toMonth]
			   ,[shiftingCharge]
			   ,[description]
			   ,[netAmount]
			   ,[rcvAmount]
			   ,[adjustAdvance]
			   ,[discount]
			   ,[customerSL]
			   ,[pageNo]
			   ,[isAmountCollected]
			   ,[collectionDate]
			   ,[collectionYear]
			   ,[collectedBy]
			   ,[receivedBy]
			   ,[createdBy]
			   ,[createdDate])
			VALUES
			   (@cid
			   ,@connFee
			   ,@reConnFee
			   ,@othersAmount
			   ,@monthlyFee
			   ,@fromMonthDate
			   ,@toMonthDate
			   ,@shiftingCharge
			   ,@description
			   ,@netAmount
			   ,@rcvAmount
			   ,@adjustAdvance
			   ,@discount
			   ,@customerSL
			   ,@pageNo
			   ,case when (@pageNo is not null and @customerSL is not null) then 1 else 0 end
			   ,@collectionDate
			   ,@collectionYear
			   ,@collectedBy
			   ,@receivedBy
			   ,@createdBy
			   ,getdate())

			   SELECT @collectionId =  SCOPE_IDENTITY() ;
			--insert into main table ends--

			--insert into transactionmaster--
			   INSERT INTO [dbo].[tblInternetTransactionMaster]
					([cid]
					,[transactionType]
					,[transactionAmount]
					,[collectionId]
					,[createdBy]
					,[createdDate]
					)
				VALUES
					(@cid
					,'Cr.'
					,@rcvAmount
					,@collectionId
					,@createdBy
					,GETDATE())
			--insert into transactionmaster end--

			--update customer balance--
				UPDATE cb
				SET 
				cb.totalCredit = cb.totalCredit + @rcvAmount,
				cb.totalBalance = cb.totalBalance +@rcvAmount,
				cb.editedBy = @createdBy,
				cb.editedDate = getdate()
				from tblInternetCustomerBalance cb
				where cid = @cid
			--update customer balance ends--

				if(@monthlyFee > 0)
				begin

				   update bd 
				   set isClosed = 1,
				   collectionId = @collectionId,
				   editedBy = @createdBy,
				   editedDate = getdate()
				   from tblInternetBillDetails bd
				   inner join tblInternetTransactionMaster tm on tm.billDetailId = bd.billDetailId
				   where tm.billDetailId is not null
				   and tm.transactionType  = 'Dr.' and tm.isClosed = 0
				   and transactionDate between @fromMonthDate and @toMonthDate
				   and tm.cid = @cid


				   update tblInternetTransactionMaster
				   set 
				   isClosed = 1,
				   collectionId = @collectionId,
				   editedBy = @createdBy,
				   editedDate = getdate()
				   where cid = @cid
				   and billDetailId is not null
				   and transactionType = 'Dr.' and isClosed = 0
				   and transactionDate between @fromMonthDate and @toMonthDate
				  

				end
			   if(@connFee > 0)
			   begin
				   update tblInternetTransactionMaster
				   set 
				   isClosed = 1,
				   collectionId = @collectionId,
				   editedBy = @createdBy,
				   editedDate = getdate()
				   where cid = @cid
				   and isConFee = 1
				   and transactionType = 'Dr.' and isClosed = 0
				end

				if(@othersAmount > 0)
				begin
				   update tblInternetTransactionMaster
				   set 
				   isClosed = 1,
				   collectionId = @collectionId,
				   editedBy = @createdBy,
				   editedDate = getdate()
				   where cid = @cid
				   and isOtherFee = 1
				   and transactionType = 'Dr.' and isClosed = 0
				end

			   if(@reConnFee > 0)
			   begin
					
					update  cr
					set cr.isClosed = 1,
					collectionId = @collectionId,
					cr.editedBy = @createdBy,
				    cr.editedDate = getdate()
					from tblInternetCustomerRequest cr
					inner join tblInternetTransactionMaster tm on cr.requestId = tm.customerRequestId  
					inner join tblCustomerRequestType rt on cr.requestTypeId = rt.requestTypeId and rt.requestName = 'Reconnected' 
					where tm.cid = @cid and tm.isClosed = 0 and tm.transactionType = 'Dr.'

					update tm
					set isClosed = 1,
					collectionId = @collectionId,
					editedBy = @createdBy,
				    editedDate = getdate()
					from tblInternetTransactionMaster tm
					inner join tblInternetCustomerRequest cr on tm.customerRequestId = cr.requestId
					inner join tblCustomerRequestType rt on cr.requestTypeId = rt.requestTypeId and rt.requestName = 'Reconnected' 
					where tm.cid = @cid and tm.isClosed = 0 and tm.transactionType = 'Dr.'
			   end

			   if(@shiftingCharge > 0)
			   begin
					
					update  cr
					set cr.isClosed = 1,
					collectionId = @collectionId,
					cr.editedBy = @createdBy,
				    cr.editedDate = getdate()
					from tblInternetCustomerRequest cr
					inner join tblInternetTransactionMaster tm on cr.requestId = tm.customerRequestId  
					inner join tblCustomerRequestType rt on cr.requestTypeId = rt.requestTypeId and rt.requestName = 'Shifting' 
					where tm.cid = @cid and tm.isClosed = 0 and tm.transactionType = 'Dr.'

					update tm
					set isClosed = 1,
					collectionId = @collectionId,
					editedBy = @createdBy,
				    editedDate = getdate()
					from tblInternetTransactionMaster tm
					inner join tblInternetCustomerRequest cr on tm.customerRequestId = cr.requestId
					inner join tblCustomerRequestType rt on cr.requestTypeId = rt.requestTypeId and rt.requestName = 'Shifting' 
					where tm.cid = @cid and tm.isClosed = 0 and tm.transactionType = 'Dr.'
					

			   end

			   if(@discount > 0)
			   begin
				UPDATE cb
					SET 
					cb.totalDiscount = isnull(cb.totalDiscount,0) + @discount,
					cb.totalBalance = isnull(cb.totalBalance,0) +@discount,
					cb.editedBy = @createdBy,
					cb.editedDate = getdate()
					from tblInternetCustomerBalance cb
					where cid = @cid
			   end
			END
			ELSE
			BEGIN
				RAISERROR('No amount to collect',16,1)
			END

		select ('SL-'+ cast(@customerSL as varchar) + '/' + cast(@pageNo as varchar))   as collectionId
		COMMIT TRANSACTION tranc;
		
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[isp_InternetCustomerBillGenerate]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Newaz Sharif
-- Create date: 15 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_InternetCustomerBillGenerate]
	@cid int = null,
	@isBatch bit,
	@month varchar(20),
	@year int,
	@remarks nvarchar(300) = null, 
	@createdBy int

AS
BEGIN
	DECLARE @billSummaryId int;
	DECLARE @isAreadyExists int = 0;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	DECLARE @yearName varchar(10);
	DECLARE @disconnectionDateChecker DATETIME;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	
	BEGIN TRY
	BEGIN TRANSACTION tranc;
	print cast(@cid as varchar(20)) + '-' + cast(@isBatch as varchar(20)) + '-' + cast(@month as varchar(20)) + '-' + cast(@year as varchar(20))
		SELECT @yearName = yearName FROM tblYear where yearId = @year
		SET @disconnectionDateChecker =  CONVERT(DATETIME,@yearName+'-'+SUBSTRING(@month,1,3)+'-01')
		IF @isBatch = 1
		BEGIN
			SELECT @isAreadyExists =  COUNT(1) 
			FROM tblInternetBillSummary 
			where [month] = @month and yearId = @year and isBatch =1
		END
		ELSE
		BEGIN
			SELECT @isAreadyExists =  COUNT(1) 
			FROM tblInternetBillDetails
			where [month] = @month and yearId = @year and cid = @cid
		END
		IF @isAreadyExists = 0
		BEGIN

			INSERT INTO [dbo].[tblInternetBillSummary]
			   ([isBatch]
			   ,[month]
			   ,[yearId]
			   ,[remarks]
			   ,[createdBy]
			   ,[createdDate])
			VALUES
			   (@isBatch
			   ,@month
			   ,@year
			   ,@remarks
			   ,@createdBy
			   ,GETDATE())

			SELECT @billSummaryId =  SCOPE_IDENTITY() ;
			IF @cid is not null and exists (select * from tblInternetCustomers where id = @cid and (isDisconnected = 1 and disconnectionEffectiveDate <= @disconnectionDateChecker)) 
			BEGIN
				RAISERROR('Customer is disconnected!!',16,1) 
			END
			IF(@cid is not null and exists(select * from tblInternetCustomers c
			inner join tblYear y on c.connYear = y.yearId where id = @cid
			and @disconnectionDateChecker < CONVERT(DATETIME,cast(yearName as varchar(10))+'-'+SUBSTRING(connMonth,1,3)+'-01')))
			BEGIN
				RAISERROR('Customer was not available at that time!!',16,1) 
			END


			INSERT INTO [dbo].[tblInternetBillDetails]
				([billSummaryId]
				,[month]
				,[yearId]
				,[cid]
				,[billAmount]
				,[createId]
				,[createDate])
			SELECT
				@billSummaryId
				,@month
				,@year
				,id
				,monthBill
				,@createdBy
				,GETDATE()
			FROM tblInternetCustomers tc
			inner join tblYear y on tc.connYear = y.yearId
			left join tblInternetBillDetails bd on tc.id = bd.cid and bd.month = @month and bd.yearId = @year
			WHERE (tc.isActive = 1) and (isDisconnected = 0 or disconnectionEffectiveDate > @disconnectionDateChecker) and (@cid is null or tc.id = @cid)
			and @disconnectionDateChecker >= CONVERT(DATETIME,cast(y.yearName as varchar(10))+'-'+SUBSTRING(tc.connMonth,1,3)+'-01')
			and bd.cid is null
			

			
			UPDATE cb
			SET 
			cb.totalDebit = cb.totalDebit + bd.billAmount,
			cb.totalBalance = cb.totalBalance - bd.billAmount
			from tblInternetCustomerBalance cb
			inner join tblInternetBillDetails bd on cb.cid = bd.cid and bd.month = @month and bd.yearId = @year
			left join tblInternetTransactionMaster tm on bd.billDetailId = tm.billDetailId and tm.transactionType = 'Dr.'
			where (@cid is null or cb.cid = @cid)
			and tm.billDetailId is null
		
			INSERT INTO [dbo].[tblInternetTransactionMaster]
					([cid]
					,[transactionType]
					,[transactionAmount]
					,[customerRequestId]
					,[billDetailId]
					,[transactionMonth]
					,[transactionYear]
					,[transactionDate]
					,[createdBy]
					,[createdDate]
					)
				SELECT
					bd.cid,
					'Dr.'
					,billAmount
					,null
					,bd.billDetailId
					,@month
					,@year
					,cast('01'+@month+@yearName as datetime)
					,@createdBy
					,GETDATE()
				FROM [dbo].[tblInternetBillDetails] bd
				left join tblInternetTransactionMaster tm on bd.billDetailId = tm.billDetailId and tm.isConFee =0 and tm.isOtherFee = 0 and tm.transactionType = 'Dr.'
				WHERE [month] = @month and yearId = @year and (@cid is null or bd.cid = @cid)
				and tm.billDetailId is null

				--and billAmount > 0;



			END
			ELSE
			BEGIN
				DECLARE @cname varchar(20) = cast(@cid as varchar(20))
				RAISERROR(N'This Data is already processed for this month!!',16,1)
			END
			

		COMMIT TRANSACTION tranc;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END


GO
/****** Object:  StoredProcedure [dbo].[isp_InternetCustomerDelete]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[isp_InternetCustomerDelete]
@cid int,
@createdBy	int
as
BEGIN

         DECLARE @ErrorMessage NVARCHAR(4000)
			     ,@ErrorSeverity INT
    BEGIN TRY
	BEGIN TRANSACTION tranc;

	IF EXISTS (select cid from [dbo].[tblInternetBillCollection] where cid = @cid)
    BEGIN
	       RAISERROR('You have Done Transaction with this Client so You will not be able to Delete this Customer !!',16,1)
	END
	ELSE 
	BEGIN
	    DELETE FROM tblInternetCustomerRequest
		where cid = @cid

		delete from tblInternetCustomerRequestHistory
		where cid = @cid

		delete from tblInternetBillDetails
		where cid = @cid

		delete from tblInternetTransactionMaster
		where cid = @cid

		delete from tblInternetCustomerBalance
		where cid = @cid
		

		delete from tblInternetCustomers
		where id = @cid
	END


COMMIT TRANSACTION tranc;
		
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[isp_InternetCustomerRequest]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 04 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_InternetCustomerRequest]
	@cid int,
	@requestTypeId int,
	@requestCharge decimal(8,2) = 0,
	@requiredNet varchar(20) = null,
	@updatedMontlyBill decimal(8,2) = null,
	@hostId int = null,
	@zoneId int = null,
	@customerAddress nvarchar(200) = null,
	@assignedUserId int = null,
	@remarks nvarchar(300) = null, 
	@requestMonth varchar(20) = null,
	@requestYear int = null,
	@createdBy int

AS
BEGIN
	DECLARE @requestId int = 0;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
	DECLARE @requestTypeName varchar(20);
	DECLARE @requestYearName varchar(10);

	SELECT @requestYearName = yearName FROM tblYear where yearId = @requestYear

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	
	BEGIN TRY
	BEGIN TRANSACTION tranc;
		INSERT INTO [dbo].[tblInternetCustomerRequest]
			([cid]
			,[requestTypeId]
			,[requestCharge]
			,[updatedMontlyBill]
			,[requiredNet]
			,[hostId]
			,[zoneId]
			,[customerAddress]
			,[assignedUserId]
			,[requestMonth]
			,[requestYear]
			,[remarks]
			,[createdBy]
			,[createdDate]
			)
		VALUES
			(@cid
			,@requestTypeId
			,@requestCharge
			,@updatedMontlyBill
			,@requiredNet
			,@hostId
			,@zoneId
			,@customerAddress
			,@assignedUserId
			,@requestMonth
			,@requestYear
			,@remarks
			,@createdBy
			,getdate());

		SELECT @requestId =  SCOPE_IDENTITY() ;
		
		IF @requestCharge > 0
		BEGIN
			INSERT INTO [dbo].[tblInternetTransactionMaster]
				([cid]
				,[transactionType]
				,[transactionAmount]
				,[customerRequestId]
				,[billDetailId]
				,[transactionMonth]
				,[transactionYear]
				,[createdBy]
				,[createdDate]
				)
			VALUES
				(@cid
				,'Dr.'
				,@requestCharge
				,@requestId
				,null
				,@requestMonth
				,@requestYear
				,@createdBy
				,GETDATE())
			IF EXISTS(SELECT * FROM tblInternetCustomerBalance WHERE cid = @cid)
			BEGIN
				UPDATE tblInternetCustomerBalance
				SET totalDebit = totalDebit + @requestCharge,
				totalBalance = totalCredit-(totalDebit + @requestCharge)
				WHERE cid = @cid
			END
			ELSE
			BEGIN
				INSERT INTO [dbo].[tblInternetCustomerBalance]
			   ([cid]
			   ,[totalDebit]
			   ,[totalCredit]
			   ,[totalBalance]
			   ,[createdBy]
			   ,[createdDate]
				)
				VALUES
			   (@cid
			   ,@requestCharge
			   ,0
			   ,0-@requestCharge
			   ,@createdBy
			   ,GETDATE()
			   )
			END
		END
		SELECT @requestTypeName = requestName FROM tblCustomerRequestType where requestTypeId = @requestTypeId
		and requestTypeGroup = 'Internet'
		IF @requestTypeName = 'Discontinue' 
		BEGIN
			UPDATE tblInternetCustomers
			SET isDisconnected = 1,
			disconnectionEffectiveDate = CONVERT(DATETIME,@requestYearName+'-'+SUBSTRING(@requestMonth,1,3)+'-01'),
			disconnectionRequestId = @requestId,
			editedBy = @createdBy,
			editedDate = GETDATE()
			WHERE id = @cid
		END
		
		

		IF @requestTypeName = 'Bandwidth Upgrade' or @requestTypeName = 'Bandwidth Downgrade' or @requestTypeName = 'Shifting' or @requestTypeName = 'Reconnect'
		BEGIN
			INSERT INTO [dbo].[tblInternetCustomerRequestHistory]
			   ([cid]
			   ,[requestId]
			   ,[customerId]
			   ,[customerSerialId]
			   ,[customerName]
			   ,[customerPhone]
			   ,[customerAddress]
			   ,[requiredNet]
			   ,[ipAddress]
			   ,[hostId]
			   ,[zoneId]
			   ,[assignedUserId]
			   ,[connFee]
			   ,[monthBill]
			   ,[othersAmount]
			   ,[description]
			   ,[connMonth]
			   ,[connYear]
			   ,[isActive]
			   ,[isDisconnected]
			   ,[disconnectionEffectiveDate]
			   ,[disconnectionRequestId])
				
			SELECT 
				id
			   ,@requestId
			   ,customerId
			   ,customerSerialId
			   ,customerName
			   ,customerPhone
			   ,customerAddress
			   ,requiredNet
			   ,ipAddress
			   ,hostId
			   ,zoneId
			   ,assignedUserId
			   ,connFee
			   ,monthBill
			   ,othersAmount
			   ,[description]
			   ,connMonth
			   ,connYear
			   ,isActive
			   ,isDisconnected
			   ,disconnectionEffectiveDate
			   ,disconnectionRequestId
 			FROM tblInternetCustomers WHERE id = @cid
			IF @requestTypeName = 'Bandwidth Upgrade' or @requestTypeName = 'Bandwidth Downgrade'
			BEGIN
				UPDATE tblInternetCustomers
				SET requiredNet = @requiredNet,
				monthBill = @updatedMontlyBill,
				editedBy = @createdBy,
				editedDate = GETDATE()
				WHERE id = @cid
			END
			IF @requestTypeName = 'Shifting' 
			BEGIN
				UPDATE tblInternetCustomers
				SET hostId = @hostId,
				zoneId = @zoneId,
				customerAddress = @customerAddress,
				assignedUserId = @assignedUserId,
				editedBy = @createdBy,
				editedDate = GETDATE()
				WHERE id = @cid 
			END
			IF @requestTypeName = 'Reconnect' 
			BEGIN
				UPDATE tblInternetCustomers
				SET isDisconnected = 0,
				disconnectionEffectiveDate = null,
				disconnectionRequestId = null,
				editedBy = @createdBy,
				editedDate = GETDATE()
				WHERE id = @cid
			END
		END

		COMMIT TRANSACTION tranc;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[isp_lordInfo]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 16 July 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_lordInfo]
	 @lordId int = 0
	,@ownerName nvarchar(50)
	,@companyName nvarchar(50)
	,@companyAddress nvarchar(200)
	,@phoneNo varchar(20) = null
	,@email varchar(20) = null
	,@nid varchar(20) =null
	,@createdBy int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	if @lordId = 0
	begin
		INSERT INTO tblLordInfo
           (
			 ownerName
			,companyName
			,companyAddress
			,phoneNo
			,email
			,nid
			,createdBy
			,createdDate
		   )
     VALUES
           (
		     @ownerName
			,@companyName
			,@companyAddress
			,@phoneNo
			,@email
			,@nid
			,@createdBy
		    ,getdate()
		   );

	end

	else
	begin
		UPDATE tblLordInfo 
		set
		[ownerName] = @ownerName ,
		companyName = @companyName,
		companyAddress = @companyAddress,
		phoneNo = @phoneNo,
		email = @email,
		nid = @nid,
		editedBy = @createdBy,
		editedDate = getdate()
		where lordId = @lordId
	end
END

GO
/****** Object:  StoredProcedure [dbo].[isp_Project]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 19 July 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_Project]
	@projectId int = 0,
	@projectName nvarchar(50),
	@projectType varchar(30),
	@projectAddress nvarchar(300),
	@projectDescription nvarchar(300) = null,
	@createdBy int,
	@List AS dbo.IDList READONLY

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	DECLARE @newId INT;
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;


	BEGIN TRY
	BEGIN TRANSACTION tranc;
	
	if @projectId = 0
	begin
		INSERT INTO tblProject
           (
		   projectName,
			projectType,
			projectDescription,
			projectAddress,
			createdBy,
			createdDate
		   )
     VALUES
           (
		    @projectName,
		    @projectType,
			@projectDescription,
			@projectAddress,
			@createdBy,
		    getdate()
			);
		SELECT @newId =  SCOPE_IDENTITY()
		
		INSERT INTO tblProjectCareTaker
			(projectId
			 ,careTakerId
			)
		SELECT
			@newId
			,id
			from @List 
	end

	else
	begin
		UPDATE tblProject 
		set
			projectName = @projectName,
			projectAddress = @projectAddress,
			projectDescription = @projectDescription,
			projectType = @projectType,
			editedBy = @createdBy,
			editedDate = getdate()
		where projectId = @projectId

		delete from tblProjectCareTaker
		where projectId = @projectId

		INSERT INTO tblProjectCareTaker
			(projectId
			 ,careTakerId
			)
		SELECT
			@projectId
			,id
			from @List 
		
	end
	COMMIT TRANSACTION tranc;
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH
	
END
GO
/****** Object:  StoredProcedure [dbo].[isp_registration]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 13 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_registration]
	
	@userId int = 0,
	@password nvarchar(20), 
	@userName nvarchar(100),
	@email nvarchar(100) = null,
	@phoneNumber nvarchar(15) = null,
	@address nvarchar(300) = null,
	@isAdmin bit,
	@isCableUser bit,
	@isHouseRentUser bit,
	@designationId int,
	@userFullName nvarchar(100),
	@isActive bit,
	@createdBy int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	if @userId = 0
	begin
		INSERT INTO tblUsers
           ([password]
           ,[userName]
           ,[email]
           ,[phoneNumber]
           ,[address]
           ,[isAdmin]
           ,[isCableUser]
           ,[isHouseRentUser]
		   ,[designationId]
		   ,[userFullName]
		   ,[isActive]
		   ,[createdBy]
		   ,[createdDate]
		   )
     VALUES
           (@password
           ,@userName
           ,@email
           ,@phoneNumber
           ,@address
           ,@isAdmin
           ,@isCableUser
           ,@isHouseRentUser
		   ,@designationId
		   ,@userFullName
		   ,@isActive
		   ,@createdBy
		   ,getdate());

	end

	else
	begin
		UPDATE tblUsers 
		set
		[password] = @password ,
		email = @email,
		phoneNumber = @phoneNumber,
		[address] = @address,
		isAdmin = @isAdmin,
		isCableUser = @isCableUser,
		isHouseRentUser = @isHouseRentUser,
		designationId = @designationId,
		userFullName = @userFullName,
		isActive = @isActive,
		editedBy = @createdBy,
		editedDate = getdate()
		where userId = @userId
	end

	--MERGE INTO [dbo].[tblUsers] AS t
	--USING  [dbo].[tblUsers] as s
	--ON  @userId <> 0
	--WHEN matched THEN
	--UPDATE SET
	--[password] = @password ,
	--userName = @userName,
	--email = @email,
	--phoneNumber = @phoneNumber,
	--[address] = @address,
	--isAdmin = @isAdmin,
	--isCableUser = @isCableUser,
	--isHouseRentUser = @isHouseRentUser,
	--designationId = @designationId,
	--userFullName = @userFullName
	--WHEN NOT MATCHED THEN
	--INSERT  
 --          ([password]
 --          ,[userName]
 --          ,[email]
 --          ,[phoneNumber]
 --          ,[address]
 --          ,[isAdmin]
 --          ,[isCableUser]
 --          ,[isHouseRentUser]
	--	   ,[designationId]
	--	   ,[userFullName])
 --    VALUES
 --          (@password
 --          ,@userName
 --          ,@email
 --          ,@phoneNumber
 --          ,@address
 --          ,@isAdmin
 --          ,@isCableUser
 --          ,@isHouseRentUser
	--	   ,@designationId
	--	   ,@userFullName);
END

GO
/****** Object:  StoredProcedure [dbo].[isp_usermenumapping]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 16 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_usermenumapping]
	@userId int,
	 @List AS dbo.IDList READONLY,
	 @createdBy int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	delete from tblUserPage
	where userId = @userId

	insert into tblUserPage
	(
		userId,
		pageId,
		createdBy,
		createdDate
	)
	select @userId,id,@createdBy,getdate() from @List
END

GO
/****** Object:  StoredProcedure [dbo].[isp_zone]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 17 Apr 2020
-- =============================================
CREATE PROCEDURE [dbo].[isp_zone]
	
	@zoneId int = 0,
	@zoneName nvarchar(100),
	@isActive bit,
	@createdBy int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	if @zoneId = 0
	begin
		INSERT INTO tblZones
           ([zoneName]
		   ,[isActive]
		   ,[createdBy]
		   ,[createdDate]
		   )
     VALUES
           (@zoneName
           ,@isActive
           ,@createdBy
		   ,getdate());

	end

	else
	begin
		UPDATE tblZones 
		set
		[zoneName] = @zoneName ,
		[isActive] = @isActive,
		editedBy = @createdBy,
		editedDate = getdate()
		where zoneId = @zoneId
	end
END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getDishBillCollectionByType]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 26 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getDishBillCollectionByType]
	@fromDate datetime,
	@toDate datetime,
	@cid int = 0,
	@receivedBy int = 0,
	@collectedBy int = 0,
	@ctype varchar(50)
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	IF @ctype = 'Connection Fee'
	BEGIN
	   SELECT 
		   @companyName as companyName	
		  ,@companyAddress as companyAddress
		  ,bc.cid
		  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
		  ,tc.customerName 
		  ,tc.customerPhone
		  ,isnull(bc.connFee,0) as collectionAmount
		  ,isnull(bc.customerSL,'') as customerSL
		  ,isnull(bc.pageNo,'') as pageNo
		  ,bc.collectedBy
		  ,bc.receivedBy
		  ,isnull(u1.userName,'') as collectedByString
		  ,isnull(u2.userName,'') as receivedByString
		  ,bc.collectionDate createdDate
	  FROM tblDishBillCollection bc
	  inner join tblDishCustomers tc on bc.cid = tc.id
	  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
	  left join tblUsers u1 on bc.collectedBy = u1.userId
	  left join tblUsers u2 on bc.receivedBy = u2.userId
	  where bc.collectionDate between @fromdate and DATEADD(day,1,@toDate)
	  and (@cid = 0 or bc.cid = @cid)
	  and (@receivedBy = 0 or bc.receivedBy = @receivedBy)
	  and (@collectedBy = 0 or bc.collectedBy = @collectedBy)
	  and isnull(bc.connFee,0) > 0  
	END

	ELSE IF @ctype = 'ReConnection Fee'
	BEGIN
	   SELECT 
		   @companyName as companyName	
		  ,@companyAddress as companyAddress
		  ,bc.cid
		  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
		  ,tc.customerName 
		  ,tc.customerPhone
		  ,isnull(bc.reConnFee,0) as collectionAmount
		  ,isnull(bc.customerSL,'') as customerSL
		  ,isnull(bc.pageNo,'') as pageNo
		  ,bc.collectedBy
		  ,bc.receivedBy
		  ,isnull(u1.userName,'') as collectedByString
		  ,isnull(u2.userName,'') as receivedByString
		  ,bc.collectionDate createdDate
	  FROM tblDishBillCollection bc
	  inner join tblDishCustomers tc on bc.cid = tc.id
	  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
	  left join tblUsers u1 on bc.collectedBy = u1.userId
	  left join tblUsers u2 on bc.receivedBy = u2.userId
	  where bc.collectionDate between @fromdate and DATEADD(day,1,@toDate)
	  and (@cid = 0 or bc.cid = @cid)
	  and (@receivedBy = 0 or bc.receivedBy = @receivedBy)
	  and (@collectedBy = 0 or bc.collectedBy = @collectedBy)
	  and isnull(bc.reConnFee,0) > 0  
	END


	ELSE IF @ctype = 'Monthly Fee'
	BEGIN
	   SELECT 
		   @companyName as companyName	
		  ,@companyAddress as companyAddress
		  ,bc.cid
		  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
		  ,tc.customerName 
		  ,tc.customerPhone
		  ,isnull(bc.monthlyFee,0) as collectionAmount
		  ,isnull(bc.customerSL,'') as customerSL
		  ,isnull(bc.pageNo,'') as pageNo
		  ,bc.collectedBy
		  ,bc.receivedBy
		  ,isnull(u1.userName,'') as collectedByString
		  ,isnull(u2.userName,'') as receivedByString
		  ,bc.collectionDate createdDate
	  FROM tblDishBillCollection bc
	  inner join tblDishCustomers tc on bc.cid = tc.id
	  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
	  left join tblUsers u1 on bc.collectedBy = u1.userId
	  left join tblUsers u2 on bc.receivedBy = u2.userId
	  where bc.collectionDate between @fromdate and DATEADD(day,1,@toDate)
	  and (@cid = 0 or bc.cid = @cid)
	  and (@receivedBy = 0 or bc.receivedBy = @receivedBy)
	  and (@collectedBy = 0 or bc.collectedBy = @collectedBy)
	  and isnull(bc.monthlyFee,0) > 0  
	END
	ELSE IF @ctype = 'Shifting Charge'
	BEGIN
	   SELECT 
		   @companyName as companyName	
		  ,@companyAddress as companyAddress
		  ,bc.cid
		  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
		  ,tc.customerName 
		  ,tc.customerPhone
		  ,isnull(bc.shiftingCharge,0) as collectionAmount
		  ,isnull(bc.customerSL,'') as customerSL
		  ,isnull(bc.pageNo,'') as pageNo
		  ,bc.collectedBy
		  ,bc.receivedBy
		  ,isnull(u1.userName,'') as collectedByString
		  ,isnull(u2.userName,'') as receivedByString
		  ,bc.collectionDate createdDate
	  FROM tblDishBillCollection bc
	  inner join tblDishCustomers tc on bc.cid = tc.id
	  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
	  left join tblUsers u1 on bc.collectedBy = u1.userId
	  left join tblUsers u2 on bc.receivedBy = u2.userId
	  where bc.collectionDate between @fromdate and DATEADD(day,1,@toDate)
	  and (@cid = 0 or bc.cid = @cid)
	  and (@receivedBy = 0 or bc.receivedBy = @receivedBy)
	  and (@collectedBy = 0 or bc.collectedBy = @collectedBy)
	  and isnull(bc.shiftingCharge,0) > 0  
	END
 

END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getDishBillCollections]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 26 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getDishBillCollections]
	@fromDate datetime,
	@toDate datetime,
	@cid int = 0,
	@receivedBy int = 0,
	@collectedBy int = 0
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	SELECT 
	   @companyName as companyName	
      ,@companyAddress as companyAddress
	  ,bc.cid
	  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
	  ,tc.customerName 
	  ,tc.customerPhone
      ,isnull(bc.connFee,0) connFee
      ,isnull(bc.reConnFee,0) reConnFee
      ,isnull(bc.othersAmount,0) othersAmount
      ,isnull(bc.monthlyFee,0) monthlyFee
      ,isnull(bc.shiftingCharge,0) shiftingCharge
      ,isnull(bc.netAmount,0) netAmount
	  ,ISNULL(bc.discount,0) discount
      ,isnull(bc.rcvAmount,0) rcvAmount
      ,isnull(bc.adjustAdvance,0) adjustAdvance
      ,isnull(bc.customerSL,'') as customerSL
      ,isnull(bc.pageNo,'') as pageNo
      ,bc.collectedBy
      ,bc.receivedBy
	  ,isnull(u1.userName,'') as collectedByString
	  ,isnull(u2.userName,'') as receivedByString
	  ,bc.collectionDate createdDate

  FROM tblDishBillCollection bc
  inner join tblDishCustomers tc on bc.cid = tc.id
  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
  left join tblUsers u1 on bc.collectedBy = u1.userId
  left join tblUsers u2 on bc.receivedBy = u2.userId
  where bc.collectionDate between @fromdate and DATEADD(day,1,@toDate)
  and (@cid = 0 or bc.cid = @cid)
  and (@receivedBy = 0 or bc.receivedBy = @receivedBy)
  and(@collectedBy = 0 or bc.collectedBy = @collectedBy)

END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getDishBillPaymentHistory]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 03 July 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getDishBillPaymentHistory]
	@cid int = 0
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	SELECT 
	   @companyName as companyName	
      ,@companyAddress as companyAddress
	  ,bc.cid
	  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
	  ,tc.customerName 
	  ,tc.customerPhone
      ,isnull(bc.connFee,0) connFee
      ,isnull(bc.reConnFee,0) reConnFee
      ,isnull(bc.othersAmount,0) othersAmount
      ,isnull(bc.monthlyFee,0) monthlyFee
      ,isnull(bc.shiftingCharge,0) shiftingCharge
      ,isnull(bc.netAmount,0) netAmount
      ,isnull(bc.rcvAmount,0) rcvAmount
      ,isnull(bc.adjustAdvance,0) adjustAdvance
      ,isnull(bc.customerSL,'') as customerSL
      ,isnull(bc.pageNo,'') as pageNo
	  ,ISNULL(bc.discount,0) as discount
      ,bc.collectedBy
      ,bc.receivedBy
	  ,isnull(u1.userName,'') as collectedByString
	  ,isnull(u2.userName,'') as receivedByString
	  ,bc.collectionDate createdDate

  FROM tblDishBillCollection bc
  inner join tblDishCustomers tc on bc.cid = tc.id
  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
  left join tblUsers u1 on bc.collectedBy = u1.userId
  left join tblUsers u2 on bc.receivedBy = u2.userId
  where (@cid = 0 or bc.cid = @cid)
  order by bc.collectionId desc
  
END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getDishCollectionPageWise]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 05 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getDishCollectionPageWise]
	 @yearId int
	,@pageNo int = 0
	,@receivedBy int
AS
BEGIN
	SELECT 
	   
	   bc.collectionId
      ,bc.cid
	  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(c.customerId)) as customerSerial
	  ,c.customerName 
      ,c.customerPhone
      ,bc.rcvAmount 
      ,bc.customerSL
      ,bc.pageNo
      ,uc.userFullName as collectedByString
      ,ur.userFullName as receivedByString
	  ,case when bc.createdDate is null then '' else convert(varchar, bc.createdDate, 103) end as createdDateString
	  ,case when bc.collectionDate is null then '' else convert(varchar, bc.collectionDate, 103) end as receivedDateString
  FROM tblDishBillCollection bc
  inner join tblDishCustomers c on bc.cid = c.id
  inner join tblCustomerSerial cs on c.customerSerialId = cs.customerSerialId
  inner join tblUsers uc on bc.collectedBy = uc.userId
  inner join tblUsers ur on bc.receivedBy = ur.userId

  where 
  (@pageNo = 0 or pageNo = @pageNo)
  and (receivedBy = @receivedBy)
  and (collectionYear = @yearId)
  order by bc.customerSL,bc.pageNo,bc.collectionYear
END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getDishCustomerDue]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 01 July 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getDishCustomerDue]
	@zoneId int = 0
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	
	;with monthlyBill as
	(
		select cid,sum(isnull(BillAmount,0)) as BillAmount,'Monthly' as dueType,z.zoneName from tblDishBillDetails bd
		inner join tblDishCustomers c on bd.cid = c.id
		inner join tblZones z on c.zoneId = z.zoneId
		where  isClosed = 0 and (@zoneId = 0 or c.zoneId = @zoneId)
		group by cid,z.zoneName
		
	),
	ReconnFee as(
		select cid, sum(isnull(requestCharge,0)) as reconCharge ,'ReconnFee' as dueType,z.zoneName from tblDishCustomerRequest cr
		inner join tblCustomerRequestType crt on cr.requestTypeId = crt.requestTypeId
		inner join tblDishCustomers c on cr.cid = c.id
		inner join tblZones z on c.zoneId = z.zoneId
		where crt.requestName = 'Reconnect'
		and isClosed = 0
		group by cid,z.zoneName
	),
	ShiftFee as(
		select cid, sum(isnull(requestCharge,0)) as shiftCharge ,'ShiftFee' as dueType,z.zoneName from tblDishCustomerRequest cr
		inner join tblCustomerRequestType crt on cr.requestTypeId = crt.requestTypeId
		inner join tblDishCustomers c on cr.cid = c.id
		inner join tblZones z on c.zoneId = z.zoneId
		where crt.requestName = 'Shifting'
		and isClosed = 0 and (@zoneId = 0 or c.zoneId = @zoneId)
		group by cid,z.zoneName
	),
	ConnFee as(
		select cid,sum(isnull(transactionAmount,0)) as connCharge, 'ConnFee' as dueType,z.zoneName from tblDishTransactionMaster tm
		inner join tblDishCustomers c on tm.cid = c.id
		inner join tblZones z on c.zoneId = z.zoneId
		where transactionType = 'Dr.' and isConFee = 1 and isClosed = 0 and (@zoneId = 0 or c.zoneId = @zoneId)
		group by cid,z.zoneName
	),
	OtherFee as(
		select cid,sum(isnull(transactionAmount,0)) as otherCharge, 'OtherFee' as dueType,z.zoneName from tblDishTransactionMaster tm
		inner join tblDishCustomers c on tm.cid = c.id
		inner join tblZones z on c.zoneId = z.zoneId
		where transactionType = 'Dr.' and isOtherFee = 1 and isClosed = 0 and (@zoneId = 0 or c.zoneId = @zoneId)
		group by cid,z.zoneName
	)
	,Due as
	(
		select case when m.cid is not null then m.cid
		when r.cid is not null then r.cid
		when s.cid is not null then s.cid  
		when c.cid is not null then c.cid
		when o.cid is not null then o.cid end as cid,
		case when m.zoneName is not null then m.zoneName
		when r.zoneName is not null then r.zoneName
		when s.zoneName is not null then s.zoneName  
		when c.zoneName is not null then c.zoneName
		when o.zoneName is not null then o.zoneName end as zoneName,
		isnull(billAmount,0) billAmount,
		isnull(reconCharge,0) reconCharge,
		isnull(shiftCharge,0) shiftCharge,
		isnull(connCharge,0) connCharge,
		isnull(otherCharge,0) otherCharge
		from monthlyBill m
		full outer join ReconnFee r on m.cid = r.cid 
		full outer join ShiftFee s on m.cid = s.cid
		full outer join ConnFee c on m.cid = c.cid
		full outer join OtherFee o on m.cid = o.cid
	)

	select 
		 cid
		,zoneName
		,@companyName as companyName
		,@companyAddress as companyAddress
		,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
		,tc.customerName
		,tc.customerPhone
		,billAmount monthlyFee
		,reconCharge reConnFee
		,shiftCharge shiftingCharge
		,connCharge connFee
		,otherCharge othersAmount
		,billAmount + reconCharge + shiftCharge + connCharge +otherCharge as totalDue
	from Due
	inner join tblDishCustomers tc on due.cid = tc.id
	inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
	where billAmount + reconCharge + shiftCharge + connCharge +otherCharge > 0


END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getDishCustomers]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 26 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getDishCustomers]
	@isActive bit = null,
	@zoneId	int = 0,
	@cid int = 0
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)
	
	SELECT 
		companyName
		,companyAddress
		,id
		,customerId
		,customerSerialId
		,customerSerial
		,customerName
		,customerPhone
		,customerAddress
		,hostId
		,hostName
		,hostPhone
		,hostAddress
		,zoneId
		,zoneName
		,assignedUserId
		,assignedUserName
		,connFee
		,monthBill
		,othersAmount
		,description
		,connMonth
		,connYear
		,connYearName
		,isActive
		,case when isActive = 1 then 'Yes' else 'No' end isActiveString
		,isDisconnectedString
		 FROM
		 (
			 SELECT 
					@companyName as companyName,
					@companyAddress companyAddress,
					id,
					customerId,
					dc.customerSerialId,
					cast(ltrim(rtrim(customerSerialName)) as varchar) + cast(dc.customerId as varchar(20)) as customerSerial, 
					customerName,
					customerPhone,
					customerAddress,
					dc.hostId,
					h.hostName,
					h.hostPhone,
					h.hostAddress,
					dc.zoneId,
					z.zoneName,
					assignedUserId,
					isnull(u.userName,'') as assignedUserName,
					connFee,
					monthBill,
					othersAmount,
					[description],
					case when connMonth = '0' then '' else connMonth end as connMonth,
					connYear,
					y.yearName as connYearName,
					case when dc.isActive = 1 and (dc.isDisconnected = 0 or (disconnectionEffectiveDate > getdate()))  then 1 else 0 end isActive,
					case when dc.isDisconnected = 0 or(disconnectionEffectiveDate > getdate())then 'No' else 'Yes' end isDisconnectedString
			FROM tblDishCustomers dc
			left JOIN tblCustomerSerial cs on dc.customerSerialId = cs.customerSerialId
			left join tblHosts h on dc.hostId = h.hostId
			left join tblZones z on dc.zoneId = z.zoneId
			left join tblUsers u on dc.assignedUserId = u.userId
			left join tblYear y on dc.connYear = y.yearId
			WHERE  (@zoneId = 0 or dc.zoneId = @zoneId)
			and (@cid = 0 or dc.id = @cid)
	) a
	where @isActive is null or a.isActive = @isActive

END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getInternetBillCollectionByType]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 26 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getInternetBillCollectionByType]
	@fromDate datetime,
	@toDate datetime,
	@cid int = 0,
	@receivedBy int = 0,
	@collectedBy int = 0,
	@ctype varchar(50)
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	IF @ctype = 'Connection Fee'
	BEGIN
	   SELECT 
		   @companyName as companyName	
		  ,@companyAddress as companyAddress
		  ,bc.cid
		  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
		  ,tc.customerName 
		  ,tc.customerPhone
		  ,isnull(bc.connFee,0) as collectionAmount
		  ,isnull(bc.customerSL,'') as customerSL
		  ,isnull(bc.pageNo,'') as pageNo
		  ,bc.collectedBy
		  ,bc.receivedBy
		  ,isnull(u1.userName,'') as collectedByString
		  ,isnull(u2.userName,'') as receivedByString
		  ,bc.collectionDate createdDate
	  FROM tblInternetBillCollection bc
	  inner join tblInternetCustomers tc on bc.cid = tc.id
	  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
	  left join tblUsers u1 on bc.collectedBy = u1.userId
	  left join tblUsers u2 on bc.receivedBy = u2.userId
	  where bc.collectionDate between @fromdate and DATEADD(day,1,@toDate)
	  and (@cid = 0 or bc.cid = @cid)
	  and (@receivedBy = 0 or bc.receivedBy = @receivedBy)
	  and (@collectedBy = 0 or bc.collectedBy = @collectedBy)
	  and isnull(bc.connFee,0) > 0  
	END

	ELSE IF @ctype = 'ReConnection Fee'
	BEGIN
	   SELECT 
		   @companyName as companyName	
		  ,@companyAddress as companyAddress
		  ,bc.cid
		  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
		  ,tc.customerName 
		  ,tc.customerPhone
		  ,isnull(bc.reConnFee,0) as collectionAmount
		  ,isnull(bc.customerSL,'') as customerSL
		  ,isnull(bc.pageNo,'') as pageNo
		  ,bc.collectedBy
		  ,bc.receivedBy
		  ,isnull(u1.userName,'') as collectedByString
		  ,isnull(u2.userName,'') as receivedByString
		  ,bc.collectionDate createdDate
	  FROM tblInternetBillCollection bc
	  inner join tblInternetCustomers tc on bc.cid = tc.id
	  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
	  left join tblUsers u1 on bc.collectedBy = u1.userId
	  left join tblUsers u2 on bc.receivedBy = u2.userId
	  where bc.collectionDate between @fromdate and DATEADD(day,1,@toDate)
	  and (@cid = 0 or bc.cid = @cid)
	  and (@receivedBy = 0 or bc.receivedBy = @receivedBy)
	  and (@collectedBy = 0 or bc.collectedBy = @collectedBy)
	  and isnull(bc.reConnFee,0) > 0  
	END


	ELSE IF @ctype = 'Monthly Fee'
	BEGIN
	   SELECT 
		   @companyName as companyName	
		  ,@companyAddress as companyAddress
		  ,bc.cid
		  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
		  ,tc.customerName 
		  ,tc.customerPhone
		  ,isnull(bc.monthlyFee,0) as collectionAmount
		  ,isnull(bc.customerSL,'') as customerSL
		  ,isnull(bc.pageNo,'') as pageNo
		  ,bc.collectedBy
		  ,bc.receivedBy
		  ,isnull(u1.userName,'') as collectedByString
		  ,isnull(u2.userName,'') as receivedByString
		  ,bc.collectionDate createdDate
	  FROM tblInternetBillCollection bc
	  inner join tblInternetCustomers tc on bc.cid = tc.id
	  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
	  left join tblUsers u1 on bc.collectedBy = u1.userId
	  left join tblUsers u2 on bc.receivedBy = u2.userId
	  where bc.collectionDate between @fromdate and DATEADD(day,1,@toDate)
	  and (@cid = 0 or bc.cid = @cid)
	  and (@receivedBy = 0 or bc.receivedBy = @receivedBy)
	  and (@collectedBy = 0 or bc.collectedBy = @collectedBy)
	  and isnull(bc.monthlyFee,0) > 0  
	END
	ELSE IF @ctype = 'Shifting Charge'
	BEGIN
	   SELECT 
		   @companyName as companyName	
		  ,@companyAddress as companyAddress
		  ,bc.cid
		  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
		  ,tc.customerName 
		  ,tc.customerPhone
		  ,isnull(bc.shiftingCharge,0) as collectionAmount
		  ,isnull(bc.customerSL,'') as customerSL
		  ,isnull(bc.pageNo,'') as pageNo
		  ,bc.collectedBy
		  ,bc.receivedBy
		  ,isnull(u1.userName,'') as collectedByString
		  ,isnull(u2.userName,'') as receivedByString
		  ,bc.collectionDate createdDate
	  FROM tblInternetBillCollection bc
	  inner join tblInternetCustomers tc on bc.cid = tc.id
	  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
	  left join tblUsers u1 on bc.collectedBy = u1.userId
	  left join tblUsers u2 on bc.receivedBy = u2.userId
	  where bc.collectionDate between @fromdate and DATEADD(day,1,@toDate)
	  and (@cid = 0 or bc.cid = @cid)
	  and (@receivedBy = 0 or bc.receivedBy = @receivedBy)
	  and (@collectedBy = 0 or bc.collectedBy = @collectedBy)
	  and isnull(bc.shiftingCharge,0) > 0  
	END
 

END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getInternetBillCollections]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 26 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getInternetBillCollections]
	@fromDate datetime,
	@toDate datetime,
	@cid int = 0,
	@receivedBy int = 0,
	@collectedBy int = 0
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	SELECT 
	   @companyName as companyName	
      ,@companyAddress as companyAddress
	  ,bc.cid
	  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
	  ,tc.customerName 
	  ,tc.customerPhone
      ,isnull(bc.connFee,0) connFee
      ,isnull(bc.reConnFee,0) reConnFee
      ,isnull(bc.othersAmount,0) othersAmount
      ,isnull(bc.monthlyFee,0) monthlyFee
      ,isnull(bc.shiftingCharge,0) shiftingCharge
      ,isnull(bc.netAmount,0) netAmount
      ,isnull(bc.rcvAmount,0) rcvAmount
      ,isnull(bc.adjustAdvance,0) adjustAdvance
      ,isnull(bc.customerSL,'') as customerSL
      ,isnull(bc.pageNo,'') as pageNo
      ,bc.collectedBy
      ,bc.receivedBy
	  ,isnull(u1.userName,'') as collectedByString
	  ,isnull(u2.userName,'') as receivedByString
	  ,bc.collectionDate createdDate

  FROM tblInternetBillCollection bc
  inner join tblInternetCustomers tc on bc.cid = tc.id
  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
  left join tblUsers u1 on bc.collectedBy = u1.userId
  left join tblUsers u2 on bc.receivedBy = u2.userId
  where bc.collectionDate between @fromdate and DATEADD(day,1,@toDate)
  and (@cid = 0 or bc.cid = @cid)
  and (@receivedBy = 0 or bc.receivedBy = @receivedBy)
  and(@collectedBy = 0 or bc.collectedBy = @collectedBy)

END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getInternetBillGenerateMonthWise]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 01 Jul 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getInternetBillGenerateMonthWise]
	@month varchar(20),
	@yearId int
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)
	
	
	SELECT 
		@companyName as companyName,
		@companyAddress companyAddress,
		cast(ltrim(rtrim(customerSerialName)) as varchar) + cast(dc.customerId as varchar(20)) as customerSerial, 
		customerName,
		bd.billAmount,
		bd.month,
		y.yearName		
		from tblDishBillDetails bd
		inner join tblInternetCustomers dc on bd.cid = dc.id
		inner join tblYear y on dc.connYear = y.yearId
		INNER JOIN tblCustomerSerial cs on dc.customerSerialId = cs.customerSerialId
	where bd.month = @month and bd.yearId = @yearId
	

END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getInternetBillPaymentHistory]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 03 July 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getInternetBillPaymentHistory]
	@cid int = 0
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	SELECT 
	   @companyName as companyName	
      ,@companyAddress as companyAddress
	  ,bc.cid
	  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
	  ,tc.customerName 
	  ,tc.customerPhone
      ,isnull(bc.connFee,0) connFee
      ,isnull(bc.reConnFee,0) reConnFee
      ,isnull(bc.othersAmount,0) othersAmount
      ,isnull(bc.monthlyFee,0) monthlyFee
      ,isnull(bc.shiftingCharge,0) shiftingCharge
      ,isnull(bc.netAmount,0) netAmount
      ,isnull(bc.rcvAmount,0) rcvAmount
      ,isnull(bc.adjustAdvance,0) adjustAdvance
      ,isnull(bc.customerSL,'') as customerSL
      ,isnull(bc.pageNo,'') as pageNo
	  ,ISNULL(bc.discount,0) as discount
      ,bc.collectedBy
      ,bc.receivedBy
	  ,isnull(u1.userName,'') as collectedByString
	  ,isnull(u2.userName,'') as receivedByString
	  ,bc.collectionDate createdDate

  FROM tblInternetBillCollection bc
  inner join tblInternetCustomers tc on bc.cid = tc.id
  inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
  left join tblUsers u1 on bc.collectedBy = u1.userId
  left join tblUsers u2 on bc.receivedBy = u2.userId
  where (@cid = 0 or bc.cid = @cid)
  order by bc.collectionId desc

END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getInternetCollectionPageWise]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 05 May 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getInternetCollectionPageWise]
	 @yearId int
	,@pageNo int = 0
	,@receivedBy int
AS
BEGIN
	SELECT 
	   
	   bc.collectionId
      ,bc.cid
	  ,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(c.customerId)) as customerSerial
	  ,c.customerName 
      ,c.customerPhone
      ,bc.rcvAmount 
      ,bc.customerSL
      ,bc.pageNo
      ,uc.userFullName as collectedByString
      ,ur.userFullName as receivedByString
	  ,case when bc.createdDate is null then '' else convert(varchar, bc.createdDate, 103) end as createdDateString
	  ,case when bc.collectionDate is null then '' else convert(varchar, bc.collectionDate, 103) end as receivedDateString
  FROM tblInternetBillCollection bc
  inner join tblInternetCustomers c on bc.cid = c.id
  inner join tblCustomerSerial cs on c.customerSerialId = cs.customerSerialId
  inner join tblUsers uc on bc.collectedBy = uc.userId
  inner join tblUsers ur on bc.receivedBy = ur.userId

  where 
  (@pageNo = 0 or pageNo = @pageNo)
  and (receivedBy = @receivedBy)
  and (collectionYear = @yearId)
  order by bc.customerSL,bc.pageNo,bc.collectionYear
END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getInternetCustomerDue]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 01 July 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getInternetCustomerDue]
	@zoneId int = 0
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)

	
	;with monthlyBill as
	(
		select cid,sum(isnull(BillAmount,0)) as BillAmount,'Monthly' as dueType,z.zoneName from tblInternetBillDetails bd
		inner join tblInternetCustomers c on bd.cid = c.id
		inner join tblZones z on c.zoneId = z.zoneId
		where  isClosed = 0 and (@zoneId = 0 or c.zoneId = @zoneId)
		group by cid,z.zoneName
		
	),
	ReconnFee as(
		select cid, sum(isnull(requestCharge,0)) as reconCharge ,'ReconnFee' as dueType,z.zoneName from tblInternetCustomerRequest cr
		inner join tblCustomerRequestType crt on cr.requestTypeId = crt.requestTypeId
		inner join tblInternetCustomers c on cr.cid = c.id
		inner join tblZones z on c.zoneId = z.zoneId
		where crt.requestName = 'Reconnect'
		and isClosed = 0
		group by cid,z.zoneName
	),
	ShiftFee as(
		select cid, sum(isnull(requestCharge,0)) as shiftCharge ,'ShiftFee' as dueType,z.zoneName from tblInternetCustomerRequest cr
		inner join tblCustomerRequestType crt on cr.requestTypeId = crt.requestTypeId
		inner join tblInternetCustomers c on cr.cid = c.id
		inner join tblZones z on c.zoneId = z.zoneId
		where crt.requestName = 'Shifting'
		and isClosed = 0 and (@zoneId = 0 or c.zoneId = @zoneId)
		group by cid,z.zoneName
	),
	ConnFee as(
		select cid,sum(isnull(transactionAmount,0)) as connCharge, 'ConnFee' as dueType,z.zoneName from tblInternetTransactionMaster tm
		inner join tblInternetCustomers c on tm.cid = c.id
		inner join tblZones z on c.zoneId = z.zoneId
		where transactionType = 'Dr.' and isConFee = 1 and isClosed = 0 and (@zoneId = 0 or c.zoneId = @zoneId)
		group by cid,z.zoneName
	),
	OtherFee as(
		select cid,sum(isnull(transactionAmount,0)) as otherCharge, 'OtherFee' as dueType,z.zoneName from tblInternetTransactionMaster tm
		inner join tblInternetCustomers c on tm.cid = c.id
		inner join tblZones z on c.zoneId = z.zoneId
		where transactionType = 'Dr.' and isOtherFee = 1 and isClosed = 0 and (@zoneId = 0 or c.zoneId = @zoneId)
		group by cid,z.zoneName
	)
	,Due as
	(
		select case when m.cid is not null then m.cid
		when r.cid is not null then r.cid
		when s.cid is not null then s.cid  
		when c.cid is not null then c.cid
		when o.cid is not null then o.cid end as cid,
		case when m.zoneName is not null then m.zoneName
		when r.zoneName is not null then r.zoneName
		when s.zoneName is not null then s.zoneName  
		when c.zoneName is not null then c.zoneName
		when o.zoneName is not null then o.zoneName end as zoneName,
		isnull(billAmount,0) billAmount,
		isnull(reconCharge,0) reconCharge,
		isnull(shiftCharge,0) shiftCharge,
		isnull(connCharge,0) connCharge,
		isnull(otherCharge,0) otherCharge
		from monthlyBill m
		full outer join ReconnFee r on m.cid = r.cid 
		full outer join ShiftFee s on m.cid = s.cid
		full outer join ConnFee c on m.cid = c.cid
		full outer join OtherFee o on m.cid = o.cid
	)

	select 
		 cid
		,zoneName
		,@companyName as companyName
		,@companyAddress as companyAddress
		,ltrim(rtrim(cs.customerSerialName)) +ltrim(rtrim(tc.customerId)) as customerSerial
		,tc.customerName
		,tc.customerPhone
		,billAmount monthlyFee
		,reconCharge reConnFee
		,shiftCharge shiftingCharge
		,connCharge connFee
		,otherCharge othersAmount
		,billAmount + reconCharge + shiftCharge + connCharge +otherCharge as totalDue
	from Due
	inner join tblInternetCustomers tc on due.cid = tc.id
	inner join tblCustomerSerial cs on tc.customerSerialId = cs.customerSerialId
	where billAmount + reconCharge + shiftCharge + connCharge +otherCharge > 0


END

GO
/****** Object:  StoredProcedure [dbo].[rsp_getInternetCustomers]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 26 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[rsp_getInternetCustomers]
	@isActive bit = null,
	@zoneId	int = 0,
	@cid int = 0
AS
BEGIN
	DECLARE @companyName nvarchar(50),
			@companyAddress nvarchar(300)

	SET @companyName = dbo.getCompanyName(1)
	SET @companyAddress = dbo.getCompanyAddress(1)
	
	SELECT 
		companyName
		,companyAddress
		,id
		,customerId
		,customerSerialId
		,customerSerial
		,customerName
		,customerPhone
		,customerAddress
		,hostId
		,hostName
		,hostPhone
		,hostAddress
		,zoneId
		,zoneName
		,assignedUserId
		,assignedUserName
		,connFee
		,monthBill
		,othersAmount
		,description
		,connMonth
		,connYear
		,connYearName
		,isActive
		,case when isActive = 1 then 'Yes' else 'No' end isActiveString
		,isDisconnectedString
		 FROM
		 (
			 SELECT 
					@companyName as companyName,
					@companyAddress companyAddress,
					id,
					customerId,
					dc.customerSerialId,
					cast(ltrim(rtrim(customerSerialName)) as varchar) + cast(dc.customerId as varchar(20)) as customerSerial, 
					customerName,
					customerPhone,
					customerAddress,
					dc.hostId,
					h.hostName,
					h.hostPhone,
					h.hostAddress,
					dc.zoneId,
					z.zoneName,
					assignedUserId,
					isnull(u.userName,'') as assignedUserName,
					connFee,
					monthBill,
					othersAmount,
					[description],
					case when connMonth = '0' then '' else connMonth end as connMonth,
					connYear,
					y.yearName as connYearName,
					case when dc.isActive = 1 and (dc.isDisconnected = 0 or (disconnectionEffectiveDate > getdate()))  then 1 else 0 end isActive,
					case when dc.isDisconnected = 0 or(disconnectionEffectiveDate > getdate())then 'No' else 'Yes' end isDisconnectedString
			FROM tblInternetCustomers dc
			INNER JOIN tblCustomerSerial cs on dc.customerSerialId = cs.customerSerialId
			left join tblHosts h on dc.hostId = h.hostId
			left join tblZones z on dc.zoneId = z.zoneId
			left join tblUsers u on dc.assignedUserId = u.userId
			left join tblYear y on dc.connYear = y.yearId
			WHERE  (@zoneId = 0 or dc.zoneId = @zoneId)
			and (@cid = 0 or dc.id = @cid)
	) a
	where @isActive is null or a.isActive = @isActive

END

GO
/****** Object:  StoredProcedure [dbo].[takeBackup]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[takeBackup]	
AS
BEGIN
   DECLARE @ErrorMessage NVARCHAR(4000)
			     ,@ErrorSeverity INT

   BEGIN TRY
    Declare @filePath nvarchar(max)='D:\New folder'

	DECLARE @fileName nvarchar(50) = format(getdate(),'yyyyMMddHHmmssffff') + '.bak'
	DECLARE @fullFileNameWithPath nvarchar(120) = @filePath+'\'+@fileName
	BACKUP DATABASE PCOHRAppDB
	TO DISK = @fullFileNameWithPath;

END TRY
	BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
		ROLLBACK TRANSACTION tranc;
	END CATCH
	end


GO
/****** Object:  StoredProcedure [dbo].[usp_updateDishCollectionStatus]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 23 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[usp_updateDishCollectionStatus]

	 @List AS [dbo].[CollectionList] READONLY,
	 @createdBy int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	update  ti
	set ti.isAmountCollected = 1
	,ti.customerSL = li.customerSL
	,ti.pageNo = li.pageNo
	,ti.collectedBy = @createdBy
	,ti.pageNoDate	= getdate()
	from tblDishBillCollection ti
	inner join @List li on ti.collectionId =  li.collectionId and li.customerSL is not null and li.pageNo is not null

END


GO
/****** Object:  StoredProcedure [dbo].[usp_updateInternetCollectionStatus]    Script Date: 12/31/2020 3:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Newaz Sharif
-- Create date: 23 Jun 2020
-- =============================================
CREATE PROCEDURE [dbo].[usp_updateInternetCollectionStatus]

	 @List AS [dbo].[CollectionList] READONLY,
	 @createdBy int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here

	update  ti
	set ti.isAmountCollected = 1
	,ti.customerSL = li.customerSL
	,ti.pageNo = li.pageNo,
	ti.collectedBy = @createdBy
	,ti.pageNoDate	= getdate()
	from tblInternetBillCollection ti
	inner join @List li on ti.collectionId =  li.collectionId and li.customerSL is not null and li.pageNo is not null

END


GO
USE [master]
GO
ALTER DATABASE [PCOHRAppDB] SET  READ_WRITE 
GO

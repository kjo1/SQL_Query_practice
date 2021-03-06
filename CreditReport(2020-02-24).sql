USE [Comtech2K]
GO
/****** Object:  StoredProcedure [dbo].[prcCreditReport]    Script Date: 2020-02-24 9:53:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE [dbo].[prcCreditReport] ( @lngPeriod INT, @lngYear INT
) AS

BEGIN

-- Log the fact this proc was called
		INSERT  INTO dbo.tblZZProcCalls
                ( strProcName, dtmCallDate, lngSPID)
		VALUES  ( 'prcCreditReport', GETDATE(), @@SPID);

		SELECT strCompanyName, I.strORderNumber, strWeek, dtmShipDate, C.strCurrencyID, FORMAT(dblOrderTotal, 'C') AS Credit
		FROM tblARInvoice2 I
		JOIN tblARCustomer C ON I.strCustomerID = C.strCustomerID
		JOIN tblSMWeeks DT ON DT.dtmDate = I.dtmShipDate
		WHERE (I.strOrderType = 'Credit'
			AND dblOrderTotal <> 0			
			AND DT.strPeriod = @lngPeriod
			AND DT.strYear = @lngYear
			AND LEFT(I.strORderNumber, 2) = '30'
			)			
		ORDER BY strCompanyName, strWeek, dtmShipDate
		 
END
















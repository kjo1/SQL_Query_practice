ALTER PROCEDURE [dbo].[kj] (@input NVARCHAR(30)) 
AS

BEGIN

	INSERT INTO dbo.tblZZProcCalls (strProcName, dtmCallDate, lngSPID) VALUES ('kj',GETDATE(),@@SPID);

		SELECT 'Invoice2' AS 'Invoice2', dblOrderTotal, *
		FROM tblARInvoice2
		WHERE strOrderNumber = @input

		SELECT 'Detail2' AS 'Detail2', *
		FROM tblARInvoiceDetail2
		WHERE strOrderNumber = @input

		-- get total without SHIPCH2 
		SELECT 'NoSHIPCH2' AS 'No SHIPCH2',strOrderNumber, SUM(dblQtyOrdered * dblSalePrice) AS 'Total'
		FROM tblARInvoiceDetail2
		WHERE strOrderNumber = @input 
			AND strProductID <> 'SHIPCH2'
		GROUP BY strOrderNumber;

END

IF ISNUMERIC(@input) <> 1
	BEGIN 

		-- find tables by a string
		SELECT 'Tables' AS 'Tables', * 
		FROM sys.tables 
		WHERE name LIKE '%'+ @input +'%';

		-- find procedures by a string
		SELECT 'Procedures' AS 'Procedures', * 
		FROM sys.procedures 
		WHERE name like '%'+ @input +'%';

	END

/* Test

EXEC kj '30623994'
EXEC kj 'order'

*/
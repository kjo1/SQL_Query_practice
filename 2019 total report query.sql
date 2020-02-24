SELECT strCompanyName, SUM(dblQtyOrdered * dblSalePrice) AS 'Total in 2019'
FROM tblARCustomer C
JOIN tblARInvoice2 I ON C.strCustomerID = I.strCustomerID
JOIN tblARInvoiceDetail2 ID ON I.strOrderNumber = ID.strOrderNumber
WHERE C.ysnActive = -1 AND C.strCompanyName LIKE '%Company Name%' 
	AND I.dtmShipDate BETWEEN '01/01/2019' AND '12/31/2019'
    AND ID.strProductID LIKE 'type%'
	AND LEFT(ID.strOrderNumber,1) <> 'D'
GROUP BY strCompanyName
HAVING SUM(dblQtyOrdered * dblSalePrice) > 0
ORDER BY [Total in 2019] DESC


SELECT C.strCompanyName, SUM(OD.dblOrderQty * dblSalePrice) AS 'Total in 2019'
FROM tblARCustomer C
JOIN tblOEOrder2 O ON C.strCustomerID = O.strCustomerID
JOIN tblOEOrderDetails2 OD ON O.strOrderNumber = OD.strOrderNumber
WHERE C.ysnActive = -1 AND C.strCompanyName LIKE '%Company Name%' AND O.dtmOrderDate BETWEEN '01/01/2019' AND '12/31/2019'
    AND OD.strProductID LIKE 'type%' AND LEFT(O.strOrderNumber,1) <> 'D'
GROUP BY C.strCompanyName
HAVING SUM(OD.dblOrderQty * dblSalePrice) > 0
ORDER BY [Total in 2019] DESC

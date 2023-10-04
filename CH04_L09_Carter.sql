SELECT
      poh.PurchaseOrderNumber
    , poh.PurchaseOrderDate
    , pod.ProductID
    , pod.Quantity
FROM PurchaseOrderHeaders poh
INNER JOIN PurchaseOrderDetails pod
    ON poh.PurchaseOrderNumber = pod.PurchaseOrderNumber ;

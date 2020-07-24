unit StockFactory.Model.Interf;

interface

uses SinapiProduct.Model.Interf;

type
   iStockFactoryModel = interface
      ['{86F9E238-B80E-409D-BEEB-1255D5208EF2}']
      function sinapiProductModel: iSinapiProductModel;
   end;

implementation

end.

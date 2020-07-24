unit ImportSinapiProduct.Controller.interf;

interface

uses TSTOSINAPIPRODUCT.Entity.Model, SinapiProduct.Model.interf;

type
   iImportSinapiProductOperationController = interface;

   iImportSinapiProductController = interface
      ['{3547B257-C3E6-4B57-A0B4-09DAC35E75A1}']
      function find(AValue: string): iImportSinapiProductController;
      function recordFound: TTSTOSINAPIPRODUCT;

      function import: iImportSinapiProductOperationController;
   end;

   iImportSinapiProductOperationController = interface
      ['{05B9F55B-19DD-44A8-86E6-84BA3F60B442}']
      function importSinapiProductController
        (AValue: iImportSinapiProductController)
        : iImportSinapiProductOperationController;

      function sinapiProductModel(AValue: iSinapiProductModel)
        : iImportSinapiProductOperationController;

      function currentProduct(AValue: TTSTOSINAPIPRODUCT)
        : iImportSinapiProductOperationController;

      function companyId(AValue: string)
        : iImportSinapiProductOperationController;
      function codeSinapi(AValue: string)
        : iImportSinapiProductOperationController;
      function description(AValue: string)
        : iImportSinapiProductOperationController;
      function unitMeasure(AValue: string)
        : iImportSinapiProductOperationController;
      function originPrice(AValue: string)
        : iImportSinapiProductOperationController;
      function averagePrice(AValue: Currency)
        : iImportSinapiProductOperationController;
      function averagePriceSinapi(AValue: Currency)
        : iImportSinapiProductOperationController;
      function status(AValue: Integer): iImportSinapiProductOperationController;
      function userId(AValue: string): iImportSinapiProductOperationController;

      procedure createSiapiProduct;
      procedure updateSiapiProduct;

      procedure save;
   end;

implementation

end.

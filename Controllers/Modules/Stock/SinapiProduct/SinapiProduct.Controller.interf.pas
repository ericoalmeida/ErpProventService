unit SinapiProduct.Controller.interf;

interface

uses SinapiProduct.Model.interf, TSTOSINAPIPRODUCT.Entity.Model;

type
   iSinapiProductInsertController = interface;
   iSinapiProductUpdateController = interface;
   iSinapiProductDeleteController = interface;
   iSinapiProductDuplicateController = interface;

   iSinapiProductController = interface
      function find(AValue: string): iSinapiProductController;

      function insert: iSinapiProductInsertController;
      function update: iSinapiProductUpdateController;
      function delete: iSinapiProductDeleteController;
      function duplicate: iSinapiProductDuplicateController;

      function code: string;
      function productId: string;
      function codeSinapi: string;
      function description: string;
      function unitMeasure: string;
      function originPrice: string;
      function averagePrice: Currency;
      function averagePriceSinapi: Currency;
      function status: Integer;
      function userId: string;
      function createdAt: string;
      function updatedAt: string;
   end;

   iSinapiProductInsertController = interface
      function productModel(AValue: iSinapiProductModel)
        : iSinapiProductInsertController;

      function companyId(AValue: string): iSinapiProductInsertController;
      function codeSinapi(AValue: string): iSinapiProductInsertController;
      function description(AValue: string): iSinapiProductInsertController;
      function unitMeasure(AValue: string): iSinapiProductInsertController;
      function originPrice(AValue: string): iSinapiProductInsertController;
      function averagePrice(AValue: Currency): iSinapiProductInsertController;
      function averagePriceSinapi(AValue: Currency)
        : iSinapiProductInsertController;
      function status(AValue: Integer): iSinapiProductInsertController;
      function userId(AValue: string): iSinapiProductInsertController;

      procedure save;
   end;

   iSinapiProductUpdateController = interface
      function productModel(AValue: iSinapiProductModel)
        : iSinapiProductUpdateController;
      function selectedRecord(AValue: TTSTOSINAPIPRODUCT)
        : iSinapiProductUpdateController;

      function companyId(AValue: string): iSinapiProductUpdateController;
      function codeSinapi(AValue: string): iSinapiProductUpdateController;
      function description(AValue: string): iSinapiProductUpdateController;
      function unitMeasure(AValue: string): iSinapiProductUpdateController;
      function originPrice(AValue: string): iSinapiProductUpdateController;
      function averagePrice(AValue: Currency): iSinapiProductUpdateController;
      function averagePriceSinapi(AValue: Currency)
        : iSinapiProductUpdateController;
      function status(AValue: Integer): iSinapiProductUpdateController;
      function userId(AValue: string): iSinapiProductUpdateController;

      procedure save;
   end;

   iSinapiProductDeleteController = interface
      function productModel(AValue: iSinapiProductModel)
        : iSinapiProductDeleteController;
      function selectedRecord(AValue: TTSTOSINAPIPRODUCT)
        : iSinapiProductDeleteController;

      procedure save;
   end;

   iSinapiProductDuplicateController = interface
      function productModel(AValue: iSinapiProductModel)
        : iSinapiProductDuplicateController;

      function companyId(AValue: string): iSinapiProductDuplicateController;
      function codeSinapi(AValue: string): iSinapiProductDuplicateController;
      function description(AValue: string): iSinapiProductDuplicateController;
      function unitMeasure(AValue: string): iSinapiProductDuplicateController;
      function originPrice(AValue: string): iSinapiProductDuplicateController;
      function averagePrice(AValue: Currency)
        : iSinapiProductDuplicateController;
      function averagePriceSinapi(AValue: Currency)
        : iSinapiProductDuplicateController;
      function status(AValue: Integer): iSinapiProductDuplicateController;
      function userId(AValue: string): iSinapiProductDuplicateController;

      procedure save;
   end;

implementation

end.

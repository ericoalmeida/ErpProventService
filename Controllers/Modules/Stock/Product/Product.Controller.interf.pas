unit Product.Controller.interf;

interface

uses Product.Model.interf, TSTOPRODUCT.Entity.Model;

type
  iProductInsertController = interface;
  iProductUpdateController = interface;
  iProductDeleteController = interface;
  iProductDuplicateController = interface;

  iProductController = interface
    function find(AValue: string): iProductController;

    function insert: iProductInsertController;
    function update: iProductUpdateController;
    function delete: iProductDeleteController;
    function duplicate: iProductDuplicateController;

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

  iProductInsertController = interface
    function productModel(AValue: IProductModel): iProductInsertController;

    function companyId(AValue: string): iProductInsertController;
    function codeSinapi(AValue: string): iProductInsertController;
    function description(AValue: string): iProductInsertController;
    function unitMeasure(AValue: string): iProductInsertController;
    function originPrice(AValue: string): iProductInsertController;
    function averagePrice(AValue: Currency): iProductInsertController;
    function averagePriceSinapi(AValue: Currency): iProductInsertController;
    function status(AValue: Integer): iProductInsertController;
    function userId(AValue: string): iProductInsertController;

    procedure save;
  end;

  iProductUpdateController = interface
    function productModel(AValue: IProductModel): iProductUpdateController;
    function selectedRecord(AValue: TTSTOPRODUCT): iProductUpdateController;

    function companyId(AValue: string): iProductUpdateController;
    function codeSinapi(AValue: string): iProductUpdateController;
    function description(AValue: string): iProductUpdateController;
    function unitMeasure(AValue: string): iProductUpdateController;
    function originPrice(AValue: string): iProductUpdateController;
    function averagePrice(AValue: Currency): iProductUpdateController;
    function averagePriceSinapi(AValue: Currency): iProductUpdateController;
    function status(AValue: Integer): iProductUpdateController;
    function userId(AValue: string): iProductUpdateController;

    procedure save;
  end;

  iProductDeleteController = interface
    function productModel(AValue: IProductModel): iProductDeleteController;
    function selectedRecord(AValue: TTSTOPRODUCT): iProductDeleteController;

    procedure save;
  end;

  iProductDuplicateController = interface
    function productModel(AValue: IProductModel)
      : iProductDuplicateController;

    function companyId(AValue: string): iProductDuplicateController;
    function codeSinapi(AValue: string): iProductDuplicateController;
    function description(AValue: string): iProductDuplicateController;
    function unitMeasure(AValue: string): iProductDuplicateController;
    function originPrice(AValue: string): iProductDuplicateController;
    function averagePrice(AValue: Currency): iProductDuplicateController;
    function averagePriceSinapi(AValue: Currency): iProductDuplicateController;
    function status(AValue: Integer): iProductDuplicateController;
    function userId(AValue: string): iProductDuplicateController;

    procedure save;
  end;

implementation

end.

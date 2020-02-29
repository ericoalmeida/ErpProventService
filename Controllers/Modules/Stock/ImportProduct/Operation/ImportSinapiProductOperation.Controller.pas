unit ImportSinapiProductOperation.Controller;

interface

uses ImportSinapiProduct.Controller.interf, SinapiProduct.Model.interf,
  TSTOSINAPIPRODUCT.Entity.Model;

type
  TImportSinapiProductOperationController = class(TInterfacedObject,
    iImportSinapiProductOperationController)
  private
    FImportSinapiProductController: iImportSinapiProductController;
    FSinapiProductModel: iSinapiProductModel;
    FCurrentProduct: TTSTOSINAPIPRODUCT;
    FProductFound: Boolean;

    FCompanyId: string;
    FCodeSinapi: string;
    FDescription: string;
    FUnitMeasure: string;
    FOriginPrice: string;
    FAveragePrice: Currency;
    FAveragePriceSinapi: Currency;
    FStatus: Integer;
    FUserId: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iImportSinapiProductOperationController;

    function importSinapiProductController
      (AValue: iImportSinapiProductController)
      : iImportSinapiProductOperationController;

    function sinapiProductModel(AValue: iSinapiProductModel)
      : iImportSinapiProductOperationController;

    function currentProduct(AValue: TTSTOSINAPIPRODUCT)
      : iImportSinapiProductOperationController;

    function companyId(AValue: string): iImportSinapiProductOperationController;
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

    procedure save;
  end;

implementation

{ TImportSinapiProductOperationController }

function TImportSinapiProductOperationController.averagePrice(AValue: Currency)
  : iImportSinapiProductOperationController;
begin

end;

function TImportSinapiProductOperationController.averagePriceSinapi
  (AValue: Currency): iImportSinapiProductOperationController;
begin

end;

function TImportSinapiProductOperationController.codeSinapi(AValue: string)
  : iImportSinapiProductOperationController;
begin

end;

function TImportSinapiProductOperationController.companyId(AValue: string)
  : iImportSinapiProductOperationController;
begin

end;

constructor TImportSinapiProductOperationController.Create;
begin

end;

function TImportSinapiProductOperationController.currentProduct(
  AValue: TTSTOSINAPIPRODUCT): iImportSinapiProductOperationController;
begin
  Result := Self;
  FCurrentProduct := AValue;
  FProductFound := not(AValue = nil);
end;

function TImportSinapiProductOperationController.description(AValue: string)
  : iImportSinapiProductOperationController;
begin

end;

destructor TImportSinapiProductOperationController.Destroy;
begin

  inherited;
end;

function TImportSinapiProductOperationController.importSinapiProductController
  (AValue: iImportSinapiProductController)
  : iImportSinapiProductOperationController;
begin
  Result := Self;
  FImportSinapiProductController := AValue;
end;

class function TImportSinapiProductOperationController.New
  : iImportSinapiProductOperationController;
begin
  Result := Self.Create;
end;

function TImportSinapiProductOperationController.originPrice(AValue: string)
  : iImportSinapiProductOperationController;
begin

end;

procedure TImportSinapiProductOperationController.save;
begin

end;

function TImportSinapiProductOperationController.sinapiProductModel
  (AValue: iSinapiProductModel): iImportSinapiProductOperationController;
begin
  Result := Self;
  FSinapiProductModel := AValue;
end;

function TImportSinapiProductOperationController.status(AValue: Integer)
  : iImportSinapiProductOperationController;
begin

end;

function TImportSinapiProductOperationController.unitMeasure(AValue: string)
  : iImportSinapiProductOperationController;
begin

end;

function TImportSinapiProductOperationController.userId(AValue: string)
  : iImportSinapiProductOperationController;
begin

end;

end.

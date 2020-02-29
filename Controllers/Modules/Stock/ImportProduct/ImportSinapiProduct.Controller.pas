unit ImportSinapiProduct.Controller;

interface

uses ImportSinapiProduct.Controller.interf, TSTOSINAPIPRODUCT.Entity.Model,
  SinapiProduct.Model.interf, System.SysUtils;

type
  TImportSinapiProductController = class(TInterfacedObject,
    iImportSinapiProductController)
  private
    FRecordFound: TTSTOSINAPIPRODUCT;
    FSinapiProductModel: iSinapiProductModel;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iImportSinapiProductController;

    function find(AValue: string): iImportSinapiProductController;

    function recordFound: TTSTOSINAPIPRODUCT;

    function import: iImportSinapiProductOperationController;
  end;

implementation

{ TImportSinapiProductController }

uses Facade.Model;

constructor TImportSinapiProductController.Create;
begin
  FSinapiProductModel := TFacadeModel.New.moduleFacade.stockFactoryModel.
    sinapiProductModel;
end;

destructor TImportSinapiProductController.Destroy;
begin

  inherited;
end;

function TImportSinapiProductController.find(AValue: string)
  : iImportSinapiProductController;
begin
  Result := Self;

  FRecordFound := FSinapiProductModel.DAO.FindWhere(Format('CODE_SINAPI = %s',
    [QuotedStr(AValue)])).Items[0];
end;

function TImportSinapiProductController.import: iImportSinapiProductOperationController;
begin
  //Result :=
end;

class function TImportSinapiProductController.New
  : iImportSinapiProductController;
begin
  Result := Self.Create;
end;

function TImportSinapiProductController.recordFound: TTSTOSINAPIPRODUCT;
begin
  Result := FRecordFound;
end;

end.

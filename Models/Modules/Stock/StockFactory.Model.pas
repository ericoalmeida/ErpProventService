unit StockFactory.Model;

interface

uses StockFactory.Model.Interf, SinapiProduct.Model.Interf;

type
  TStockFactoryModel = class(TInterfacedObject, iStockFactoryModel)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iStockFactoryModel;

    function sinapiProductModel: iSinapiProductModel;
  end;

implementation

{ TStockFactoryModel }

uses SinapiProduct.Model;

constructor TStockFactoryModel.Create;
begin

end;

destructor TStockFactoryModel.Destroy;
begin

  inherited;
end;

class function TStockFactoryModel.New: iStockFactoryModel;
begin
  Result := Self.Create;
end;

function TStockFactoryModel.sinapiProductModel: iSinapiProductModel;
begin
  Result := TSinapiProductModel.New;
end;

end.

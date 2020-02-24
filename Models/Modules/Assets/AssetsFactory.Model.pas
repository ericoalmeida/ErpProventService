unit AssetsFactory.Model;

interface

uses AssetsFactory.Model.Interf, TypeExpense.Model.Interf;

type
  TAssetsFactoryModel = class(TInterfacedObject, iAssetsFactoryModel)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iAssetsFactoryModel;

    function TypeExpense: iTypeExpenseModel;
  end;

implementation

{ TAssetsFactoryModel }

uses TypeExpense.Model;

constructor TAssetsFactoryModel.Create;
begin

end;

destructor TAssetsFactoryModel.Destroy;
begin

  inherited;
end;

class function TAssetsFactoryModel.New: iAssetsFactoryModel;
begin
  Result := Self.Create;
end;

function TAssetsFactoryModel.TypeExpense: iTypeExpenseModel;
begin
  Result := TTypeExpenseModel.New;
end;

end.

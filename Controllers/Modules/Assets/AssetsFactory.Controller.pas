unit AssetsFactory.Controller;

interface

uses AssetsFactory.Controller.interf, TypeExpense.Controller.interf;

type
  TAssetsFactoryController = class(TInterfacedObject, iAssetsFactoryController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iAssetsFactoryController;

    function TypeExpense: iTypeExpenseController;
  end;

implementation

{ TAssetsFactoryController }

uses TypeExpense.Controller;

constructor TAssetsFactoryController.Create;
begin

end;

destructor TAssetsFactoryController.Destroy;
begin

  inherited;
end;

class function TAssetsFactoryController.New: iAssetsFactoryController;
begin
  Result := Self.Create;
end;

function TAssetsFactoryController.TypeExpense: iTypeExpenseController;
begin
  Result := TTypeExpenseController.New;
end;

end.

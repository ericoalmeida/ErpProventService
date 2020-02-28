unit Product.Model;

interface

uses Product.Model.Interf, ormbr.container.objectset.interfaces,
  ormbr.Factory.interfaces, TSTOPRODUCT.Entity.Model;

type
  TProductModel = class(TInterfacedObject, IProductModel)
  private
    FConnection: IDBConnection;
    FEntity: TTSTOPRODUCT;
    FDAO: IContainerObjectSet<TTSTOPRODUCT>;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: IProductModel;

    function Entity: TTSTOPRODUCT; overload;
    function Entity(AValue: TTSTOPRODUCT): IProductModel; overload;

    function DAO: IContainerObjectSet<TTSTOPRODUCT>;
  end;

implementation

{ TProductModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TProductModel.Create;
begin
  FConnection := TFacadeController.New.ConnectionFactoryController.
    currentConnection;
  FDAO := TContainerObjectSet<TTSTOPRODUCT>.Create(FConnection, 1);
end;

function TProductModel.DAO: IContainerObjectSet<TTSTOPRODUCT>;
begin
  result := FDAO;
end;

destructor TProductModel.Destroy;
begin

  inherited;
end;

function TProductModel.Entity: TTSTOPRODUCT;
begin
  result := FEntity;
end;

function TProductModel.Entity(AValue: TTSTOPRODUCT): IProductModel;
begin
  result := Self;
  FEntity := AValue;
end;

class function TProductModel.New: IProductModel;
begin
  result := Self.Create;
end;

end.

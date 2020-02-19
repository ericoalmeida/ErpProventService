unit Country.Model;

interface

uses Country.Model.Interf, ormbr.container.objectset.interfaces,
  ormbr.Factory.interfaces, TGERPAIS.Entity.Model;

type
  TCountryModel = class(TInterfacedObject, ICountryModel)
  private
    FConnection: IDBConnection;
    FEntity: TTMNGCOUNTRY;
    FDAO: IContainerObjectSet<TTMNGCOUNTRY>;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: ICountryModel;

    function Entity: TTMNGCOUNTRY; overload;
    function Entity(AValue: TTMNGCOUNTRY): ICountryModel; overload;

    function DAO: IContainerObjectSet<TTMNGCOUNTRY>;
  end;

implementation

{ TCountryModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TCountryModel.Create;
begin
  FConnection := TFacadeController.New.ConnectionFactoryController.
    currentConnection;
  FDAO := TContainerObjectSet<TTMNGCOUNTRY>.Create(FConnection, 1);
end;

function TCountryModel.DAO: IContainerObjectSet<TTMNGCOUNTRY>;
begin
  Result := FDAO;
end;

destructor TCountryModel.Destroy;
begin

  inherited;
end;

function TCountryModel.Entity: TTMNGCOUNTRY;
begin
  Result := FEntity;
end;

function TCountryModel.Entity(AValue: TTMNGCOUNTRY): ICountryModel;
begin
  Result := Self;
  FEntity := AValue;
end;

class function TCountryModel.New: ICountryModel;
begin
  Result := Self.Create;
end;

end.

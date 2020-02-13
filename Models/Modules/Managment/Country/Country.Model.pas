unit Country.Model;

interface

uses Country.Model.Interf, ormbr.container.objectset.interfaces,
  ormbr.Factory.interfaces, TGERPAIS.Entity.Model;

type
  TCountryModel = class(TInterfacedObject, ICountryModel)
  private
    FConnection: IDBConnection;
    FEntity: TTGERPAIS;
    FDAO: IContainerObjectSet<TTGERPAIS>;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: ICountryModel;

    function Entity: TTGERPAIS; overload;
    function Entity(AValue: TTGERPAIS): ICountryModel; overload;

    function DAO: IContainerObjectSet<TTGERPAIS>;
  end;

implementation

{ TCountryModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TCountryModel.Create;
begin
  FConnection := TFacadeController.New.ConnectionFactoryController.
    currentConnection;
  FDAO := TContainerObjectSet<TTGERPAIS>.Create(FConnection, 1);
end;

function TCountryModel.DAO: IContainerObjectSet<TTGERPAIS>;
begin
  Result := FDAO;
end;

destructor TCountryModel.Destroy;
begin

  inherited;
end;

function TCountryModel.Entity: TTGERPAIS;
begin
  Result := FEntity;
end;

function TCountryModel.Entity(AValue: TTGERPAIS): ICountryModel;
begin
  Result := Self;
  FEntity := AValue;
end;

class function TCountryModel.New: ICountryModel;
begin
  Result := Self.Create;
end;

end.

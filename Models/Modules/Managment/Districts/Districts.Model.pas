unit Districts.Model;

interface

uses Districts.Model.Interf, ormbr.container.objectset.interfaces,
  ormbr.Factory.interfaces, TMNGDISTRICT.Entity.Model;

type
  TDistrictModel = class(TInterfacedObject, iDistrictModel)
  private
    FConnection: IDBConnection;
    FEntity: TTMNGDISTRICT;
    FDAO: IContainerObjectSet<TTMNGDISTRICT>;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: iDistrictModel;

    function Entity: TTMNGDISTRICT; overload;
    function Entity(AValue: TTMNGDISTRICT): iDistrictModel; overload;

    function DAO: IContainerObjectSet<TTMNGDISTRICT>;
  end;

implementation

{ TDistrictModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TDistrictModel.Create;
begin
   FConnection := TFacadeController.New.ConnectionFactoryController.currentConnection;
   FDao :=  TContainerObjectSet<TTMNGDISTRICT>.Create(FConnection, 1);
end;

function TDistrictModel.DAO: IContainerObjectSet<TTMNGDISTRICT>;
begin
   Result := FDAO;
end;

destructor TDistrictModel.Destroy;
begin

  inherited;
end;

function TDistrictModel.Entity: TTMNGDISTRICT;
begin
  Result := FEntity;
end;

function TDistrictModel.Entity(AValue: TTMNGDISTRICT): iDistrictModel;
begin
  Result := Self;
  FEntity := AValue;
end;

class function TDistrictModel.New: iDistrictModel;
begin
  Result := Self.Create;
end;

end.

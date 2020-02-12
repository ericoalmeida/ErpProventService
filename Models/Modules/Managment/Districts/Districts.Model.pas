unit Districts.Model;

interface

uses Districts.Model.Interf, ormbr.container.objectset.interfaces,
  ormbr.Factory.interfaces, TGERBAIRRO.Entity.Model;

type
  TDistrictModel = class(TInterfacedObject, iDistrictModel)
  private
    FConnection: IDBConnection;
    FEntity: TTGERBAIRRO;
    FDAO: IContainerObjectSet<TTGERBAIRRO>;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: iDistrictModel;

    function Entity: TTGERBAIRRO; overload;
    function Entity(AValue: TTGERBAIRRO): iDistrictModel; overload;

    function DAO: IContainerObjectSet<TTGERBAIRRO>;
  end;

implementation

{ TDistrictModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TDistrictModel.Create;
begin
   FConnection := TFacadeController.New.ConnectionFactoryController.currentConnection;
   FDao :=  TContainerObjectSet<TTGERBAIRRO>.Create(FConnection, 1);
end;

function TDistrictModel.DAO: IContainerObjectSet<TTGERBAIRRO>;
begin
   Result := FDAO;
end;

destructor TDistrictModel.Destroy;
begin

  inherited;
end;

function TDistrictModel.Entity: TTGERBAIRRO;
begin
  Result := FEntity;
end;

function TDistrictModel.Entity(AValue: TTGERBAIRRO): iDistrictModel;
begin
  Result := Self;
  FEntity := AValue;
end;

class function TDistrictModel.New: iDistrictModel;
begin
  Result := Self.Create;
end;

end.

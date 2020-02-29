unit SinapiProduct.Model;

interface

uses SinapiProduct.Model.Interf, ormbr.container.objectset.interfaces,
  ormbr.Factory.interfaces, TSTOSINAPIPRODUCT.Entity.Model;

type
  TSinapiProductModel = class(TInterfacedObject, iSinapiProductModel)
  private
    FConnection: IDBConnection;
    FEntity: TTSTOSINAPIPRODUCT;
    FDAO: IContainerObjectSet<TTSTOSINAPIPRODUCT>;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: iSinapiProductModel;

    function Entity: TTSTOSINAPIPRODUCT; overload;
    function Entity(AValue: TTSTOSINAPIPRODUCT): iSinapiProductModel; overload;

    function DAO: IContainerObjectSet<TTSTOSINAPIPRODUCT>;
  end;

implementation

{ TSinapiProductModel }

uses Facade.Controller, ormbr.container.objectset;

constructor TSinapiProductModel.Create;
begin
  FConnection := TFacadeController.New.ConnectionFactoryController.
    currentConnection;
  FDAO := TContainerObjectSet<TTSTOSINAPIPRODUCT>.Create(FConnection, 1);
end;

function TSinapiProductModel.DAO: IContainerObjectSet<TTSTOSINAPIPRODUCT>;
begin
  result := FDAO;
end;

destructor TSinapiProductModel.Destroy;
begin

  inherited;
end;

function TSinapiProductModel.Entity: TTSTOSINAPIPRODUCT;
begin
  result := FEntity;
end;

function TSinapiProductModel.Entity(AValue: TTSTOSINAPIPRODUCT): iSinapiProductModel;
begin
  result := Self;
  FEntity := AValue;
end;

class function TSinapiProductModel.New: iSinapiProductModel;
begin
  result := Self.Create;
end;

end.

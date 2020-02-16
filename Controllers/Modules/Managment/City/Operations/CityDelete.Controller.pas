unit CityDelete.Controller;

interface

uses City.Controller.Interf, TMNGCITY.Entity.Model,
  City.Model.Interf, Base.View.Interf;

type
  TCityDeleteController = class(TInterfacedObject,
    iCityDeleteController)
  private
    FMessageConfirm: iBaseMessageView;

    FCityModel: iCityModel;
    FSelectedRecord: TTMNGCITY;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCityDeleteController;

    function cityModel(AValue: iCityModel): iCityDeleteController;
    function selectedRecord(AValue: TTMNGCITY): iCityDeleteController;

    procedure save;
  end;

implementation

{ TCityDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TCityDeleteController.Create;
begin
  FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
    (tmConfirmation);
end;

destructor TCityDeleteController.Destroy;
begin

  inherited;
end;

function TCityDeleteController.cityModel(AValue: iCityModel)
  : iCityDeleteController;
begin
  Result := Self;
  FCityModel := AValue;
end;

class function TCityDeleteController.New: iCityDeleteController;
begin
  Result := Self.Create;
end;

procedure TCityDeleteController.save;
begin
  if FMessageConfirm.messages(Format('Deseja excluir o bairro %s ?',
    [FSelectedRecord.NAME])).&end then
  begin

    try
      FCityModel.DAO.Delete(FSelectedRecord);

    except
      on E: Exception do
        raise Exception.Create(Format('O Bairro %s não pode ser excluído!',
          [FSelectedRecord.NAME]));
    end;

  end;
end;

function TCityDeleteController.selectedRecord(AValue: TTMNGCITY)
  : iCityDeleteController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.

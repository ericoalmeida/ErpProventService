unit CountryDelete.Controller;

interface

uses Country.Controller.Interf, TMNGCOUNTRY.Entity.Model,
  Country.Model.Interf, Base.View.Interf;

type
  TCountryDeleteController = class(TInterfacedObject,
    iCountryDeleteController)
  private
    FMessageConfirm: iBaseMessageView;

    FCountryModel: ICountryModel;
    FSelectedRecord: TTMNGCOUNTRY;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCountryDeleteController;

    function countryModel(AValue: ICountryModel): iCountryDeleteController;
    function selectedRecord(AValue: TTMNGCOUNTRY): iCountryDeleteController;

    procedure save;
  end;

implementation

{ TCountryDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TCountryDeleteController.Create;
begin
  FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
    (tmConfirmation);
end;

destructor TCountryDeleteController.Destroy;
begin

  inherited;
end;

function TCountryDeleteController.countryModel(AValue: ICountryModel)
  : iCountryDeleteController;
begin
  Result := Self;
  FCountryModel := AValue;
end;

class function TCountryDeleteController.New: iCountryDeleteController;
begin
  Result := Self.Create;
end;

procedure TCountryDeleteController.save;
begin
  if FMessageConfirm.messages(Format('Deseja excluir o país %s ?',
    [FSelectedRecord.NAME])).&end then
  begin

    try
      FCountryModel.DAO.Delete(FSelectedRecord);

    except
      on E: Exception do
        raise Exception.Create(Format('Este país %s não pode ser excluído!',
          [FSelectedRecord.NAME]));
    end;

  end;
end;

function TCountryDeleteController.selectedRecord(AValue: TTMNGCOUNTRY)
  : iCountryDeleteController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.

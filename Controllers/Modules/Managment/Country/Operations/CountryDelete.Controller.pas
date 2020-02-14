unit CountryDelete.Controller;

interface

uses Country.Controller.Interf, TGERPAIS.Entity.Model,
  Country.Model.Interf, Base.View.Interf;

type
  TCountryDeleteController = class(TInterfacedObject,
    iCountryDeleteController)
  private
    FMessageConfirm: iBaseMessageView;

    FCountryModel: ICountryModel;
    FSelectedRecord: TTGERPAIS;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCountryDeleteController;

    function countryModel(AValue: ICountryModel): iCountryDeleteController;
    function selectedRecord(AValue: TTGERPAIS): iCountryDeleteController;

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
  if FMessageConfirm.messages(Format('Deseja excluir o pa�s %s ?',
    [FSelectedRecord.DESCRICAO])).&end then
  begin

    try
      FCountryModel.DAO.Delete(FSelectedRecord);

    except
      on E: Exception do
        raise Exception.Create(Format('Este pa�s %s n�o pode ser exclu�do!',
          [FSelectedRecord.DESCRICAO]));
    end;

  end;
end;

function TCountryDeleteController.selectedRecord(AValue: TTGERPAIS)
  : iCountryDeleteController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.

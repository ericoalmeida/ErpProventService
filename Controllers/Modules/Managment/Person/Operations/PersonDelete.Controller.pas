unit PersonDelete.Controller;

interface

uses Person.Controller.Interf, Person.Model.Interf, Base.View.Interf,
  TMNGPERSON.Entity.Model;

type
  TPersonDeleteController = class(TInterfacedObject, iPersonDeleteController)
  private
    FMessageConfirm: iBaseMessageView;

    FPersonModel: IPersonModel;
    FSelectedRecord: TTMNGPERSON;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iPersonDeleteController;

    function personModel(AValue: IPersonModel): iPersonDeleteController;
    function selectedRecord(AValue: TTMNGPERSON): iPersonDeleteController;

    procedure save;
  end;

implementation

{ TPersonDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TPersonDeleteController.Create;
begin
  FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
    (tmConfirmation);
end;

destructor TPersonDeleteController.Destroy;
begin

  inherited;
end;

function TPersonDeleteController.personModel(AValue: IPersonModel)
  : iPersonDeleteController;
begin
  Result := Self;
  FPersonModel := AValue;
end;

class function TPersonDeleteController.New: iPersonDeleteController;
begin
  Result := Self.Create;
end;

procedure TPersonDeleteController.save;
begin
  if FMessageConfirm.messages(Format('Deseja excluir o registro %s ?',
    [FSelectedRecord.FANCYNAME])).&end then
  begin

    try
      FPersonModel.DAO.Delete(FSelectedRecord);

    except
      on E: Exception do
        raise Exception.Create(Format('O Registro %s não pode ser excluído!',
          [FSelectedRecord.FANCYNAME]));
    end;

  end;
end;

function TPersonDeleteController.selectedRecord(AValue: TTMNGPERSON)
  : iPersonDeleteController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.

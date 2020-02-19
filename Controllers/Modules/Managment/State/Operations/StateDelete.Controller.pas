unit StateDelete.Controller;

interface

uses State.Controller.Interf, TGERESTADO.Entity.Model,
  State.Model.Interf, Base.View.Interf;

type
  TStateDeleteController = class(TInterfacedObject,
    iStateDeleteController)
  private
    FMessageConfirm: iBaseMessageView;

    FStateModel: IStateModel;
    FSelectedRecord: TTMNGSTATE;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iStateDeleteController;

    function stateModel(AValue: IStateModel): iStateDeleteController;
    function selectedRecord(AValue: TTMNGSTATE): iStateDeleteController;

    procedure save;
  end;

implementation

{ TStateDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TStateDeleteController.Create;
begin
  FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
    (tmConfirmation);
end;

destructor TStateDeleteController.Destroy;
begin

  inherited;
end;

function TStateDeleteController.stateModel(AValue: IStateModel)
  : iStateDeleteController;
begin
  Result := Self;
  FStateModel := AValue;
end;

class function TStateDeleteController.New: iStateDeleteController;
begin
  Result := Self.Create;
end;

procedure TStateDeleteController.save;
begin
  if FMessageConfirm.messages(Format('Deseja excluir o estado %s ?',
    [FSelectedRecord.NAME])).&end then
  begin

    try
      FStateModel.DAO.Delete(FSelectedRecord);

    except
      on E: Exception do
        raise Exception.Create(Format('Este estado %s não pode ser excluído!',
          [FSelectedRecord.NAME]));
    end;

  end;
end;

function TStateDeleteController.selectedRecord(AValue: TTMNGSTATE)
  : iStateDeleteController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.

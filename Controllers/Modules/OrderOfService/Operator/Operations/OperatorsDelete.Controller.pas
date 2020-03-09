unit OperatorsDelete.Controller;

interface

uses Operators.Controller.Interf, Operators.Model.Interf,
  TORDOPERATOR.Entity.Model,
  System.SysUtils, Base.View.interf;

type
  TOperatorDeleteController = class(TInterfacedObject,
    iOperatorDeleteController)
  private
    FMessageConfirm: iBaseMessageView;

    FOperatorModel: IOperatorModel;
    FSelectedRecord: TTORDOPERATOR;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iOperatorDeleteController;

    function operatorModel(AValue: IOperatorModel): iOperatorDeleteController;
    function selectedRecord(AValue: TTORDOPERATOR)
      : iOperatorDeleteController;

    procedure save;
  end;

implementation

{ TOperatorDeleteController }

uses Facade.View, Types.Views;

constructor TOperatorDeleteController.Create;
begin
  FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
    (tmConfirmation);
end;

destructor TOperatorDeleteController.Destroy;
begin

  inherited;
end;

function TOperatorDeleteController.operatorModel(AValue: IOperatorModel)
  : iOperatorDeleteController;
begin
  Result := Self;
  FOperatorModel := AValue;
end;

class function TOperatorDeleteController.New: iOperatorDeleteController;
begin
  Result := Self.Create;
end;

procedure TOperatorDeleteController.save;
begin
  if FMessageConfirm.messages(Format('Deseja excluir o operador %s ?',
    [FSelectedRecord.NAME])).&end then
  begin

    try
      FOperatorModel.DAO.Delete(FSelectedRecord);

    except
      on E: Exception do
        raise Exception.Create(Format('O Operador %s não pode ser excluído!',
          [FSelectedRecord.NAME]));
    end;

  end;
end;

function TOperatorDeleteController.selectedRecord(AValue: TTORDOPERATOR)
  : iOperatorDeleteController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.

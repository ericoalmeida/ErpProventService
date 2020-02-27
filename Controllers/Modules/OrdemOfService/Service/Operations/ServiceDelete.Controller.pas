unit ServiceDelete.Controller;

interface

uses Service.Controller.Interf, Service.Model.Interf,
  TORDSERVICE.Entity.Model, Base.View.Interf;

type
  TServiceDeleteController = class(TInterfacedObject, iServiceDeleteController)
  private
    FMessageConfirm: iBaseMessageView;

    FServiceModel: iServiceModel;
    FSelectedRecord: TTORDSERVICE;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iServiceDeleteController;

    function serviceModel(AValue: iServiceModel): iServiceDeleteController;
    function selectedRecord(AValue: TTORDSERVICE): iServiceDeleteController;

    procedure save;
  end;

implementation

{ TServiceDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TServiceDeleteController.Create;
begin
  FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
    (tmConfirmation);
end;

destructor TServiceDeleteController.Destroy;
begin

  inherited;
end;

function TServiceDeleteController.serviceModel(AValue: iServiceModel)
  : iServiceDeleteController;
begin
  Result := Self;
  FServiceModel := AValue;
end;

class function TServiceDeleteController.New: iServiceDeleteController;
begin
  Result := Self.Create;
end;

procedure TServiceDeleteController.save;
begin
  if FMessageConfirm.messages(Format('Deseja excluir o serviço %s ?',
    [FSelectedRecord.DESCRIPTION])).&end then
  begin

    try
      FServiceModel.DAO.Delete(FSelectedRecord);

    except
      on E: Exception do
        raise Exception.Create(Format('O serviço %s não pode ser excluído!',
          [FSelectedRecord.DESCRIPTION]));
    end;

  end;
end;

function TServiceDeleteController.selectedRecord(AValue: TTORDSERVICE)
  : iServiceDeleteController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

end.

unit ServiceProvidedDelete.Controller;

interface

uses ServiceProvided.Controller.Interf,
   ServiceProvided.Model.Interf, Base.View.Interf,
   TORDSERVICESPROVIDED.Entity.Model;

type
   TServiceProvidedDeleteController = class(TInterfacedObject,
     iServiceProvidedDeleteController)
   private
      FMessageConfirm: iBaseMessageView;

      FServiceProvidedModel: iServiceProvidedModel;
      FSelectedRecord: TTORDSERVICESPROVIDED;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iServiceProvidedDeleteController;

      function serviceProvidedModel(AValue: iServiceProvidedModel)
        : iServiceProvidedDeleteController;
      function selectedRecord(AValue: TTORDSERVICESPROVIDED)
        : iServiceProvidedDeleteController;

      procedure save;
   end;

implementation

{ TServiceProvidedDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TServiceProvidedDeleteController.Create;
begin
   FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
     (tmConfirmation);
end;

destructor TServiceProvidedDeleteController.Destroy;
begin

   inherited;
end;

function TServiceProvidedDeleteController.serviceProvidedModel
  (AValue: iServiceProvidedModel): iServiceProvidedDeleteController;
begin
   Result := Self;
   FServiceProvidedModel := AValue;
end;

class function TServiceProvidedDeleteController.New
  : iServiceProvidedDeleteController;
begin
   Result := Self.Create;
end;

procedure TServiceProvidedDeleteController.save;
begin
   if FMessageConfirm.messages
     (Format('Deseja cancelar a ordem de serviço Nº #%d ?',
     [FSelectedRecord.SERVICEPROVIDEDID])).&end then
   begin

      FServiceProvidedModel.DAO.Modify(FSelectedRecord);

      FSelectedRecord.STATUS := 1;
      FSelectedRecord.UPDATEDAT := Now;

      FServiceProvidedModel.DAO.Update(FSelectedRecord);
   end;
end;

function TServiceProvidedDeleteController.selectedRecord
  (AValue: TTORDSERVICESPROVIDED): iServiceProvidedDeleteController;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

end.

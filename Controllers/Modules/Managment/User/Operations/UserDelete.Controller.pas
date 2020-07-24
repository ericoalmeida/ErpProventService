unit UserDelete.Controller;

interface

uses User.Controller.Interf, TMNGUSER.Entity.Model,
   User.Model.Interf, Base.View.Interf;

type
   TUserDeleteController = class(TInterfacedObject, iUserDeleteController)
   private
      FMessageConfirm: iBaseMessageView;

      FUserModel: iUserModel;
      FSelectedRecord: TTMNGUSER;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iUserDeleteController;

      function userModel(AValue: iUserModel): iUserDeleteController;
      function selectedRecord(AValue: TTMNGUSER): iUserDeleteController;

      procedure save;
   end;

implementation

{ TUserDeleteController }

uses Facade.View, Types.Views, System.SysUtils;

constructor TUserDeleteController.Create;
begin
   FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
     (tmConfirmation);
end;

destructor TUserDeleteController.Destroy;
begin

   inherited;
end;

function TUserDeleteController.userModel(AValue: iUserModel)
  : iUserDeleteController;
begin
   Result := Self;
   FUserModel := AValue;
end;

class function TUserDeleteController.New: iUserDeleteController;
begin
   Result := Self.Create;
end;

procedure TUserDeleteController.save;
begin
   if FMessageConfirm.messages(Format('Deseja excluir o usuário %s ?',
     [FSelectedRecord.NAME])).&end then
   begin

      try
         FUserModel.DAO.Delete(FSelectedRecord);

      except
         on E: Exception do
            raise Exception.Create(Format('Usuário %s não pode ser excluído!',
              [FSelectedRecord.NAME]));
      end;

   end;
end;

function TUserDeleteController.selectedRecord(AValue: TTMNGUSER)
  : iUserDeleteController;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

end.

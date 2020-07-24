unit UserUpdate.Controller;

interface

uses User.Controller.Interf, User.Model.Interf,
   TMNGUSER.Entity.Model, System.SysUtils;

type
   TUserUpdateController = class(TInterfacedObject, iUserUpdateController)
   private
      FUserModel: IUserModel;
      FSelectedRecord: TTMNGUSER;

      FName: string;
      FEmail: string;
      FUserName: string;
      FKeyPass: string;
      FStatus: Integer;

   public
      constructor Create;
      destructor Destroy; override;

      class function New: iUserUpdateController;

      function userModel(AValue: IUserModel): iUserUpdateController;
      function selectedRecord(AValue: TTMNGUSER): iUserUpdateController;

      function name(AValue: string): iUserUpdateController;
      function email(AValue: string): iUserUpdateController;
      function username(AValue: string): iUserUpdateController;
      function keypass(AValue: string): iUserUpdateController;
      function status(AValue: Integer): iUserUpdateController;

      procedure save;
   end;

implementation

{ TUserUpdateController }

uses BCrypt.Controller;

function TUserUpdateController.userModel(AValue: IUserModel)
  : iUserUpdateController;
begin
   Result := Self;
   FUserModel := AValue;
end;

function TUserUpdateController.username(AValue: string): iUserUpdateController;
begin
   Result := Self;
   FUserName := AValue;
end;

constructor TUserUpdateController.Create;
begin

end;

destructor TUserUpdateController.Destroy;
begin

   inherited;
end;

function TUserUpdateController.email(AValue: string): iUserUpdateController;
begin
   Result := Self;
   FEmail := AValue;
end;

function TUserUpdateController.keypass(AValue: string): iUserUpdateController;
var
   BCrypt: TBCrypt;
begin
   Result := Self;
   BCrypt := TBCrypt.Create;

   try
      if not(AValue = EmptyStr) then
         FKeyPass := BCrypt.HashPassword(AValue, 14);

   finally
      BCrypt.Free;
   end;
end;

function TUserUpdateController.name(AValue: string): iUserUpdateController;
begin
   Result := Self;
   FName := AValue;
end;

class function TUserUpdateController.New: iUserUpdateController;
begin
   Result := Self.Create;
end;

procedure TUserUpdateController.save;
begin
   FUserModel.DAO.Modify(FSelectedRecord);

   FSelectedRecord.name := FName;
   FSelectedRecord.email := FEmail;
   FSelectedRecord.username := FUserName;

   if not(FKeyPass = EmptyStr) then
      FSelectedRecord.keypass := FKeyPass;

   FSelectedRecord.status := FStatus;
   FSelectedRecord.UPDATEDAT := Now;

   FUserModel.DAO.Update(FSelectedRecord);
end;

function TUserUpdateController.selectedRecord(AValue: TTMNGUSER)
  : iUserUpdateController;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

function TUserUpdateController.status(AValue: Integer): iUserUpdateController;
begin
   Result := Self;
   FStatus := AValue;
end;

end.

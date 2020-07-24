unit UserInsert.Controller;

interface

uses User.Controller.Interf, User.Model.Interf, TMNGUSER.Entity.Model,
   System.SysUtils;

type
   TUserInsertController = class(TInterfacedObject, iUserInsertController)
   private
      FUserModel: IUserModel;

      FName: string;
      FEmail: string;
      FUserName: string;
      FKeyPass: string;
      FStatus: Integer;

      function getUserId: Integer;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iUserInsertController;

      function userModel(AValue: IUserModel): iUserInsertController;

      function name(AValue: string): iUserInsertController;
      function email(AValue: string): iUserInsertController;
      function username(AValue: string): iUserInsertController;
      function keypass(AValue: string): iUserInsertController;
      function status(AValue: Integer): iUserInsertController;

      procedure save;
   end;

implementation

{ TUserInsertController }

uses BCrypt.Controller;

constructor TUserInsertController.Create;
begin

end;

destructor TUserInsertController.Destroy;
begin

   inherited;
end;

function TUserInsertController.email(AValue: string): iUserInsertController;
begin
   Result := Self;
   FEmail := AValue;
end;

class function TUserInsertController.New: iUserInsertController;
begin
   Result := Self.Create;
end;

function TUserInsertController.getUserId: Integer;
begin
   if FUserModel.DAO.Find.Count <> 0 then
   begin
      Result := FUserModel.DAO.FindWhere('', 'USERID desc').Last.USERID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

function TUserInsertController.keypass(AValue: string): iUserInsertController;
var
   BCrypt: TBCrypt;
begin
   Result := Self;
   BCrypt := TBCrypt.Create;

   try
      FKeyPass := BCrypt.HashPassword(AValue, 14);
   finally
      BCrypt.Free;
   end;
end;

function TUserInsertController.name(AValue: string): iUserInsertController;
begin
   Result := Self;
   FName := AValue;
end;

procedure TUserInsertController.save;
begin
   FUserModel.Entity(TTMNGUSER.Create);

   FUserModel.Entity.USERID := getUserId;
   FUserModel.Entity.name := FName;
   FUserModel.Entity.email := FEmail;
   FUserModel.Entity.username := FUserName;
   FUserModel.Entity.keypass := FKeyPass;
   FUserModel.Entity.status := FStatus;
   FUserModel.Entity.CREATEDAT := Now;
   FUserModel.Entity.UPDATEDAT := Now;

   FUserModel.DAO.Insert(FUserModel.Entity);
end;

function TUserInsertController.status(AValue: Integer): iUserInsertController;
begin
   Result := Self;
   FStatus := AValue;
end;

function TUserInsertController.userModel(AValue: IUserModel)
  : iUserInsertController;
begin
   Result := Self;
   FUserModel := AValue;
end;

function TUserInsertController.username(AValue: string): iUserInsertController;
begin
   Result := Self;
   FUserName := AValue;
end;

end.

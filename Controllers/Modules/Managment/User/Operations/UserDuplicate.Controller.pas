unit UserDuplicate.Controller;

interface

uses User.Controller.Interf, User.Model.Interf,
  TMNGUSER.Entity.Model, System.SysUtils;

type
  TUserDuplicateController = class(TInterfacedObject,
    iUserDuplicateController)
  private
    FUserModel: iUserModel;

    FName: string;
    FEmail: string;
    FUserName: string;
    FKeyPass: string;
    FStatus: Integer;

  function getUserId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iUserDuplicateController;

    function userModel(AValue: iUserModel)
      : iUserDuplicateController;

    function name(AValue: string): iUserDuplicateController;
    function email(AValue: string): iUserDuplicateController;
    function username(AValue: string): iUserDuplicateController;
    function keypass(AValue: string): iUserDuplicateController;
    function status(AValue: Integer): iUserDuplicateController;

    procedure save;
  end;

implementation

{ TUserDuplicateController }

uses BCrypt.Controller;

constructor TUserDuplicateController.Create;
begin

end;

destructor TUserDuplicateController.Destroy;
begin

  inherited;
end;

function TUserDuplicateController.email(AValue: string): iUserDuplicateController;
begin
  Result := Self;
  FEmail := AValue;
end;

function TUserDuplicateController.userModel(AValue: iUserModel)
  : iUserDuplicateController;
begin
  Result := Self;
  FUserModel := AValue;
end;

function TUserDuplicateController.username(AValue: string): iUserDuplicateController;
begin
  Result := Self;
  FUserName := AValue;
end;

class function TUserDuplicateController.New: iUserDuplicateController;
begin
  Result := Self.Create;
end;

function TUserDuplicateController.getUserId: Integer;
begin
  if FUserModel.DAO.Find.Count <> 0 then  begin
    Result := FUserModel.DAO.FindWhere('', 'USERID desc').Last.USERID + 1;
  end else begin
    Result := 1;
  end;
end;

function TUserDuplicateController.keypass(AValue: string): iUserDuplicateController;
var bcrypt: TBCrypt;
begin
 Result := Self;
 bcrypt := TBCrypt.Create;

  try
    FKeyPass  := bcrypt.HashPassword(AValue, 14);
  finally
    bcrypt.Free;
  end;
end;

function TUserDuplicateController.name(AValue: string): iUserDuplicateController;
begin
  Result := Self;
  FName := AValue;
end;

procedure TUserDuplicateController.save;
begin
  FUserModel.Entity(TTMNGUSER.Create);

  FUserModel.Entity.USERID      := getUserId;
  FUserModel.Entity.NAME        := FName;
  FUserModel.Entity.EMAIL       := FEmail;
  FUserModel.Entity.USERNAME    := FUserName;
  FUserModel.Entity.KEYPASS     := FKeyPass;
  FUserModel.Entity.STATUS      := FStatus;
  FUserModel.Entity.CREATEDAT   := Now;
  FUserModel.Entity.UPDATEDAT   := Now;

  FUserModel.DAO.Insert(FUserModel.Entity);
end;


function TUserDuplicateController.status(AValue: Integer): iUserDuplicateController;
begin
  Result := Self;
  FStatus := AValue;
end;

end.

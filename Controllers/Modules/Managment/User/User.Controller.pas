unit User.Controller;

interface

uses User.Controller.Interf, User.Model.Interf, TMNGUSER.Entity.Model,
  System.SysUtils;

type
  TUserController = class(TInterfacedObject, iUserController)
  private
    FUserModel: IUserModel;
    FRecordFound: TTMNGUSER;

    FUserAuthenticated: TTMNGUSER;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iUserController;

    function find(AValue: string): iUserController;
    function autenticate(AUser: string; APassword: string): Boolean;

    function userNameExists(AUserName: string): Boolean; overload;
    function userNameExists(AUserCode: string; AUserName: string): Boolean; overload;

    function emailExists(AEmail: string): Boolean; overload;
    function emailExists(AUserCode: string; AEmail: string): Boolean; overload;

    function insert: iUserInsertController;
    function update: iUserUpdateController;
    function delete: iUserDeleteController;
    function duplicate: iUserDuplicateController;

    function code: string;
    function userId: string;
    function name: string;
    function email: string;
    function username: string;
    function keypass: string;
    function status: integer;
    function createdAt: string;
    function updatedAt: string;
  end;

implementation

{ TUserController }

uses Facade.Model, UserInsert.Controller, UserUpdate.Controller,
  UserDelete.Controller, UserDuplicate.Controller, BCrypt.Controller;

function TUserController.autenticate(AUser, APassword: string): Boolean;
var bcrypt: TBCrypt; hashNeedUpgrade: boolean;
begin
  try
    bcrypt := TBCrypt.Create;

     try
       FUserAuthenticated := FUserModel.DAO.FindWhere
         (Format('USERNAME = %s', [QuotedStr(AUser)])).Items[0];

      Result := bcrypt.CheckPassword(APassword, FUserAuthenticated.KEYPASS, hashNeedUpgrade);
     finally
       bcrypt.Free;
     end;

  except on E: Exception do
     Result := False;
  end;
end;

function TUserController.code: string;
begin
  Result := FRecordFound.CODE;
end;

function TUserController.userId: string;
begin
  Result := FRecordFound.USERID.ToString;
end;

function TUserController.username: string;
begin
  Result := FRecordFound.USERNAME;
end;

function TUserController.userNameExists(AUserCode, AUserName: string): Boolean;
begin
  Result := false;

  if FUserModel.DAO.FindWhere
    (Format('CODE <> %s and USERNAME = %s', [QuotedStr(AUserCode), QuotedStr(AUserName)])).Count > 0 then
  Result := True;
end;

function TUserController.userNameExists(AUserName: string): Boolean;
begin
  Result := false;

  if FUserModel.DAO.FindWhere
    (Format('USERNAME = %s', [QuotedStr(AUserName)])).Count > 0 then
  Result := True;
end;

constructor TUserController.Create;
begin
  FUserModel := TFacadeModel.New.moduleFacade.managmentFactoryModel.
    userModel;
end;

function TUserController.createdAt: string;
begin
  Result := DateTimeToStr(FRecordFound.CREATEDAT);
end;

function TUserController.delete: iUserDeleteController;
begin
  Result := TUserDeleteController.New.userModel(FUserModel)
    .selectedRecord(FRecordFound);
end;

destructor TUserController.Destroy;
begin

  inherited;
end;

function TUserController.duplicate: iUserDuplicateController;
begin
  Result := TUserDuplicateController.New.userModel(FUserModel);
end;

function TUserController.email: string;
begin
  Result := FRecordFound.EMAIL;
end;

function TUserController.emailExists(AEmail: string): Boolean;
begin
  Result := false;

  if FUserModel.DAO.FindWhere
    (Format('EMAIL = %s', [QuotedStr(AEmail)])).Count > 0 then
  Result := True;
end;

function TUserController.emailExists(AUserCode: string; AEmail: string): Boolean;
begin
  Result := false;

  if FUserModel.DAO.FindWhere
    (Format('CODE <> %s and EMAIL = %s', [QuotedStr(AUserCode), QuotedStr(AEmail)])).Count > 0 then
  Result := True;
end;

function TUserController.insert: iUserInsertController;
begin
  Result := TUserInsertController.New.userModel(FUserModel);
end;

function TUserController.keypass: string;
begin
  Result := FRecordFound.KEYPASS;
end;

function TUserController.name: string;
begin
  Result := FRecordFound.NAME;
end;

class function TUserController.New: iUserController;
begin
  Result := Self.Create;
end;

function TUserController.status: integer;
begin
  Result := FRecordFound.STATUS;
end;

function TUserController.find(AValue: string): iUserController;
begin
  Result := Self;

  FRecordFound := FUserModel.DAO.FindWhere
    (Format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TUserController.update: iUserUpdateController;
begin
  Result := TUserUpdateController.New.userModel(FUserModel)
    .selectedRecord(FRecordFound);
end;

function TUserController.updatedAt: string;
begin
  Result := DateTimeToStr(FRecordFound.UPDATEDAT);
end;

end.

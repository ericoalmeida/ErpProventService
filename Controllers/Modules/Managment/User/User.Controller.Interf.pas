unit User.Controller.Interf;

interface

uses User.Model.Interf, TMNGUSER.Entity.Model;

type
  iUserInsertController = interface;
  iUserUpdateController = interface;
  iUserDeleteController = interface;
  iUserDuplicateController = interface;

  iUserController = interface
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
    function status: Integer;
    function createdAt: string;
    function updatedAt: string;

  end;

  iUserInsertController = interface
    function userModel(AValue: iUserModel): iUserInsertController;

    function name(AValue: string): iUserInsertController;
    function email(AValue: string): iUserInsertController;
    function username(AValue: string): iUserInsertController;
    function keypass(AValue: string): iUserInsertController;
    function status(AValue: Integer): iUserInsertController;

    procedure save;
  end;

  iUserUpdateController = interface
    function userModel(AValue: iUserModel): iUserUpdateController;
    function selectedRecord(AValue: TTMNGUSER): iUserUpdateController;

    function name(AValue: string): iUserUpdateController;
    function email(AValue: string): iUserUpdateController;
    function username(AValue: string): iUserUpdateController;
    function keypass(AValue: string): iUserUpdateController;
    function status(AValue: Integer): iUserUpdateController;

    procedure save;
  end;

  iUserDeleteController = interface
    function userModel(AValue: iUserModel): iUserDeleteController;
    function selectedRecord(AValue: TTMNGUSER): iUserDeleteController;

    procedure save;
  end;

  iUserDuplicateController = interface
    function userModel(AValue: iUserModel): iUserDuplicateController;

    function name(AValue: string): iUserDuplicateController;
    function email(AValue: string): iUserDuplicateController;
    function username(AValue: string): iUserDuplicateController;
    function keypass(AValue: string): iUserDuplicateController;
    function status(AValue: Integer): iUserDuplicateController;

    procedure save;
  end;

implementation

end.

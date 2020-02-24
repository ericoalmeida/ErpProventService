unit User.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TMNGUSER.Entity.Model;

type
  IUserModel = interface
    ['{22016893-FD1B-4DD5-AFC1-DED8388BD2A5}']
    function Entity: TTMNGUSER; overload;
    function Entity(AValue: TTMNGUSER): IUserModel; overload;
    function DAO: IContainerObjectSet<TTMNGUSER>;
  end;

implementation

end.

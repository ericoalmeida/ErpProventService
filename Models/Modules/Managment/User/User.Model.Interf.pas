unit User.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TMNGUSER.Entity.Model;

type
  IUserModel = interface
    function Entity: TTMNGUSER; overload;
    function Entity(AValue: TTMNGUSER): IUserModel; overload;
    function DAO: IContainerObjectSet<TTMNGUSER>;
  end;

implementation

end.

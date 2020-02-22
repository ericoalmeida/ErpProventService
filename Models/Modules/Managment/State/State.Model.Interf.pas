unit State.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TMNGSTATE.Entity.Model;

type
  IStateModel = interface
    function Entity: TTMNGSTATE; overload;
    function Entity(AValue: TTMNGSTATE): IStateModel; overload;
    function DAO: IContainerObjectSet<TTMNGSTATE>;
  end;

implementation

end.

unit State.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TMNGSTATE.Entity.Model;

type
   IStateModel = interface
      ['{BDBDB601-60B5-4866-B0C9-85BAC4B061CE}']
      function Entity: TTMNGSTATE; overload;
      function Entity(AValue: TTMNGSTATE): IStateModel; overload;
      function DAO: IContainerObjectSet<TTMNGSTATE>;
   end;

implementation

end.

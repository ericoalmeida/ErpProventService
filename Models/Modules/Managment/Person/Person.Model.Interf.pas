unit Person.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TMNGPERSON.Entity.Model;

type
  IPersonModel = interface
    function Entity: TTMNGPERSON; overload;
    function Entity(AValue: TTMNGPERSON): IPersonModel; overload;
    function DAO: IContainerObjectSet<TTMNGPERSON>;
  end;

implementation

end.

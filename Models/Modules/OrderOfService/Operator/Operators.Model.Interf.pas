unit Operators.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TORDOPERATOR.Entity.Model;

type
  IOperatorModel = interface
    function Entity: TTORDOPERATOR; overload;
    function Entity(AValue: TTORDOPERATOR): IOperatorModel; overload;
    function DAO: IContainerObjectSet<TTORDOPERATOR>;
  end;

implementation

end.

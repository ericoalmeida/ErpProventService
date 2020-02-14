unit State.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TGERESTADO.Entity.Model;

type
  IStateModel = interface
    function Entity: TTGERESTADO; overload;
    function Entity(AValue: TTGERESTADO): IStateModel; overload;
    function DAO: IContainerObjectSet<TTGERESTADO>;
  end;

implementation

end.

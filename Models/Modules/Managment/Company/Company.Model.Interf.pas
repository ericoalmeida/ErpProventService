unit Company.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TMNGCOMPANY.Entity.Model;

type
  ICompanyModel = interface
    function Entity: TTMNGCOMPANY; overload;
    function Entity(AValue: TTMNGCOMPANY): ICompanyModel; overload;
    function DAO: IContainerObjectSet<TTMNGCOMPANY>;
  end;

implementation

end.

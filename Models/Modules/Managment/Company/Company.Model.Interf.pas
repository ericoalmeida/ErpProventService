unit Company.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TMNGCOMPANY.Entity.Model;

type
  ICompanyModel = interface
    ['{D35F483A-0823-4326-B442-DE47B400741C}']
    function Entity: TTMNGCOMPANY; overload;
    function Entity(AValue: TTMNGCOMPANY): ICompanyModel; overload;
    function DAO: IContainerObjectSet<TTMNGCOMPANY>;
  end;

implementation

end.

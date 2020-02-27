unit Service.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TORDSERVICE.Entity.Model;

type
  IServiceModel = interface
    ['{B6094316-75A6-4ACF-8965-D62E904E2A61}']
    function Entity: TTORDSERVICE; overload;
    function Entity(AValue: TTORDSERVICE): IServiceModel; overload;
    function DAO: IContainerObjectSet<TTORDSERVICE>;
  end;

implementation

end.

unit ServiceProvided.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TORDSERVICESPROVIDED.Entity.Model;

type
   IServiceProvidedModel = interface
      function Entity: TTORDSERVICESPROVIDED; overload;
      function Entity(AValue: TTORDSERVICESPROVIDED)
        : IServiceProvidedModel; overload;
      function DAO: IContainerObjectSet<TTORDSERVICESPROVIDED>;
   end;

implementation

end.

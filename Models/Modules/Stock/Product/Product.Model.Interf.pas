unit Product.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TSTOPRODUCT.Entity.Model;

type
  IProductModel = interface
    ['{DBBDDD65-2EA9-4CA1-8815-80495C288AA8}']
    function Entity: TTSTOPRODUCT; overload;
    function Entity(AValue: TTSTOPRODUCT): IProductModel; overload;
    function DAO: IContainerObjectSet<TTSTOPRODUCT>;
  end;

implementation

end.

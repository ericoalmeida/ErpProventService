unit SinapiProduct.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TSTOSINAPIPRODUCT.Entity.Model;

type
  iSinapiProductModel = interface
    ['{DBBDDD65-2EA9-4CA1-8815-80495C288AA8}']
    function Entity: TTSTOSINAPIPRODUCT; overload;
    function Entity(AValue: TTSTOSINAPIPRODUCT): iSinapiProductModel; overload;
    function DAO: IContainerObjectSet<TTSTOSINAPIPRODUCT>;
  end;

implementation

end.

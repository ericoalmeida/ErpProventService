unit Country.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TGERPAIS.Entity.Model;

type
  ICountryModel = interface
    function Entity: TTMNGCOUNTRY; overload;
    function Entity(AValue: TTMNGCOUNTRY): ICountryModel; overload;
    function DAO: IContainerObjectSet<TTMNGCOUNTRY>;
  end;

implementation

end.

unit Country.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TGERPAIS.Entity.Model;

type
  ICountryModel = interface
    function Entity: TTGERPAIS; overload;
    function Entity(AValue: TTGERPAIS): ICountryModel; overload;
    function DAO: IContainerObjectSet<TTGERPAIS>;
  end;

implementation

end.

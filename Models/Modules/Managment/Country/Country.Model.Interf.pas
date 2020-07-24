unit Country.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TMNGCOUNTRY.Entity.Model;

type
   ICountryModel = interface
      ['{6469CE7E-F718-4E2E-B277-532F9A0240E8}']
      function Entity: TTMNGCOUNTRY; overload;
      function Entity(AValue: TTMNGCOUNTRY): ICountryModel; overload;
      function DAO: IContainerObjectSet<TTMNGCOUNTRY>;
   end;

implementation

end.

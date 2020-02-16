unit City.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TMNGCITY.Entity.Model;

type
  iCityModel = interface
    function Entity: TTMNGCITY; overload;
    function Entity(AValue: TTMNGCITY): iCityModel; overload;
    function DAO: IContainerObjectSet<TTMNGCITY>;
  end;

implementation

end.

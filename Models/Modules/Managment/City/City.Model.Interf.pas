unit City.Model.Interf;

interface

uses ormbr.container.objectset.interfaces, TMNGCITY.Entity.Model;

type
  iCityModel = interface
    ['{2904A65E-617D-423F-BDEB-8EF850CD88D7}']
    function Entity: TTMNGCITY; overload;
    function Entity(AValue: TTMNGCITY): iCityModel; overload;
    function DAO: IContainerObjectSet<TTMNGCITY>;
  end;

implementation

end.

unit ManagmentFactory.Controller.interf;

interface

uses District.Controller.Interf, Country.Controller.Interf;

type
 iManagmentFactoryController = interface
   ['{F7BBE560-AD84-469D-B05F-E8015B7C7DBB}']
   function districtController: iDistrictController;
   function countryController: iCountryController;
 end;

implementation

end.

unit ManagmentFactory.Controller.interf;

interface

uses District.Controller.interf, Country.Controller.interf,
   State.Controller.interf,
   City.Controller.interf, Company.Controller.interf, User.Controller.interf,
   Person.Controller.interf;

type
   iManagmentFactoryController = interface
      ['{F7BBE560-AD84-469D-B05F-E8015B7C7DBB}']
      function districtController: iDistrictController;
      function countryController: iCountryController;
      function stateController: iStateController;
      function cityController: iCityController;
      function companyController: iCompanyController;
      function userController: iUserController;
      function personController: iPersonController;
   end;

implementation

end.

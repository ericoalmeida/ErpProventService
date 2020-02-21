unit ManagmentFactory.Model.Interf;

interface

uses Districts.Model.Interf, Country.Model.Interf, State.Model.Interf,
  City.Model.Interf,
  Company.Model.Interf;

type
  iManagmentFactoryModel = interface
    ['{147732FD-A51B-4706-BF9F-AFC50408A707}']
    function districtModel: iDistrictModel;
    function countryModel: ICountryModel;
    function stateModel: IStateModel;
    function cityModel: iCityModel;
    function companyModel: ICompanyModel;
  end;

implementation

end.

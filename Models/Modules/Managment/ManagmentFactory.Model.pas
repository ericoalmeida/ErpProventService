unit ManagmentFactory.Model;

interface

uses ManagmentFactory.Model.Interf, Districts.Model.Interf,
   Country.Model.Interf, State.Model.Interf, City.Model.Interf,
   Company.Model.Interf,
   User.Model.Interf, Person.Model.Interf;

type
   TManagmentFactoryModel = class(TInterfacedObject, iManagmentFactoryModel)
   private
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iManagmentFactoryModel;

      function districtModel: iDistrictModel;
      function countryModel: ICountryModel;
      function stateModel: IStateModel;
      function cityModel: iCityModel;
      function companyModel: ICompanyModel;
      function userModel: IUserModel;
      function personModel: IPersonModel;
   end;

implementation

{ TManagmentFactoryModel }

uses Districts.Model, Country.Model, State.Model, City.Model, Company.Model,
   User.Model, Person.Model;

function TManagmentFactoryModel.cityModel: iCityModel;
begin
   Result := TCityModel.New;
end;

function TManagmentFactoryModel.companyModel: ICompanyModel;
begin
   Result := TCompanyModel.New;
end;

function TManagmentFactoryModel.countryModel: ICountryModel;
begin
   Result := TCountryModel.New;
end;

constructor TManagmentFactoryModel.Create;
begin

end;

destructor TManagmentFactoryModel.Destroy;
begin

   inherited;
end;

function TManagmentFactoryModel.districtModel: iDistrictModel;
begin
   Result := TDistrictModel.New;
end;

class function TManagmentFactoryModel.New: iManagmentFactoryModel;
begin
   Result := Self.Create;
end;

function TManagmentFactoryModel.personModel: IPersonModel;
begin
   Result := TPersonModel.New;
end;

function TManagmentFactoryModel.stateModel: IStateModel;
begin
   Result := TStateModel.New;
end;

function TManagmentFactoryModel.userModel: IUserModel;
begin
   Result := TUserModel.New;
end;

end.

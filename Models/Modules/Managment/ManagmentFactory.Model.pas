unit ManagmentFactory.Model;

interface

uses ManagmentFactory.Model.Interf, Districts.Model.Interf,
  Country.Model.Interf, State.Model.Interf, City.Model.Interf;

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
  end;

implementation

{ TManagmentFactoryModel }

uses Districts.Model, Country.Model, State.Model, City.Model;

function TManagmentFactoryModel.cityModel: iCityModel;
begin
  Result := TCityModel.New;
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

function TManagmentFactoryModel.stateModel: IStateModel;
begin
  Result := TStateModel.New;
end;

end.

unit ManagmentFactory.Controller;

interface

uses ManagmentFactory.Controller.interf, District.Controller.interf,
  Country.Controller.interf;

type
  TManagmentFactoryController = class(TInterfacedObject,
    iManagmentFactoryController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iManagmentFactoryController;

    function districtController: iDistrictController;
    function countryController: iCountryController;

  end;

implementation

{ TManagmentFactoryController }

uses District.Controller, Country.Controller;

function TManagmentFactoryController.countryController: iCountryController;
begin
  Result := TCountryController.New;
end;

constructor TManagmentFactoryController.Create;
begin

end;

destructor TManagmentFactoryController.Destroy;
begin

  inherited;
end;

function TManagmentFactoryController.districtController: iDistrictController;
begin
  Result := TDistrictController.New;
end;

class function TManagmentFactoryController.New: iManagmentFactoryController;
begin
  Result := Self.Create;
end;

end.

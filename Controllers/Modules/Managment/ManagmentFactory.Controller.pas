unit ManagmentFactory.Controller;

interface

uses ManagmentFactory.Controller.interf, District.Controller.interf;

type
  TManagmentFactoryController = class(TInterfacedObject,
    iManagmentFactoryController)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iManagmentFactoryController;

    function districtController: iDistrictController;
  end;

implementation

{ TManagmentFactoryController }

uses District.Controller;

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

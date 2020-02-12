unit DistrictDuplicate.Controller;

interface

uses District.Controller.Interf, Districts.Model.Interf,
  TGERBAIRRO.Entity.Model;

type
  TDistrictDuplicateController = class(TInterfacedObject,
    iDistrictDuplicateController)
  private
    FDistrictModel: iDistrictModel;
    FDescription: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iDistrictDuplicateController;

    function districtModel(AValue: iDistrictModel)
      : iDistrictDuplicateController;

    function description(AValue: string): iDistrictDuplicateController;

    procedure save;
  end;

implementation

{ TDistrictDuplicateController }

constructor TDistrictDuplicateController.Create;
begin

end;

function TDistrictDuplicateController.description(AValue: string)
  : iDistrictDuplicateController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TDistrictDuplicateController.Destroy;
begin

  inherited;
end;

function TDistrictDuplicateController.districtModel(AValue: iDistrictModel)
  : iDistrictDuplicateController;
begin
  Result := Self;
  FDistrictModel := AValue;
end;

class function TDistrictDuplicateController.New: iDistrictDuplicateController;
begin
  Result := Self.Create;
end;

procedure TDistrictDuplicateController.save;
begin
  FDistrictModel.Entity(TTGERBAIRRO.Create);

  FDistrictModel.Entity.DESCRICAO := FDescription;

  FDistrictModel.DAO.Insert(FDistrictModel.Entity);
end;


end.

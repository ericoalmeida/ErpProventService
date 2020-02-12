unit DistrictInsert.Controller;

interface

uses District.Controller.Interf, Districts.Model.Interf,
  TGERBAIRRO.Entity.Model;

type
  TDistrictInsertController = class(TInterfacedObject,
    iDistrictInsertController)
  private
    FDistrictModel: iDistrictModel;
    FDescription: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iDistrictInsertController;

    function districtModel(AValue: iDistrictModel): iDistrictInsertController;
    function description(AValue: string): iDistrictInsertController;

    procedure save;
  end;

implementation

{ TDistrictInsertController }

constructor TDistrictInsertController.Create;
begin

end;

function TDistrictInsertController.description(AValue: string)
  : iDistrictInsertController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TDistrictInsertController.Destroy;
begin

  inherited;
end;

function TDistrictInsertController.districtModel(AValue: iDistrictModel)
  : iDistrictInsertController;
begin
  Result := Self;
  FDistrictModel := AValue;
end;

class function TDistrictInsertController.New: iDistrictInsertController;
begin
  Result := Self.Create;
end;

procedure TDistrictInsertController.save;
begin
  FDistrictModel.Entity(TTGERBAIRRO.Create);

  FDistrictModel.Entity.DESCRICAO := FDescription;

  FDistrictModel.DAO.Insert(FDistrictModel.Entity);
end;

end.

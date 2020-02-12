unit District.Controller;

interface

uses District.Controller.Interf, TGERBAIRRO.Entity.Model,
  Districts.Model.Interf;

type
  TDistrictController = class(TInterfacedObject, iDistrictController)
  private
    FDistrictModel: iDistrictModel;
    FRecordFound: TTGERBAIRRO;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iDistrictController;

    function toLocate(AValue: string): iDistrictController;

    function insert: iDistrictInsertController;
    function update: iDistrictUpdateController;
    function delete: iDistrictDeleteController;
    function duplicate: iDistrictDuplicateController;

    function districtId: string;
    function description: string;
  end;

implementation

{ TDistrictController }

uses Facade.Model, System.SysUtils, DistrictInsert.Controller,
  DistrictUpdate.Controller, DistrictDelete.Controller,
  DistrictDuplicate.Controller;

constructor TDistrictController.Create;
begin
  FDistrictModel := TFacadeModel.New.moduleFacade.managmentFactoryModel.
    districtModel;
end;

function TDistrictController.delete: iDistrictDeleteController;
begin
  Result := TDistrictDeleteController.New.districtModel(FDistrictModel)
    .selectedDistrict(FRecordFound)
end;

function TDistrictController.description: string;
begin
  Result := FRecordFound.DESCRICAO;
end;

destructor TDistrictController.Destroy;
begin

  inherited;
end;

function TDistrictController.districtId: string;
begin
  Result := FRecordFound.BAIRROID.ToString;
end;

function TDistrictController.duplicate: iDistrictDuplicateController;
begin
  Result := TDistrictDuplicateController.New.districtModel(FDistrictModel);
end;

function TDistrictController.insert: iDistrictInsertController;
begin
  Result := TDistrictInsertController.New.districtModel(FDistrictModel)
end;

class function TDistrictController.New: iDistrictController;
begin
  Result := Self.Create;
end;

function TDistrictController.toLocate(AValue: string): iDistrictController;
begin
  Result := Self;

  FRecordFound := FDistrictModel.DAO.FindWhere
    (format('CODIGO = %s', [QuotedStr(AValue)])).Items[0];
end;

function TDistrictController.update: iDistrictUpdateController;
begin
  Result := TDistrictUpdateController.New.districtModel(FDistrictModel)
    .selectedDistrict(FRecordFound)
end;

end.

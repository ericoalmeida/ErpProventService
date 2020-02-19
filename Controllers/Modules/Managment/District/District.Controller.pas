unit District.Controller;

interface

uses District.Controller.Interf, TGERBAIRRO.Entity.Model,
  Districts.Model.Interf;

type
  TDistrictController = class(TInterfacedObject, iDistrictController)
  private
    FDistrictModel: iDistrictModel;
    FRecordFound: TTMNGDISTRICT;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iDistrictController;

    function find(AValue: string): iDistrictController;

    function insert: iDistrictInsertController;
    function update: iDistrictUpdateController;
    function delete: iDistrictDeleteController;
    function duplicate: iDistrictDuplicateController;

    function districtId: string;
    function description: string;
    function cityId: string;
    function cityName: string;
    function zipCode: string;
    function createdDate: string;
    function updatedDate: string;
  end;

implementation

{ TDistrictController }

uses Facade.Model, System.SysUtils, DistrictInsert.Controller,
  DistrictUpdate.Controller, DistrictDelete.Controller,
  DistrictDuplicate.Controller;

function TDistrictController.cityId: string;
begin
  Result := FRecordFound.TMNGCITY.CITYID.ToString;
end;

function TDistrictController.cityName: string;
begin
  Result := FRecordFound.TMNGCITY.NAME;
end;

constructor TDistrictController.Create;
begin
  FDistrictModel := TFacadeModel.New.moduleFacade.managmentFactoryModel.
    districtModel;
end;

function TDistrictController.createdDate: string;
begin
  Result := DateTimeToStr(FRecordFound.CREATEDAT);
end;

function TDistrictController.delete: iDistrictDeleteController;
begin
  Result := TDistrictDeleteController.New.districtModel(FDistrictModel)
    .selectedDistrict(FRecordFound)
end;

function TDistrictController.description: string;
begin
  Result := FRecordFound.DESCRIPTION;
end;

destructor TDistrictController.Destroy;
begin

  inherited;
end;

function TDistrictController.districtId: string;
begin
  Result := FRecordFound.DISTRICTID.ToString;
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

function TDistrictController.find(AValue: string): iDistrictController;
begin
  Result := Self;

  FRecordFound := FDistrictModel.DAO.FindWhere
    (format('CODE = %s', [QuotedStr(AValue)])).Items[0];
end;

function TDistrictController.update: iDistrictUpdateController;
begin
  Result := TDistrictUpdateController.New.districtModel(FDistrictModel)
    .selectedDistrict(FRecordFound)
end;

function TDistrictController.updatedDate: string;
begin
  Result := DateTimeToStr(FRecordFound.UPDATEDAT);
end;

function TDistrictController.zipCode: string;
begin
  Result := FRecordFound.ZIPCODE;
end;

end.

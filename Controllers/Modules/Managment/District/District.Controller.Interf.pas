unit District.Controller.Interf;

interface

uses Districts.Model.Interf, TGERBAIRRO.Entity.Model;

type
  iDistrictInsertController = interface;
  iDistrictUpdateController = interface;
  iDistrictDeleteController = interface;
  iDistrictDuplicateController = interface;

  iDistrictController = interface
    ['{72B5CC0A-D76E-4374-AC9E-D2D6E82F8506}']
    function toLocate(AValue: string): iDistrictController;

    function insert: iDistrictInsertController;
    function update: iDistrictUpdateController;
    function delete: iDistrictDeleteController;
    function duplicate: iDistrictDuplicateController;

    function districtId: string;
    function description: string;
  end;

  iDistrictInsertController = interface
    ['{DA93311A-CEEE-40BF-BCAA-462664D8DB27}']
    function districtModel(AValue: iDistrictModel): iDistrictInsertController;

    function description(AValue: string): iDistrictInsertController;
    procedure save;
  end;

  iDistrictUpdateController = interface
    ['{C4FFF5A2-CC31-4B13-87DD-ECBC6E9FE036}']
    function districtModel(AValue: iDistrictModel): iDistrictUpdateController;
    function selectedDistrict(AValue: TTGERBAIRRO): iDistrictUpdateController;

    function description(AValue: string): iDistrictUpdateController;
    procedure save;
  end;

  iDistrictDeleteController = interface
    ['{2153CA0E-D898-49CE-BD1E-9F5955AA436A}']
    function districtModel(AValue: iDistrictModel): iDistrictDeleteController;
    function selectedDistrict(AValue: TTGERBAIRRO): iDistrictDeleteController;

    procedure save;
  end;

  iDistrictDuplicateController = interface
    ['{55098735-833A-4D25-8433-B5BF57B6B1A7}']
    function districtModel(AValue: iDistrictModel)
      : iDistrictDuplicateController;
    function description(AValue: string): iDistrictDuplicateController;

    procedure save;
  end;

implementation

end.

unit City.Controller.Interf;

interface

uses City.Model.Interf, TMNGCITY.Entity.Model;

type
  iCityInsertController = interface;
  iCityUpdateController = interface;
  iCityDeleteController = interface;
  iCityDuplicateController = interface;

  iCityController = interface
    function find(AValue: string): iCityController;

    function insert: iCityInsertController;
    function update: iCityUpdateController;
    function Delete: iCityDeleteController;
    function Duplicate: iCityDuplicateController;

    function cityId: string;
    function name: string;
    function zipCode: string;
    function ibgeCode: string;
    function stateId: string;
    function stateDescription: string;

    function createdAt: string;
    function updatedAt: string;
  end;

  iCityInsertController = interface
    function cityModel(AValue: iCityModel): iCityInsertController;

    function name(AValue: string): iCityInsertController;
    function zipCode(AValue: string): iCityInsertController;
    function ibgeCode(AValue: string): iCityInsertController;
    function stateId(AValue: string): iCityInsertController;

    procedure save;
  end;

  iCityUpdateController = interface
    function cityModel(AValue: iCityModel): iCityUpdateController;
    function selectedRecord(AValue: TTMNGCITY): iCityUpdateController;

    function name(AValue: string): iCityUpdateController;
    function zipCode(AValue: string): iCityUpdateController;
    function ibgeCode(AValue: string): iCityUpdateController;
    function stateId(AValue: string): iCityUpdateController;

    procedure save;
  end;

  iCityDeleteController = interface
    function cityModel(AValue: iCityModel): iCityDeleteController;
    function selectedRecord(AValue: TTMNGCITY): iCityDeleteController;

    procedure save;
  end;

  iCityDuplicateController = interface
    function cityModel(AValue: iCityModel): iCityDuplicateController;

    function name(AValue: string): iCityDuplicateController;
    function zipCode(AValue: string): iCityDuplicateController;
    function ibgeCode(AValue: string): iCityDuplicateController;
    function stateId(AValue: string): iCityDuplicateController;

    procedure save;
  end;

implementation

end.

unit Person.Controller.Interf;

interface

uses Person.Model.Interf, TMNGPERSON.Entity.Model;

type
  iPersonInsertController = interface;
  iPersonUpdateController = interface;
  iPersonDeleteController = interface;
  iPersonDuplicateController = interface;

  iPersonController = interface
    function find(AValue: string): iPersonController;

    function insert: iPersonInsertController;
    function update: iPersonUpdateController;
    function delete: iPersonDeleteController;
    function duplicate: iPersonDuplicateController;

    function code: string;
    function personId: string;
    function name: string;
    function fancyName: string;
    function cpfcnpj: string;
    function rgie: string;
    function address: string;
    function districtId: string;
    function districtName: string;
    function phoneNumber: string;
    function email: string;
    function status: integer;
    function createdAt: string;
    function updatedAt: string;
  end;

  iPersonInsertController = interface
    function personModel(AValue: IPersonModel): iPersonInsertController;

    function companyId(AValue: string): iPersonInsertController;
    function personType(AValue: Integer): iPersonInsertController;
    function name(AValue: string): iPersonInsertController;
    function fancyName(AValue: string): iPersonInsertController;
    function CPFCNPJ(AValue: string): iPersonInsertController;
    function RGIE(AValue: string): iPersonInsertController;
    function address(AValue: string): iPersonInsertController;
    function districtId(AValue: string): iPersonInsertController;
    function phoneNumber(AValue: string): iPersonInsertController;
    function email(AValue: string): iPersonInsertController;
    function status(AValue: Integer): iPersonInsertController;
    function userId(AValue: string): iPersonInsertController;

    procedure save;
  end;

  iPersonUpdateController = interface
    function personModel(AValue: IPersonModel): iPersonUpdateController;
    function selectedRecord(AValue: TTMNGPERSON): iPersonUpdateController;

    function companyId(AValue: string): iPersonUpdateController;
    function personType(AValue: Integer): iPersonUpdateController;
    function name(AValue: string): iPersonUpdateController;
    function fancyName(AValue: string): iPersonUpdateController;
    function CPFCNPJ(AValue: string): iPersonUpdateController;
    function RGIE(AValue: string): iPersonUpdateController;
    function address(AValue: string): iPersonUpdateController;
    function districtId(AValue: string): iPersonUpdateController;
    function phoneNumber(AValue: string): iPersonUpdateController;
    function email(AValue: string): iPersonUpdateController;
    function status(AValue: Integer): iPersonUpdateController;
    function userId(AValue: string): iPersonUpdateController;

    procedure save;
  end;

  iPersonDeleteController = interface
    function personModel(AValue: IPersonModel): iPersonDeleteController;
    function selectedRecord(AValue: TTMNGPERSON): iPersonDeleteController;

    procedure save;
  end;

  iPersonDuplicateController = interface
    function personModel(AValue: IPersonModel): iPersonDuplicateController;

    function companyId(AValue: string): iPersonDuplicateController;
    function personType(AValue: Integer): iPersonDuplicateController;
    function name(AValue: string): iPersonDuplicateController;
    function fancyName(AValue: string): iPersonDuplicateController;
    function CPFCNPJ(AValue: string): iPersonDuplicateController;
    function RGIE(AValue: string): iPersonDuplicateController;
    function address(AValue: string): iPersonDuplicateController;
    function districtId(AValue: string): iPersonDuplicateController;
    function phoneNumber(AValue: string): iPersonDuplicateController;
    function email(AValue: string): iPersonDuplicateController;
    function status(AValue: Integer): iPersonDuplicateController;
    function userId(AValue: string): iPersonDuplicateController;

    procedure save;
  end;

implementation

end.

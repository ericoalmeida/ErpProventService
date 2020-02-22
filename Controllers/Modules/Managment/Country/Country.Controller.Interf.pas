unit Country.Controller.Interf;

interface

uses Country.Model.Interf, TMNGCOUNTRY.Entity.Model;

type
  iCountryInsertController = interface;
  iCountryUpdateController = interface;
  iCountryDeleteController = interface;
  iCountryDuplicateController = interface;

  iCountryController = interface
    function find(AValue: string): iCountryController;
    function findById(AValue: string): iCountryController;

    function insert: iCountryInsertController;
    function update: iCountryUpdateController;
    function delete: iCountryDeleteController;
    function duplicate: iCountryDuplicateController;

    function codigo: string;
    function countryId: string;
    function description: string;
    function createdDate: string;
    function updatedDate: string;
  end;

  iCountryInsertController = interface
    function countryModel(AValue: ICountryModel): iCountryInsertController;
    function name(AValue: string): iCountryInsertController;

    procedure save;
  end;

  iCountryUpdateController = interface
    function countryModel(AValue: ICountryModel): iCountryUpdateController;
    function selectedRecord(AValue: TTMNGCOUNTRY): iCountryUpdateController;

    function name(AValue: string): iCountryUpdateController;

    procedure save;
  end;

  iCountryDeleteController = interface
    function countryModel(AValue: ICountryModel): iCountryDeleteController;
    function selectedRecord(AValue: TTMNGCOUNTRY): iCountryDeleteController;

    procedure save;
  end;

  iCountryDuplicateController = interface
    function countryModel(AValue: ICountryModel): iCountryDuplicateController;

    function name(AValue: string): iCountryDuplicateController;

    procedure save;
  end;

implementation

end.

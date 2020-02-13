unit Country.Controller.Interf;

interface

uses Country.Model.Interf, TGERPAIS.Entity.Model;

type
  iCountryInsertController = interface;
  iCountryUpdateController = interface;
  iCountryDeleteController = interface;
  iCountryDuplicateController = interface;

  iCountryController = interface
    function find(AValue: string): iCountryController;
    // function findById(AValue: Integer): iCountryController;

    function insert: iCountryInsertController;
    function update: iCountryUpdateController;
    function delete: iCountryDeleteController;
    function duplicate: iCountryDuplicateController;

    function countryId: string;
    function description: string;
    function createdDate: string;
    function updatedDate: string;
  end;

  iCountryInsertController = interface
    function countryModel(AValue: ICountryModel): iCountryInsertController;
    function description(AValue: string): iCountryInsertController;

    procedure save;
  end;

  iCountryUpdateController = interface
    function countryModel(AValue: ICountryModel): iCountryUpdateController;
    function selectedTemplate(AValue: TTGERPAIS): iCountryUpdateController;

    procedure save;
  end;

  iCountryDeleteController = interface
    function countryModel(AValue: ICountryModel): iCountryDeleteController;
    function selectedTemplate(AValue: TTGERPAIS): iCountryDeleteController;

    procedure save;
  end;

  iCountryDuplicateController = interface
    function countryModel(AValue: ICountryModel): iCountryDuplicateController;
    function selectedTemplate(AValue: TTGERPAIS): iCountryDuplicateController;

    procedure save;
  end;

implementation

end.

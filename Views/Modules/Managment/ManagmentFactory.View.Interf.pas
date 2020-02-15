unit ManagmentFactory.View.Interf;

interface

uses Types.Views, Base.View.interf;

type
 iManagmentFactoryView = interface
   ['{0E651752-B7CD-409B-A0C7-5D6F904F6184}']
   function showProgramOfListing(AValue: TTypeListingPrograms): iBaseListView;
   function showProgramOfRegister(AValue: TTypeRegisterPrograms): iBaseRegisterView;
   function showProgramOfSearch(AValue: TTypeSearchPrograms): IBaseSearchView;
 end;

implementation

end.

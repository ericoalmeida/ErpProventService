unit OrdemOfServiceFactory.View.Interf;

interface

uses Base.View.Interf, Types.Views;

type
  iOrdemOfServiceFactoryView = interface
    ['{3F385DDC-16D4-4C54-85D3-BA82EE71C910}']
    function showProgramOfListing(AValue: TTypeListingPrograms): iBaseListView;
    function showProgramOfRegister(AValue: TTypeRegisterPrograms)
      : iBaseRegisterView;
    function showProgramOfSearch(AValue: TTypeSearchPrograms): IBaseSearchView;
  end;

implementation

end.

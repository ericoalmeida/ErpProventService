unit AssetsFactory.View.Interf;

interface

uses Base.View.Interf, Types.Views;

type
   iAssetsFactoryView = interface
      ['{E1510B2D-8F24-42D6-85DF-22FF41C04669}']
      function showProgramOfListing(AValue: TTypeListingPrograms)
        : iBaseListView;
      function showProgramOfRegister(AValue: TTypeRegisterPrograms)
        : iBaseRegisterView;
      function showProgramOfSearch(AValue: TTypeSearchPrograms)
        : IBaseSearchView;
   end;

implementation

end.

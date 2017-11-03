unit untDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    qryUsuario: TFDQuery;
    dtsUsuario: TDataSource;
    qryInseminacao: TFDQuery;
    dtsInseminacao: TDataSource;
    qryCria: TFDQuery;
    dtsCria: TDataSource;
    dtsProprietario: TDataSource;
    qryProprietario: TFDQuery;
    qryMae: TFDQuery;
    dtsMae: TDataSource;
    qryCadastro: TFDQuery;
    dtsCadastro: TDataSource;
    qryConfirmados: TFDQuery;
    dtsConfirmados: TDataSource;
    qryAConfirmar: TFDQuery;
    dtsAConfirmar: TDataSource;
    qryAnimal: TFDQuery;
    dtsAnimal: TDataSource;
    qryVeterinario: TFDQuery;
    dtsVeterinario: TDataSource;
    qryCadInseminacao: TFDQuery;
    dtsCadInseminacao: TDataSource;
    qryConfiguracao: TFDQuery;
    dtsConfiguracao: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

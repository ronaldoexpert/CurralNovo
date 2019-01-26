program ManagerReport;

uses
  Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untDM in 'untDM.pas' {DM: TDataModule},
  untRelProprietarios in 'untRelProprietarios.pas' {frmRelProprietario},
  untRelInseminacao in 'untRelInseminacao.pas' {frmRelInseminacoes},
  untPesquisa in 'untPesquisa.pas' {frmPesquisa},
  untRelAnimais in 'untRelAnimais.pas' {frmRelAnimais},
  untGraficos in 'untGraficos.pas' {frmRelGraficos};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.

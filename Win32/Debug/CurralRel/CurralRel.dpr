program CurralRel;

uses
  Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untDM in 'untDM.pas' {DM: TDataModule},
  untRelProprietarios in 'untRelProprietarios.pas' {frmRelProprietario};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmRelProprietario, frmRelProprietario);
  Application.Run;
end.

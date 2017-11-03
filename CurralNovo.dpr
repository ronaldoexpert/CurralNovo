program CurralNovo;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untLogin in 'untLogin.pas' {frmLogin},
  untCadastroUsuario in 'untCadastroUsuario.pas' {frmCadastroUsuario},
  unstCadastroVeterinario in 'unstCadastroVeterinario.pas' {frmCadastroVeterinario},
  untCadastroProdutor in 'untCadastroProdutor.pas' {frmCadastroProdutor},
  untCadastroTipoProdutor in 'untCadastroTipoProdutor.pas' {frmCadastroTipoProdutor},
  untCadastroProduto in 'untCadastroProduto.pas' {frmCadastroProduto},
  untCadastroServico in 'untCadastroServico.pas' {frmCadastroServico},
  untCadastroCria in 'untCadastroCria.pas' {frmCadastroCria},
  untCadastroAnimal in 'untCadastroAnimal.pas' {frmCadastroAnimal},
  untDM in 'untDM.pas' {DM: TDataModule},
  untFuncoes in 'untFuncoes.pas' {frmFuncoes},
  untPesquisa in 'untPesquisa.pas' {frmPesquisa},
  untInseminacao in 'untInseminacao.pas' {frmInseminacao},
  untConfirmaInseminacao in 'untConfirmaInseminacao.pas' {frmConfirmaInseminacao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmFuncoes, frmFuncoes);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

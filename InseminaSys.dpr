program InseminaSys;

uses
  Vcl.Forms,
  untLogin in 'untLogin.pas' {frmLogin},
  untCadastroUsuario in 'untCadastroUsuario.pas' {frmCadastroUsuario},
  unstCadastroVeterinario in 'unstCadastroVeterinario.pas' {frmCadastroVeterinario},
  untCadastroProdutor in 'untCadastroProdutor.pas' {frmCadastroProdutor},
  untCadastroProduto in 'untCadastroProduto.pas' {frmCadastroProduto},
  untCadastroServico in 'untCadastroServico.pas' {frmCadastroServico},
  untCadastroCria in 'untCadastroCria.pas' {frmCadastroCria},
  untCadastroAnimal in 'untCadastroAnimal.pas' {frmCadastroAnimal},
  untDM in 'untDM.pas' {DM: TDataModule},
  untFuncoes in 'untFuncoes.pas' {frmFuncoes},
  untPesquisa in 'untPesquisa.pas' {frmPesquisa},
  untInseminacao in 'untInseminacao.pas' {frmInseminacao},
  untConfirmaInseminacao in 'untConfirmaInseminacao.pas' {frmConfirmaInseminacao},
  untRelatorioGraficos in 'untRelatorioGraficos.pas' {frmRelGraficos},
  untMovimentaEstoqueProduto in 'untMovimentaEstoqueProduto.pas' {frmMovimentaEstoqueProduto},
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untConfiguracao in 'untConfiguracao.pas' {frmConfiguracao},
  untCadastroEmpresa in 'untCadastroEmpresa.pas' {frmCadastroEmpresa},
  untCancelaInseminacao in 'untCancelaInseminacao.pas' {frmCancelaInseminacao},
  untMovimentaEstoque in 'untMovimentaEstoque.pas' {frmMovimentaEstoque};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmFuncoes, frmFuncoes);
  Application.Run;
end.

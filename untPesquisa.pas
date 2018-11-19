unit untPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmPesquisa = class(TForm)
    dbgPesquisa: TDBGrid;
    qryPesquisa: TFDQuery;
    dtsPesquisa: TDataSource;
    pnlPesquisa: TPanel;
    btnFechar: TBitBtn;
    GroupBox1: TGroupBox;
    lblCampoPesquisa: TLabel;
    edtPesquisa: TEdit;
    chkConfirmadas: TCheckBox;
    rdgrpSexo: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure dbgPesquisaDblClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPesquisaChange(Sender: TObject);
    procedure dbgPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure dbgPesquisaTitleClick(Column: TColumn);
    procedure edtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure chkConfirmadasClick(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure rdgrpSexoClick(Sender: TObject);
  private
    { Private declarations }
    procedure Selecionar;
    procedure FormataGrid;    //Versao 1.6.0 - 09/11/2018 - RS
  public
    { Public declarations }
    vTabela, vTela, vComando : String;

  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

{$R *.dfm}

uses untCadastroCria,
  untCadastroProduto, untCadastroProdutor, untCadastroServico,
  untCadastroUsuario, untDM, untFuncoes, untLogin,
  untPrincipal, untConfirmaInseminacao, untInseminacao, unstCadastroVeterinario,
  untCadastroAnimal, untMovimentaEstoque, untConfiguracao, untCadastroEmpresa,
  untCancelaInseminacao;

{ TfrmPesquisa }

procedure TfrmPesquisa.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmPesquisa.chkConfirmadasClick(Sender: TObject);
begin
  if chkConfirmadas.Checked = True then
  BEGIN
    vComando := 'Select I.NUMERO, I.DATA, P.NOME PRODUTOR, V.NOME VETERINARIO from INSEMINACAO I JOIN PRODUTOR P ON (P.ID = I.ID_PRODUTOR) JOIN VETERINARIO V ON (V.ID = I.ID_VETERINARIO) WHERE I.FINALIZADA = ' + QuotedStr('S') + ' ORDER BY I.NUMERO'
  END
  ELSE
    vComando := 'Select I.NUMERO, I.DATA, P.NOME PRODUTOR, V.NOME VETERINARIO from INSEMINACAO I JOIN PRODUTOR P ON (P.ID = I.ID_PRODUTOR) JOIN VETERINARIO V ON (V.ID = I.ID_VETERINARIO) WHERE I.FINALIZADA = ' + QuotedStr('N') + ' ORDER BY I.NUMERO';

  frmFuncoes.ExecutaSQL(vComando, 'Abrir', qryPesquisa);
end;

procedure TfrmPesquisa.dbgPesquisaDblClick(Sender: TObject);
begin
  Selecionar;
end;

procedure TfrmPesquisa.dbgPesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected in State then
  begin
    dbgPesquisa.Canvas.Brush.Color := clNavy;
    dbgPesquisa.Canvas.Font.Color := clWhite;
  end;

  dbgPesquisa.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TfrmPesquisa.dbgPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    // pressionado enter
    Selecionar;
  end
  else if key = #27 then
  begin
    // pressionado ESC
    close;
  end;
end;

procedure TfrmPesquisa.dbgPesquisaTitleClick(Column: TColumn);
begin
  lblCampoPesquisa.Caption := Column.Title.Caption;
  edtPesquisa.Clear;
  edtPesquisa.SetFocus;
end;

procedure TfrmPesquisa.edtPesquisaChange(Sender: TObject);
begin
  if edtPesquisa.Text <> '' then
  begin
    qryPesquisa.IndexFieldNames := lblCampoPesquisa.Caption;
    qryPesquisa.SetKey;
    qryPesquisa.FieldByName(lblCampoPesquisa.Caption).AsString := edtPesquisa.Text;
    qryPesquisa.GotoNearest;
  end;
end;

procedure TfrmPesquisa.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 38 then
  begin
    // seta para cima, volta um registro
    qryPesquisa.Prior;
  end
  else if key = 40 then
  begin
    // seta para baixo, avança um registro
    qryPesquisa.Next;
  end;
end;

procedure TfrmPesquisa.edtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    // pressionado enter
    Selecionar;
  end
  else if key = #27 then
  begin
    // pressionado ESC
    close;
  end;
end;

procedure TfrmPesquisa.FormActivate(Sender: TObject);
begin
  Caption := 'Pesquisa de ' + vTabela;
  FormataGrid;        //Versao 1.6.0 - 09/11/2018 - RS
end;

procedure TfrmPesquisa.FormataGrid;      //Versao 1.6.0 - 09/11/2018 - RS
begin
  if (vTela = 'CAD_CRIA_PAI') or (vTela = 'CAD_CRIA_MAE') OR (vTela = 'CAD_ANIMAL') then
  BEGIN
    dbgPesquisa.Columns[1].Width := 100;
    dbgPesquisa.Columns[2].Width := 90;
    dbgPesquisa.Columns[4].Visible := False;
  END;
end;

procedure TfrmPesquisa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 38 then
  begin
    // seta para cima, volta um registro
    qryPesquisa.Prior;
  end
  else if key = 40 then
  begin
    // seta para baixo, avança um registro
    qryPesquisa.Next;
  end;
end;

procedure TfrmPesquisa.FormShow(Sender: TObject);
begin
  frmFuncoes.ExecutaSQL(vComando, 'Abrir', qryPesquisa);
  dbgPesquisa.DataSource := dtsPesquisa;

  if (vTabela = 'PRODUTOR') OR (vTabela = 'VETERINARIO') OR (vTabela = 'USUARIO') then
  BEGIN
    lblCampoPesquisa.Caption := 'NOME';
  END
  ELSE if (vTabela = 'SERVICO') OR (vTabela = 'PRODUTO') then
  BEGIN
    lblCampoPesquisa.Caption := 'DESCRICAO';
    TFMTBCDField(qryPesquisa.FieldByName('valor')).DisplayFormat   := '###,####,###,##0.00';
  END
  ELSE if (vTabela = 'ANIMAL') then
  BEGIN
    lblCampoPesquisa.Caption := 'ANIMAL';
  END;

  if (((vTela = 'CAD_ANIMAL') OR (vTela = 'CAD_ANIMAL_CRIA')) and (vTabela = 'ANIMAL')) then  //Versao 1.6.0 - 09/11/2018 - RS  //Versao 1.1.2 - 02/07/2018  //Versao 1.1.0 - 25/05/2018
    rdgrpSexo.Visible := true       //Versao 1.1.0 - 25/05/2018
  else
    rdgrpSexo.Visible := False; //Versao 1.1.0 - 25/05/2018


  if vTabela = 'INSEMINACAO' then
    chkConfirmadas.Visible := True
  else
    chkConfirmadas.Visible := False;

  edtPesquisa.SetFocus;
end;

procedure TfrmPesquisa.rdgrpSexoClick(Sender: TObject);      //Versao 1.1 - 25/05/2018
begin
  if rdgrpSexo.ItemIndex = 0 then        //Versao 1.1 - 25/05/2018
  BEGIN
    vComando := 'Select A.ID, A.NOME AS ANIMAL, A.IDENTIFICACAO, P.NOME AS PROPRIETARIO, A.TIPO from ANIMAL A JOIN PRODUTOR P ON (P.ID = A.PROPRIETARIO) Where A.SEXO = ' + QuotedStr('F')  //Versao 1.1 - 25/05/2018
  END
  ELSE
    vComando := 'Select A.ID, A.NOME AS ANIMAL, A.IDENTIFICACAO, P.NOME AS PROPRIETARIO, A.TIPO from ANIMAL A JOIN PRODUTOR P ON (P.ID = A.PROPRIETARIO) Where A.SEXO = ' + QuotedStr('M');   //Versao 1.1 - 25/05/2018

  if vTela = 'CAD_ANIMAL' then            //Versao 1.6.0 - 09/11/2018 - RS
    vComando := vComando + ' and A.TIPO = ' + QuotedStr('Animal')       //Versao 1.6.0 - 09/11/2018 - RS
  else if vTela = 'CAD_ANIMAL_CRIA' then
    vComando := vComando + ' and A.TIPO = ' + QuotedStr('Cria');        //Versao 1.6.0 - 09/11/2018 - RS

  frmFuncoes.ExecutaSQL(vComando, 'Abrir', qryPesquisa);
  FormataGrid;
end;

procedure TfrmPesquisa.Selecionar;
begin
  if vTabela = 'USUARIO' then
  begin
    if vTela = 'CAD_USUARIO' then
    BEGIN
      frmCadastroUsuario.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroUsuario.PesquisaUsuario(True);
    END;
  end
  else if vTabela = 'ANIMAL' then
  begin
    if (vTela = 'CAD_ANIMAL') or (vTela = 'CAD_ANIMAL_CRIA') then
    BEGIN
      frmCadastroAnimal.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroAnimal.PesquisaAnimal(True);
    END
    else if vTela = 'INSEMINACAO_T' then
    BEGIN
      frmInseminacao.edtCodTouro.Text := dbgPesquisa.Fields[0].Value;
      frmInseminacao.PesquisaTouro(True);
    END
    else if vTela = 'INSEMINACAO' then
    BEGIN
      frmInseminacao.edtCodAnimal.Text := dbgPesquisa.Fields[0].Value;
      frmInseminacao.PesquisaAnimal(True);
    END
    else if vTela = 'CAD_CRIA_MAE' then
    BEGIN
      {frmCadastroCria.edtCodMae.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroCria.PesquisaMae(True);}   //Versao 1.6.0 - 09/11/2018 - RS
      frmCadastroAnimal.edtCodMae.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroAnimal.PesquisaMae(True);
    END
    else if vTela = 'CAD_CRIA_PAI' then
    BEGIN
      {frmCadastroCria.edtCodPai.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroCria.PesquisaPai(True);}   //Versao 1.6.0 - 09/11/2018 - RS
      frmCadastroAnimal.edtCodPai.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroAnimal.PesquisaPai(True);
    END
    else if vTela = 'MOVI_PRODUTO' then
    BEGIN
      frmMovimentaEstoque.edtCodAnimal.Text := dbgPesquisa.Fields[0].Value;
      frmMovimentaEstoque.PesquisaAnimal(True);
    END;
  end
  ELSE
  if vTabela = 'PRODUTOR' then
  begin
    if vTela = 'CAD_ANIMAL' then
    BEGIN
      frmCadastroAnimal.edtCodProprietario.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroAnimal.PesquisaProprietario(True);
    END
    else if vTela = 'CAD_CRIA' then
    BEGIN
      frmCadastroCria.edtCodProprietario.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroCria.PesquisaProprietario(True);
    END
    else if vTela = 'CADASTRO' then
    BEGIN
      frmCadastroVeterinario.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroVeterinario.PesquisaBD(True);
    END
    else if vTela = 'CONFIRMA_INS' then
    BEGIN
      frmConfirmaInseminacao.edtCodProprietario.Text := dbgPesquisa.Fields[0].Value;
      frmConfirmaInseminacao.PesquisaProdutor(True);
    END
    else if vTela = 'INSEMINACAO' then
    BEGIN
      frmInseminacao.edtCodProprietario.Text := dbgPesquisa.Fields[0].Value;
      frmInseminacao.PesquisaProprietario(True);
    END
    else if vTela = 'CANCELA_INS' then       //Versao 1.5.0 - 25/10/2018 - RS
    BEGIN
      frmCancelaInseminacao.edtCodProprietario.Text := dbgPesquisa.Fields[0].Value;      //Versao 1.5.0 - 25/10/2018 - RS
      frmCancelaInseminacao.PesquisaProdutor(True);         //Versao 1.5.0 - 25/10/2018 - RS
    END;
  end
  else if vTabela = 'CRIA' then
  begin
    if vTela = 'CAD_CRIA' then
    BEGIN
      frmCadastroCria.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroCria.PesquisaAnimal(True);
    END;
  end
  else if vTabela = 'VETERINARIO' then
  begin
    if vTela = 'CADASTRO' then
    BEGIN
      frmCadastroVeterinario.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroVeterinario.PesquisaBD(True);
    END
    else if vTela = 'CONFIRMA_INS' then
    BEGIN
      frmConfirmaInseminacao.edtCodVeterinario.Text := dbgPesquisa.Fields[0].Value;
      frmConfirmaInseminacao.PesquisaVeterinario(True);
    END
    else if vTela = 'INSEMINACAO' then
    BEGIN
      frmInseminacao.edtCodVet.Text := dbgPesquisa.Fields[0].Value;
      frmInseminacao.PesquisaVeterinario(True);
    END
    else if vTela = 'CONFIG' then
    BEGIN
      frmConfiguracao.edtCodVet.Text := dbgPesquisa.Fields[0].Value;
      frmConfiguracao.PesquisaVeterinario(True);
    END;
  end
  else if vTabela = 'INSEMINACAO' then
  begin
    if vTela = 'INSEMINACAO' then
    BEGIN
      frmInseminacao.edtNumero.Text := dbgPesquisa.Fields[0].Value;
      frmInseminacao.PesquisaBD(True);
    END;
  end
  else if vTabela = 'SERVICO' then
  begin
    if vTela = 'INSEMINACAO' then
    BEGIN
      frmInseminacao.edtCodServico.Text := dbgPesquisa.Fields[0].Value;
      frmInseminacao.PesquisaServico(True);
    END
    ELSE if vTela = 'CAD_SERVICO' then
    BEGIN
      frmCadastroServico.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroServico.PesquisaBD(True);
    END
    ELSE if vTela = 'CONFIG' then
    BEGIN
      frmConfiguracao.edtCodServico.Text := dbgPesquisa.Fields[0].Value;
      frmConfiguracao.PesquisaServico(True);
    END;
  end
  else if vTabela = 'PRODUTO' then
  begin
    if vTela = 'CAD_PRODUTO' then
    BEGIN
      frmCadastroProduto.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroProduto.PesquisaBD(True);
    END
    else if vTela = 'MOVI_PRODUTO' then
    BEGIN
      frmMovimentaEstoque.edtCodProduto.Text := dbgPesquisa.Fields[0].Value;
      frmMovimentaEstoque.PesquisaProduto(True);
    END
    else if vTela = 'CONFIG' then
    BEGIN
      frmConfiguracao.edtCodProduto.Text := dbgPesquisa.Fields[0].Value;
      frmConfiguracao.PesquisaProduto(True);
    END;
  end
  else if vTabela = 'EMPRESA' then    //VERSAO 1.3.0 - 14/08/2018
  begin
    if vTela = 'CAD_EMPRESA' then
    BEGIN
      frmCadastroEmpresa.edtCodigo.Text := dbgPesquisa.Fields[0].Value;
      frmCadastroEmpresa.PesquisaBD(True);
    END;
  end;

  Close;
end;

end.

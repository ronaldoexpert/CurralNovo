unit untInseminacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmInseminacao = class(TForm)
    pnlCentro: TPanel;
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    dbgDados: TDBGrid;
    pnlTop: TPanel;
    edtNumero: TEdit;
    lblCodigo: TLabel;
    btnPesquisar: TBitBtn;
    lblEmissao: TLabel;
    pnlDados: TPanel;
    lblTouro: TLabel;
    btnPesqTouro: TBitBtn;
    edtDescrTouro: TEdit;
    lblAnimal: TLabel;
    btnPesqAnimal: TBitBtn;
    edtDescrAnimal: TEdit;
    lblServico: TLabel;
    btnPesqServico: TBitBtn;
    edtDescrServico: TEdit;
    edtVlrUnit: TEdit;
    lblVlrUnit: TLabel;
    pgctrlDados: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label4: TLabel;
    edtCodTouro: TEdit;
    edtCodAnimal: TEdit;
    edtCodServico: TEdit;
    btnAdd: TBitBtn;
    btnDelete: TBitBtn;
    edtObs: TMemo;
    edtDtEmissao: TDateTimePicker;
    edtCodVet: TEdit;
    Label5: TLabel;
    btnPesqVet: TBitBtn;
    edtDescrVeterinario: TEdit;
    edtID: TEdit;
    qryAuxiliar: TFDQuery;
    dtsAuxiliar: TDataSource;
    dtsAuxMovi: TDataSource;
    qryAuxMovi: TFDQuery;
    edtTotal: TEdit;
    qryAuxiliar1: TFDQuery;
    dtsAuxiliar1: TDataSource;
    lblFinalizada: TLabel;
    qryMoviProduto: TFDQuery;
    dtsMoviProduto: TDataSource;
    edtCodProprietario: TEdit;
    lblProprietario: TLabel;
    btnPesqProprietario: TBitBtn;
    edtDescrProprietario: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure btnPesqTouroClick(Sender: TObject);
    procedure btnPesqAnimalClick(Sender: TObject);
    procedure btnPesqProprietarioClick(Sender: TObject);
    procedure btnPesqServicoClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edtNumeroExit(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesqVetClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProprietarioExit(Sender: TObject);
    procedure edtCodVetExit(Sender: TObject);
    procedure edtCodTouroExit(Sender: TObject);
    procedure edtCodServicoExit(Sender: TObject);
    procedure edtCodAnimalExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtNumeroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodProprietarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodVetKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodTouroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodServicoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodAnimalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodProprietarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVetKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTouroKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodServicoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAnimalKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCodProprietarioChange(Sender: TObject);
    procedure edtCodVetChange(Sender: TObject);
    procedure edtCodTouroChange(Sender: TObject);
    procedure edtCodServicoChange(Sender: TObject);
    procedure edtCodAnimalChange(Sender: TObject);
    procedure dbgDadosDblClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    vEdita : Boolean;       //Versao 1.1.0 - 25/05/2018
    function ValidaCampos : Boolean;
    function ValidaCamposInseminacao : Boolean;
    function ValidaAnimal : Boolean;
    procedure LimpaCampos;
    procedure GravaGrid;
    procedure Totalizar;
    procedure GravaMoviProduto(vQtd : real; vIDProduto : String; vIDAnimal : String);

  public
    { Public declarations }
    vID : string;
    fNovo : Boolean;
    procedure CarregaGrid;
    procedure PesquisaBD(vStatus : boolean);
    procedure PesquisaAnimal(vStatus : boolean);
    procedure PesquisaProprietario(vStatus : boolean);
    procedure PesquisaServico(vStatus : boolean);
    procedure PesquisaTouro(vStatus : boolean);
    procedure PesquisaVeterinario(vStatus : boolean);
  end;

var
  frmInseminacao: TfrmInseminacao;

implementation

{$R *.dfm}

uses unstCadastroVeterinario, untCadastroAnimal, untCadastroProduto,
  untCadastroProdutor, untCadastroServico, untDM, untFuncoes, untPesquisa,
  untCadastroCria, untPrincipal;

{ TfrmInseminacao }

procedure TfrmInseminacao.btnAddClick(Sender: TObject);
begin
  if ValidaCamposInseminacao then
  begin
    if ValidaAnimal then
    begin
      if vEdita = false then     //Versao 1.1.0 - 25/05/2018
      begin
        DM.qryMoviInseminacao.Insert;
        DM.qryMoviInseminacao.FieldByName('ID').AsString := IntToStr(frmFuncoes.AutoIncre('MOVI_INSEMINACAO', 'Novo'));
      end
      else       //Versao 1.1.0 - 25/05/2018
      begin
        DM.qryMoviInseminacao.Edit;    //Versao 1.1.0 - 25/05/2018
      end;
      DM.qryMoviInseminacao.FieldByName('ID_inseminacao').AsString := vID;
      DM.qryMoviInseminacao.FieldByName('IDAnimal').AsString := edtCodAnimal.Text;
      DM.qryMoviInseminacao.FieldByName('nome').AsString := edtDescrAnimal.Text;
      DM.qryMoviInseminacao.FieldByName('IDServico').AsString := edtCodServico.Text;
      DM.qryMoviInseminacao.FieldByName('descricao').AsString := edtDescrServico.Text;
      DM.qryMoviInseminacao.FieldByName('vlr_unit').AsString := edtVlrUnit.Text;
      DM.qryMoviInseminacao.FieldByName('ID_PRODUTO').AsString := DM.qryConfiguracao.FieldByName('produto_inseminacao').AsString;
      DM.qryMoviInseminacao.FieldByName('confirmada').AsString := 'A';
      DM.qryMoviInseminacao.FieldByName('data_confirmacao').AsString := '01/01/1900';
      DM.qryMoviInseminacao.Post;

      DM.qryMoviInseminacao.UpdateCursorPos;
      edtCodAnimal.Clear;
      edtDescrAnimal.Clear;
      edtCodAnimal.SetFocus;
      vEdita := False;
      Totalizar;

    end
    else
    begin
      ShowMessage('Animal já inserido!');
      edtCodAnimal.Clear;
      edtDescrAnimal.Clear;
      edtCodAnimal.SetFocus;
    end;
  end;
end;

procedure TfrmInseminacao.btnCancelarClick(Sender: TObject);
begin
  if edtNumero.Text <> '' then
  begin
    if fNovo = False then
    begin
      PesquisaBD(True);
    end
    else
    begin
      edtNumero.Enabled := true;
      edtNumero.Clear;
      LimpaCampos;
      btnNovo.Enabled := True;
      btnGravar.Enabled := True;
      btnExcluir.Enabled := True;
      fNovo := False;
    end;
  end;
end;

procedure TfrmInseminacao.btnDeleteClick(Sender: TObject);   //Versao 1.1.0 - 25/05/2018
begin
  dm.qryMoviInseminacao.Delete;
  edtCodAnimal.Clear;
  edtDescrAnimal.Clear;
  vEdita := False;
end;

procedure TfrmInseminacao.btnExcluirClick(Sender: TObject);
var
  vQtdSemem : integer;
begin
  if fNovo = False then
  begin
    vQtdSemem := dm.qryMoviInseminacao.RecordCount;
    if dm.qryCadInseminacao.RecordCount > 0 then
    begin
      if Application.MessageBox('Deseja realmente excluir o registro?', 'Curral Novo', MB_YESNO) = mrYes then
      begin
        dm.qryCadInseminacao.Delete;
        dm.qryCadInseminacao.ApplyUpdates(-1);
        {if dm.qryCadInseminacao.ApplyUpdates(-1) = 0 then   //Comentado na versao 1.1.0 - 16/05/2018
        begin
          frmFuncoes.ExecutaSQL('Update PRODUTO set estoque = estoque + ' + IntToStr(vQtdSemem), '', qryAuxiliar1);
          frmFuncoes.ExecutaSQL('Update ANIMAL set estoque = estoque + ' + IntToStr(vQtdSemem) + ' where ID = ' + edtCodTouro.Text, '', qryAuxiliar1);
        end;}
        close;
      end;
    end;
  end;
end;

procedure TfrmInseminacao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmInseminacao.btnGravarClick(Sender: TObject);
var
  vQtdSemem : Real;
begin
  if ValidaCampos then
  begin
    vQtdSemem := dm.qryMoviInseminacao.RecordCount;
    if fNovo = True then
    begin
      dm.qryCadInseminacao.Append;
      vID := IntToStr(frmFuncoes.AutoIncre('INSEMINACAO', 'Novo'));
      dm.qryCadInseminacao.FieldByName('id').AsString := vID;
      frmFuncoes.AutoIncre('INSEMINACAO', 'Gravar');
      dm.qryCadInseminacao.FieldByName('numero').AsString := edtNumero.Text
    end
    else
    begin
      dm.qryCadInseminacao.Edit;
    end;

    dm.qryCadInseminacao.FieldByName('data').AsDateTime := edtDtEmissao.Date;
    dm.qryCadInseminacao.FieldByName('id_produtor').AsString := edtCodProprietario.Text;
    dm.qryCadInseminacao.FieldByName('id_veterinario').AsString := edtCodVet.Text;
    dm.qryCadInseminacao.FieldByName('id_touro').AsString := edtCodTouro.Text;
    dm.qryCadInseminacao.FieldByName('observacao').AsString := edtObs.Text;
    dm.qryCadInseminacao.FieldByName('FINALIZADA').AsString := 'N';
    dm.qryCadInseminacao.FieldByName('DT_FINALIZADA').AsString := '01/01/1900';
    dm.qryCadInseminacao.FieldByName('NOMETOURO').AsString := edtDescrTouro.Text;
    dm.qryCadInseminacao.FieldByName('alteracao').AsDateTime := Date+Time;
    dm.qryCadInseminacao.FieldByName('usuario').AsString := inttostr(frmPrincipal.vUsuario);
    dm.qryCadInseminacao.FieldByName('CODEMPRESA').AsInteger := frmPrincipal.vEmpresa;        //Versao 1.4 - 14/10/2018

    dm.qryCadInseminacao.Post;
    if dm.qryCadInseminacao.ApplyUpdates(-1) = 0 then
    begin
      GravaGrid;
      {      //Comentado na versao 1.1.0 - 16/05/2018
      frmFuncoes.ExecutaSQL('Update PRODUTO set estoque = estoque - ' + IntToStr(vQtdSemem), '', qryAuxiliar1);
      frmFuncoes.ExecutaSQL('Update ANIMAL set estoque = estoque - ' + IntToStr(vQtdSemem) + ' where ID = ' + edtCodTouro.Text, '', qryAuxiliar1);
      }
      GravaMoviProduto(vQtdSemem, dm.qryConfiguracao.FieldByName('PRODUTO_INSEMINACAO').AsString, edtCodTouro.Text);
    end;


    btnNovo.Enabled := True;
    btnExcluir.Enabled := True;
    edtNumero.Enabled := True;
    fNovo := False;
    ShowMessage('Gravação efetuada com sucesso!');
  end;
end;

procedure TfrmInseminacao.btnNovoClick(Sender: TObject);
begin
  LimpaCampos;
  fNovo := True;
  vEdita := False;
  CarregaGrid;
  frmFuncoes.ExecutaSQL('Select * from INSEMINACAO WHERE ID IS NULL', 'Abrir', DM.qryCadInseminacao);
  dm.qryCadInseminacao.Append;

  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  btnExcluir.Enabled := False;
  edtNumero.SetFocus;
  edtID.Text := IntToStr(frmFuncoes.AutoIncre('INSEMINACAO', 'Novo'));
  edtNumero.Text := frmFuncoes.FormataNumero(edtID.Text);
  edtNumero.Enabled := false;

  edtDtEmissao.SetFocus;

  if dm.qryConfiguracao.FieldByName('VETERINARIO_PADRAO').AsString <> '' then
  BEGIN
    edtCodVet.Text := dm.qryConfiguracao.FieldByName('VETERINARIO_PADRAO').AsString;
    PesquisaVeterinario(True);
  END;


  edtCodServico.Text := '1';
  PesquisaServico(True);
end;

procedure TfrmInseminacao.btnPesqAnimalClick(Sender: TObject);
begin
  PesquisaAnimal(False);
end;

procedure TfrmInseminacao.btnPesqProprietarioClick(Sender: TObject);
begin
  PesquisaProprietario(False);
end;

procedure TfrmInseminacao.btnPesqServicoClick(Sender: TObject);
begin
  PesquisaServico(False);
end;

procedure TfrmInseminacao.btnPesqTouroClick(Sender: TObject);
begin
    PesquisaTouro(False);
end;

procedure TfrmInseminacao.btnPesquisarClick(Sender: TObject);
begin
  if fNovo = False then
    PesquisaBD(False);
end;

procedure TfrmInseminacao.btnPesqVetClick(Sender: TObject);
begin
  PesquisaVeterinario(False);
end;

procedure TfrmInseminacao.CarregaGrid;
begin
  frmFuncoes.ExecutaSQL('select MI.ID, MI.ID_INSEMINACAO, A.ID as IDAnimal, A.NOME, S.ID as IDServico, S.DESCRICAO, MI.VLR_UNIT, MI.CONFIRMADA, MI.DATA_CONFIRMACAO, MI.ID_PRODUTO ' +
  ' FROM ANIMAL A join MOVI_INSEMINACAO MI on (A.ID = MI.ID_ANIMAL) JOIN SERVICO S ON (S.ID = MI.ID_SERVICO) ' +
  ' Where MI.id_inseminacao = ' + vID + ' order by MI.ID', 'Abrir', DM.qryMoviInseminacao);

  dbgDados.Columns.Items[0].Visible := False;  //ID
  dbgDados.Columns.Items[1].Visible := False;  //ID_INSEMINACAO
  dbgDados.Columns.Items[2].Visible := False;  //ID_ANIMAL
  dbgDados.Columns.Items[3].Visible := True;  //NOME ANIMAL
  dbgDados.Columns.Items[4].Visible := False;  //ID_SERVICO
  dbgDados.Columns.Items[5].Visible := True;  //DESCR SERVICO
  dbgDados.Columns.Items[6].Visible := True;  //VLR_UNIT
  dbgDados.Columns.Items[7].Visible := False;  //CONFIRMADA
  dbgDados.Columns.Items[8].Visible := False;  //DATA_CONFIRMACAO
  dbgDados.Columns.Items[9].Visible := False;  //ID_PRODUTO

  dbgDados.Columns.Items[3].Width := 150;
  dbgDados.Columns.Items[5].Width := 150;

  TFMTBCDField(dm.qryMoviInseminacao.FieldByName('vlr_unit')).DisplayFormat   := '###,####,###,##0.00';
  Totalizar;
end;

procedure TfrmInseminacao.dbgDadosDblClick(Sender: TObject);  //Versao 1.1.0 - 25/05/2018
begin
  vEdita := True;
  edtCodAnimal.Text := DM.qryMoviInseminacao.FieldByName('idAnimal').AsString;
  edtDescrAnimal.Text := DM.qryMoviInseminacao.FieldByName('nome').AsString;
end;

procedure TfrmInseminacao.dbgDadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected in State then
  begin
    dbgDados.Canvas.Brush.Color := clNavy;
    dbgDados.Canvas.Font.Color := clWhite;
  end;

  dbgDados.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TfrmInseminacao.edtNumeroExit(Sender: TObject);
begin
  if fNovo = false then
  begin
    if Trim(edtNumero.Text) <> '' then
      PesquisaBD(True);
  end;
end;

procedure TfrmInseminacao.edtNumeroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesquisarClick(Self);
end;

procedure TfrmInseminacao.FormActivate(Sender: TObject);
begin
  LimpaCampos;
  CarregaGrid;
  edtNumero.SetFocus;
end;

procedure TfrmInseminacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmInseminacao.GravaGrid;
begin
  if dm.qryMoviInseminacao.RecordCount > 0 then
  begin
    if fNovo = False then
      frmFuncoes.ExecutaSQL('Delete from MOVI_INSEMINACAO where ID_inseminacao = ' + QuotedStr(vID), 'Executar', qryAuxiliar);

    dm.qryMoviInseminacao.First;
    while not dm.qryMoviInseminacao.Eof do
    begin
      frmFuncoes.ExecutaSQL('Select * from MOVI_INSEMINACAO where ID is null', 'Abrir', qryAuxMovi);
      qryAuxMovi.Insert;
      qryAuxMovi.FieldByName('ID').AsString := IntToStr(frmFuncoes.AutoIncre('MOVI_INSEMINACAO', 'Novo'));
      qryAuxMovi.FieldByName('ID_inseminacao').AsString := vID;
      qryAuxMovi.FieldByName('id_animal').AsString := DM.qryMoviInseminacao.FieldByName('idanimal').AsString;
      qryAuxMovi.FieldByName('id_servico').AsString := DM.qryMoviInseminacao.FieldByName('idservico').AsString;
      qryAuxMovi.FieldByName('vlr_unit').AsString := DM.qryMoviInseminacao.FieldByName('vlr_unit').AsString;
      qryAuxMovi.FieldByName('ID_PRODUTO').AsString := DM.qryMoviInseminacao.FieldByName('ID_PRODUTO').AsString;
      qryAuxMovi.FieldByName('confirmada').AsString := DM.qryMoviInseminacao.FieldByName('confirmada').AsString;
      qryAuxMovi.FieldByName('data_confirmacao').AsString := DM.qryMoviInseminacao.FieldByName('data_confirmacao').AsString;
      qryAuxMovi.Post;
      qryAuxMovi.ApplyUpdates(-1);
      frmFuncoes.AutoIncre('MOVI_INSEMINACAO', '');
      dm.qryMoviInseminacao.Next;
    end;
  end;
end;

procedure TfrmInseminacao.GravaMoviProduto(vQtd: real; vIDProduto: String;
  vIDAnimal : String);
begin
  frmFuncoes.ExecutaSQL('Select * from MOVI_PRODUTO where ID is null', 'Abrir', qryMoviProduto);
  qryMoviProduto.Insert;

  qryMoviProduto.FieldByName('ID').AsString :=  IntToStr(frmFuncoes.AutoIncre('MOVI_INSEMINACAO', 'Novo'));
  qryMoviProduto.FieldByName('NUMERO').AsString := qryMoviProduto.FieldByName('ID').AsString;
  qryMoviProduto.FieldByName('ID_INSEMINACAO').AsString := vID;
  qryMoviProduto.FieldByName('DATA').AsDateTime := edtDtEmissao.Date;
  qryMoviProduto.FieldByName('ID_PRODUTO').AsString := vIDProduto;
  qryMoviProduto.FieldByName('ID_ANIMAL').AsString := vIDAnimal;
  qryMoviProduto.FieldByName('QUANTIDADE').AsFloat := vQtd;
  qryMoviProduto.FieldByName('TIPO').AsString := 'S';
  qryMoviProduto.FieldByName('UNIDADE').AsString := 'UN';
  qryMoviProduto.FieldByName('ALTERACAO').AsDateTime := Date+Time;
  qryMoviProduto.FieldByName('USUARIO').AsInteger := StrToInt(frmFuncoes.LerArquivoUsuario);
  qryMoviProduto.FieldByName('CODEMPRESA').AsInteger := frmPrincipal.vEmpresa;        //Versao 1.4 - 14/10/2018

  qryMoviProduto.Post;
  qryMoviProduto.ApplyUpdates(-1);
  frmFuncoes.AutoIncre('MOVI_PRODUTO', '');
end;

procedure TfrmInseminacao.LimpaCampos;
begin
  edtNumero.Clear;
  edtDtEmissao.DateTime := Date;
  edtCodProprietario.Clear;
  edtDescrProprietario.Clear;
  edtCodTouro.Clear;
  edtDescrTouro.Clear;
  edtCodVet.Clear;
  edtDescrVeterinario.Clear;
  edtCodServico.Clear;
  edtDescrServico.Clear;
  edtVlrUnit.Text := '0,00';
  edtCodAnimal.Clear;
  edtDescrAnimal.Clear;
  edtObs.Clear;
  vID := '0';
  CarregaGrid;
end;

procedure TfrmInseminacao.PesquisaAnimal(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodAnimal.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from ANIMAL where SEXO = ' + QuotedStr('F') + ' AND TIPO = ' + QuotedStr('Animal') + ' and ID = ' + QuotedStr(edtCodAnimal.Text) + ' AND PROPRIETARIO = ' + QuotedStr(edtCodProprietario.Text) + ' and ID NOT IN (SELECT ID_ANIMAL FROM MOVI_INSEMINACAO WHERE CONFIRMADA IN (' + QuotedStr('A') + ', ' + QuotedStr('S') + '))', 'Abrir', DM.qryAnimal);
      if DM.qryAnimal.RecordCount > 0 then
      begin
        edtDescrAnimal.Text := DM.qryAnimal.FieldByName('NOME').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodAnimal.SetFocus;
        edtCodAnimal.Clear;
        edtDescrAnimal.Clear;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'ANIMAL';
      frmPesquisa.vTela := 'INSEMINACAO';
      //frmPesquisa.vComando := 'Select ID, NOME, IDENTIFICACAO, PROPRIETARIO from ANIMAL where SEXO = ' + QuotedStr('F') + ' AND PROPRIETARIO = ' + QuotedStr(edtCodProprietario.Text) + ' AND ID NOT IN (SELECT ID_ANIMAL FROM MOVI_INSEMINACAO WHERE CONFIRMADA IN (' + QuotedStr('A') + ', ' + QuotedStr('S') + ')) ORDER BY NOME';
      frmPesquisa.vComando := frmFuncoes.LerArquivoIni('INSEMINACAO', 'ANIMALF') + ' AND PROPRIETARIO = ' + QuotedStr(edtCodProprietario.Text) + ' order by NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmInseminacao.PesquisaBD(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtNumero.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select I.*, MI.* from INSEMINACAO I JOIN MOVI_INSEMINACAO MI ON (MI.ID_INSEMINACAO = I.ID) WHERE NUMERO = ' + QuotedStr(edtNumero.Text), 'Abrir', DM.qryCadInseminacao);
      if DM.qryCadInseminacao.RecordCount > 0 then
      begin
        vID := DM.qryCadInseminacao.FieldByName('ID').AsString;
        edtID.Text := vID;
        edtCodProprietario.Text := DM.qryCadInseminacao.FieldByName('id_produtor').AsString;
        PesquisaProprietario(True);
        edtCodVet.Text := DM.qryCadInseminacao.FieldByName('id_veterinario').AsString;
        PesquisaVeterinario(True);
        edtCodTouro.Text := DM.qryCadInseminacao.FieldByName('id_touro').AsString;
        PesquisaTouro(True);
        edtCodServico.Text := DM.qryCadInseminacao.FieldByName('id_servico').AsString;
        PesquisaServico(True);
        edtDtEmissao.Date := DM.qryCadInseminacao.FieldByName('data').AsDateTime;
        CarregaGrid;

        if DM.qryCadInseminacao.FieldByName('FINALIZADA').AsString = 'S' then
        BEGIN
          btnGravar.Enabled := False;
          btnExcluir.Enabled := False;
          dbgDados.Enabled := False;
          lblFinalizada.Visible := True;
        END
        else
        begin
          btnGravar.Enabled := True;
          btnExcluir.Enabled := True;
          dbgDados.Enabled := True;
          lblFinalizada.Visible := False;
        end;

      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtNumero.SetFocus;
        edtNumero.Clear;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'INSEMINACAO';
      frmPesquisa.vTela := 'INSEMINACAO';
      frmPesquisa.vComando := 'Select I.NUMERO, I.DATA, P.NOME PRODUTOR, V.NOME VETERINARIO from INSEMINACAO I JOIN PRODUTOR P ON (P.ID = I.ID_PRODUTOR) JOIN VETERINARIO V ON (V.ID = I.ID_VETERINARIO) WHERE I.FINALIZADA = ' + QuotedStr('N') + ' ORDER BY I.NUMERO' ;
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;


procedure TfrmInseminacao.PesquisaProprietario(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodProprietario.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from PRODUTOR where ID =  ' + QuotedStr(edtCodProprietario.Text), 'Abrir', DM.qryProprietario);

      if DM.qryProprietario.RecordCount > 0 then
      begin
        edtDescrProprietario.Text := DM.qryProprietario.FieldByName('NOME').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodProprietario.SetFocus;
        edtCodProprietario.Clear;
        edtDescrProprietario.Clear;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'PRODUTOR';
      frmPesquisa.vTela := 'INSEMINACAO';
      frmPesquisa.vComando := 'Select ID, NOME, INSC_RURAL from PRODUTOR ORDER BY NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmInseminacao.PesquisaServico(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodServico.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from SERVICO where ID =  ' + QuotedStr(edtCodServico.Text), 'Abrir', DM.qryProprietario);

      if DM.qryProprietario.RecordCount > 0 then
      begin
        edtDescrServico.Text := DM.qryProprietario.FieldByName('DESCRICAO').AsString;
        edtVlrUnit.Text :=  DM.qryProprietario.FieldByName('valor').AsString;
        TFMTBCDField(edtVlrUnit).DisplayFormat   := '###,####,###,##0.00';
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodServico.SetFocus;
        edtCodServico.Clear;
        edtDescrServico.Clear;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'SERVICO';
      frmPesquisa.vTela := 'INSEMINACAO';
      frmPesquisa.vComando := 'Select ID, DESCRICAO, VALOR from SERVICO ORDER BY DESCRICAO';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmInseminacao.PesquisaTouro(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodTouro.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from ANIMAL where SEXO = ' + QuotedStr('M') + ' and ID = ' + QuotedStr(edtCodTouro.Text), 'Abrir', DM.qryAnimal);
      if DM.qryAnimal.RecordCount > 0 then
      begin
        edtDescrTouro.Text := DM.qryAnimal.FieldByName('NOME').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodTouro.SetFocus;
        edtCodTouro.Clear;
        edtDescrTouro.Clear;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'ANIMAL';
      frmPesquisa.vTela := 'INSEMINACAO_T';
      frmPesquisa.vComando := 'Select ID, NOME, IDENTIFICACAO, ESTOQUE from ANIMAL where SEXO = ' + QuotedStr('M') + ' ORDER BY NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmInseminacao.PesquisaVeterinario(vStatus: boolean);
begin
  if vStatus = True then
  begin
    frmFuncoes.ExecutaSQL('Select * from VETERINARIO where ID = ' + QuotedStr(edtCodVet.Text), 'Abrir', DM.qryVeterinario);

    if DM.qryVeterinario.RecordCount > 0 then
    begin
      edtDescrVeterinario.Text := DM.qryVeterinario.FieldByName('nome').AsString;
    end
    else
    begin
      Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
      edtCodVet.SetFocus;
      edtCodVet.Clear;
      edtDescrVeterinario.Clear;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'VETERINARIO';
      frmPesquisa.vTela := 'INSEMINACAO';
      frmPesquisa.vComando := 'Select ID, NOME from VETERINARIO ORDER BY NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmInseminacao.Totalizar;
var
  vVlrTotal : Real;
begin
  vVlrTotal := 0;
  DM.qryMoviInseminacao.First;
  while not DM.qryMoviInseminacao.Eof do
  begin
    vVlrTotal := vVlrTotal + DM.qryMoviInseminacao.FieldByName('vlr_unit').AsFloat;
    DM.qryMoviInseminacao.Next;
  end;
  edtTotal.Text := FloatToStr(vVlrTotal);
  TFMTBCDField(edtTotal).DisplayFormat   := '###,####,###,##0.00';
end;

function TfrmInseminacao.ValidaAnimal: Boolean;
var
  vRetorno : Boolean;
begin
  vRetorno := True;
  if vEdita = False then
    begin
    DM.qryMoviInseminacao.First;
    while not DM.qryMoviInseminacao.Eof do
    begin
      if DM.qryMoviInseminacao.FieldByName('IDAnimal').AsString = edtCodAnimal.Text then
        vRetorno := False;
      DM.qryMoviInseminacao.Next;
    end;
  end;

  Result := vRetorno;
end;

function TfrmInseminacao.ValidaCampos: Boolean;
var
  vRetorno : Boolean;
begin
  vRetorno := True;

  if Trim(edtCodProprietario.Text) = '' then
  begin
    ShowMessage('Insira o Proprietário!');
    edtCodProprietario.SetFocus;
    vRetorno := False;
  end;

  if Trim(edtCodVet.Text) = '' then
  begin
    ShowMessage('Insira o Veterinário!');
    edtCodVet.SetFocus;
    vRetorno := False;
  end;

  if Trim(edtCodTouro.Text) = '' then
  begin
    ShowMessage('Insira o Touro!');
    edtCodTouro.SetFocus;
    vRetorno := False;
  end;

  if Trim(edtCodServico.Text) = '' then
  begin
    ShowMessage('Insira o Serviço!');
    edtCodServico.SetFocus;
    vRetorno := False;
  end;

  if dm.qryMoviInseminacao.RecordCount = 0 then
  begin
    if Trim(edtCodAnimal.Text) = '' then
    begin
      ShowMessage('Insira o Animal!');
      edtCodAnimal.SetFocus;
      vRetorno := False;
    end;
  end;

  Result := vRetorno;
end;


function TfrmInseminacao.ValidaCamposInseminacao: Boolean;
var
  vRetorno : Boolean;
begin
  vRetorno := True;

  if Trim(edtCodProprietario.Text) = '' then
  begin
    ShowMessage('Insira o Proprietário!');
    edtCodProprietario.SetFocus;
    vRetorno := False;
  end;

  if Trim(edtCodAnimal.Text) = '' then
  begin
    ShowMessage('Insira o Animal!');
    edtCodAnimal.SetFocus;
    vRetorno := False;
  end;

  Result := vRetorno;
end;

procedure TfrmInseminacao.edtCodAnimalChange(Sender: TObject);
begin
  if Trim(edtCodAnimal.Text) = '' then
    edtDescrAnimal.Clear;
end;

procedure TfrmInseminacao.edtCodAnimalExit(Sender: TObject);
begin
  if edtCodAnimal.Text <> '' then
  begin
    if ValidaCamposInseminacao then
    begin
      PesquisaAnimal(True);
    end;
  end;
end;

procedure TfrmInseminacao.edtCodAnimalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesqAnimalClick(Self);
end;

procedure TfrmInseminacao.edtCodAnimalKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmInseminacao.edtCodProprietarioChange(Sender: TObject);
begin
  if Trim(edtCodProprietario.Text) = '' then
    edtDescrProprietario.Clear;
end;

procedure TfrmInseminacao.edtCodProprietarioExit(Sender: TObject);
begin
  if Trim(edtCodProprietario.Text) <> '' then
  begin
    PesquisaProprietario(True);
    CarregaGrid;
  end;
end;

procedure TfrmInseminacao.edtCodProprietarioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesqProprietarioClick(Self);
end;

procedure TfrmInseminacao.edtCodProprietarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmInseminacao.edtCodServicoChange(Sender: TObject);
begin
  if Trim(edtCodServico.Text) = '' then
    edtDescrServico.Clear;
end;

procedure TfrmInseminacao.edtCodServicoExit(Sender: TObject);
begin
  if Trim(edtCodServico.Text) <> '' then
  begin
    PesquisaServico(True);
  end;
end;

procedure TfrmInseminacao.edtCodServicoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesqServicoClick(Self);
end;

procedure TfrmInseminacao.edtCodServicoKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmInseminacao.edtCodTouroChange(Sender: TObject);
begin
  if trim(edtCodTouro.Text) = '' then
    edtDescrTouro.Clear;
end;

procedure TfrmInseminacao.edtCodTouroExit(Sender: TObject);
begin
  if Trim(edtCodTouro.Text) <> '' then
  begin
    PesquisaTouro(True);
  end;
end;

procedure TfrmInseminacao.edtCodTouroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesqTouroClick(Self);
end;

procedure TfrmInseminacao.edtCodTouroKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmInseminacao.edtCodVetChange(Sender: TObject);
begin
  if Trim(edtCodVet.Text) = '' then
    edtDescrVeterinario.Clear;
end;

procedure TfrmInseminacao.edtCodVetExit(Sender: TObject);
begin
  if Trim(edtCodVet.Text) <> '' then
  begin
    PesquisaVeterinario(True);
  end;
end;

procedure TfrmInseminacao.edtCodVetKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesqVetClick(Self);
end;

procedure TfrmInseminacao.edtCodVetKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

end.


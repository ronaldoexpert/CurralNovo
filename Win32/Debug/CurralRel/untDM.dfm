object DM: TDM
  OldCreateOrder = False
  Left = 300
  Top = 181
  Height = 337
  Width = 574
  object sqlConnection: TSQLConnection
    ConnectionName = 'IBConnection'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    KeepConnection = False
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=C:\Users\Mazu\Downloads\CurralRel\BD\curral.fdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'fbclient.dll'
    Left = 24
    Top = 16
  end
  object sqldtstProprietarios: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqlConnection
    Left = 107
    Top = 23
  end
  object dtstprvdrProprietarios: TDataSetProvider
    DataSet = sqldtstProprietarios
    Left = 140
    Top = 23
  end
  object clntdtstProprietarios: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dtstprvdrProprietarios'
    Left = 172
    Top = 23
  end
  object dtsrcProprietarios: TDataSource
    DataSet = clntdtstProprietarios
    Left = 204
    Top = 23
  end
  object sqldtstPesquisa: TSQLDataSet
    DataSource = dtsrcPesquisa
    MaxBlobSize = -1
    ParamCheck = False
    Params = <>
    SQLConnection = sqlConnection
    Left = 115
    Top = 87
  end
  object dtstprvdrPesquisa: TDataSetProvider
    DataSet = sqldtstPesquisa
    Left = 148
    Top = 87
  end
  object clntdtstPesquisa: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dtstprvdrPesquisa'
    Left = 180
    Top = 87
  end
  object dtsrcPesquisa: TDataSource
    DataSet = clntdtstPesquisa
    Left = 212
    Top = 87
  end
  object sqldtstAnimal: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqlConnection
    Left = 115
    Top = 159
  end
  object dtstprvdrAnimal: TDataSetProvider
    DataSet = sqldtstAnimal
    Left = 148
    Top = 159
  end
  object clntdtstAnimal: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dtstprvdrAnimal'
    Left = 180
    Top = 159
  end
  object dtsrcAnimal: TDataSource
    DataSet = clntdtstAnimal
    Left = 212
    Top = 159
  end
end

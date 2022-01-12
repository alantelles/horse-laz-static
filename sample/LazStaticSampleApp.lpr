program LazStaticSampleApp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes
  { you can add units after this },
  Horse, Horse.LazStatic;

procedure RespondFileInFolder(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  FType, FName: string;
begin
  Req.Params.TryGetValue('filename', FName);
  Req.Params.TryGetValue('filetype', FType);
  THorseStaticResponse(Res).SendStatic(FType + directorySeparator + Fname);
end;

procedure RespondIndex(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  FName: string;
begin                                                     
  // The specialized class from THorseResponse provides a method to send a static file in response.
  // The Mime Type is detected from extension
  // If it's not possible, application/octet-stream is used
  THorseStaticResponse(Res).SendStatic('index.html');
end;

begin
  // Set the folder which will be used as static files root
  THorse.Use(LazStatic('public'));
  THorse.Get('/static/:filetype/:filename', @RespondFileInFolder);
  THorse.Get('/', @RespondIndex);
  THorse.Listen(9000);
end.

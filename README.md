# LazStatic
<b>LazStatic</b> is a middleware which provides auto reload features when detected changes in file system developed for use with <a href="https://github.com/HashLoad/horse">Horse</a> applications with view processing which deliver HTML content in response.

## ⚙️ Installation

Download the latest release and include the source path with **Project > Project options > Compiler options > Paths > Other unit files**.

*NOTE: This procedure refers to Lazarus. Middleware not tested with Delphi. There is no plan to port this middleware for Delphi as there are already other Horse middleware options for the purpose.*

*NOTE: This middleware is tested with Horse 2.0.14 release.*

## ✔️ Compatibility
This middleware is compatible with projects developed in:
- [X] Lazarus

## ⚡️ Quickstart Lazarus

Sample excerpt

**NOTE:** The build folder of the sample is the path where application runs. The static root folder must be set from there.

**NOTE:** You will need to setup the paths for Horse units.

```delphi
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
```

Check [**sample**](https://github.com/alantelles/horse-laz-static/tree/main/sample) folder for more.

## ⚠️ License
**LazStatic** is free and open-source middleware licensed under the [MIT License](https://github.com/alantelles/horse-laz-static/blob/main/LICENSE). 

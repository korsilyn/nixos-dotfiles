{ hostName, ... }:
{
  imports = [
    ./${hostName}
    ./lang
  ];
}

local aspectRatio = display.pixelHeight / display.pixelWidth

application =
{
   content =
   {
      width = aspectRatio > 1.5 and 640 or math.ceil(960 / aspectRatio),
      height = aspectRatio < 1.5 and 960 or math.ceil(640 * aspectRatio),
      scale = "letterBox",
      fps = 60,

      imageSuffix =
      {
         ["@2x"] = 1.5,
         --["@4x"] = 3.0,
      },
   },
}

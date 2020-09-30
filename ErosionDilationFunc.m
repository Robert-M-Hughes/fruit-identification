function out = ErosionDilationFunc(input_image)


out = erosion(input_image);
out = erosion(out);
out = dilation(out);
out = dilation(out);
out = dilation(out);
end
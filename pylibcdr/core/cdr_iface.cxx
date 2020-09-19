#include <iostream>
#include <stdio.h>
#include <string.h>
#include <libcdr/libcdr.h>
#include <librevenge/librevenge.h>
#include <librevenge-generators/librevenge-generators.h>
#include <librevenge-stream/librevenge-stream.h>
#include <libcdr/libcdr.h>


std::string svg(char* file) {
  librevenge::RVNGFileStream input(file);
  librevenge::RVNGStringVector output;
  librevenge::RVNGSVGDrawingGenerator painter(output, "svg");

  if (!libcdr::CDRDocument::isSupported(&input))
  {
    if (!libcdr::CMXDocument::isSupported(&input))
    {
      fprintf(stderr, "ERROR: Unsupported file format (unsupported version) or file is encrypted!\n");
      return "";
    }
    else if (!libcdr::CMXDocument::parse(&input, &painter))
    {
      fprintf(stderr, "ERROR: Parsing of document failed!\n");
      return "";
    }
  }
  else if (!libcdr::CDRDocument::parse(&input, &painter))
  {
    fprintf(stderr, "ERROR: Parsing of document failed!\n");
    return "";
  }

  if (output.empty())
  {
    std::cerr << "ERROR: No SVG document generated!" << std::endl;
    return "";
  }

  std::string res = "";

  res.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
  res.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">");
  res.append("<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:svg=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">");
  res.append("<body>");
  res.append("<?import namespace=\"svg\" urn=\"http://www.w3.org/2000/svg\"?>");

  for (unsigned k = 0; k<output.size(); ++k)
  {
    if (k>0)
      res.append("<hr/>\n");

    res.append("<!-- \n");
    res.append("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n");
    res.append("<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\"");
    res.append(" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n");
    res.append(" -->\n");

    res.append(output[k].cstr());
  }

  res.append("</body>");
  res.append("</html>");
  return res;
}
/*=========================================================================

  Program:   ORFEO Toolbox
  Language:  C++
  Date:      $Date$
  Version:   $Revision$


  Copyright (c) Centre National d'Etudes Spatiales. All rights reserved.
  See OTBCopyright.txt for details.


     This software is distributed WITHOUT ANY WARRANTY; without even
     the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
     PURPOSE.  See the above copyright notices for more information.

=========================================================================*/
#include "itkExceptionObject.h"

#include "otbRAndGAndNIRIndexImageFilter.h"
#include "otbImage.h"
#include "otbImageFileReader.h"
#include "otbImageFileWriter.h"
#include "otbSoilIndicesFunctor.h"

int otbIBGAndRAndNIRIndexImageFilter(int argc, char * argv[])
{
  const unsigned int Dimension = 2;
  typedef double                           PixelType;
  typedef otb::Image<PixelType, Dimension> InputRImageType;
  typedef otb::Image<PixelType, Dimension> InputGImageType;
  typedef otb::Image<PixelType, Dimension> InputNIRImageType;
  typedef otb::Image<double, Dimension>    OutputImageType;

  typedef otb::ImageFileReader<InputRImageType>   RReaderType;
  typedef otb::ImageFileReader<InputGImageType>   GReaderType;
  typedef otb::ImageFileReader<InputNIRImageType> NIRReaderType;
  typedef otb::ImageFileWriter<OutputImageType>   WriterType;

  typedef otb::Functor::IB2<InputGImageType::PixelType,
      InputRImageType::PixelType,
      InputNIRImageType::PixelType,
      OutputImageType::PixelType> FunctorType;

  // Warning : the order of the channels are not the same between the functor and the filter
  typedef otb::RAndGAndNIRIndexImageFilter<InputRImageType,
      InputGImageType,
      InputNIRImageType,
      OutputImageType,
      FunctorType> RAndGAndNIRIndexImageFilterType;

  // Instantiating object
  RAndGAndNIRIndexImageFilterType::Pointer filter = RAndGAndNIRIndexImageFilterType::New();
  RReaderType::Pointer                     readerR = RReaderType::New();
  GReaderType::Pointer                     readerG = GReaderType::New();
  NIRReaderType::Pointer                   readerNIR = NIRReaderType::New();
  WriterType::Pointer                      writer = WriterType::New();

  const char * inputFilenameR  = argv[1];
  const char * inputFilenameG  = argv[2];
  const char * inputFilenameNIR  = argv[3];
  const char * outputFilename = argv[4];

  readerR->SetFileName(inputFilenameR);
  readerG->SetFileName(inputFilenameG);
  readerNIR->SetFileName(inputFilenameNIR);
  writer->SetFileName(outputFilename);
  filter->SetInputR(readerR->GetOutput());
  filter->SetInputG(readerG->GetOutput());
  filter->SetInputNIR(readerNIR->GetOutput());

  writer->SetInput(filter->GetOutput());
  writer->Update();

  return EXIT_SUCCESS;
}

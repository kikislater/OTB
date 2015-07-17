      subroutine gli(iwa)
c
c created: R. Hoeller 3/10/2002
c GLI response function values 
c are based on version (NASDA/EORC 99.7.19)
c Values are interpolated to 2.5nm wavelenght intervals
c changed by J. Nieke to channel 30
c
      real s,wlinf,wlsup
      common /sixs_ffu/ s(1501),wlinf,wlsup
      real sr(30,1501),wli(30),wls(30)
      integer iwa,l,i
c band 1 of GLI (380nm at 1km)
      DATA (SR(1,L),L=1,1501)/ 48*0.,
     A .0006, .0143, .1695, .7856, 1.0000, .8603, .6609, .1362,
     A .0046, .0000,
     A1443*0./

c band 2 of GLI (400 nm at 1km)
      DATA (SR(2,L),L=1,1501)/ 55*0.,
     A .0001, .0032, .0578, .3966, .8555, 1.000, .8754, .3549,
     A .0191, .0021, .0002, 
     A1435*0./
c band 3 of GLI (412 nm at 1km)
      DATA (SR(3,L),L=1,1501)/ 59*0.,
     A .0006, .0018, .0115, .1084, .4950, .9144, .9933, 1.0000, 
     A .5040, .0449, .0055, .0023, .0008,
     A1429*0./
c band 4 of GLI (443H/L nm at 1km)
      DATA (SR(4,L),L=1,1501)/ 73*0.,
     A .0013, .0284, .3606, .9418, 1.0000, .8609, .4104, .0245,
     A .0009, 
     A1419*0./ 
c band 5 of GLI (460H/L nm at 1km)
      DATA (SR(5,L),L=1,1501)/ 79*0.,
     A .0005, .0041, .0679, .5128, 1.0000, .9945, .8005, .2593,
     A .0180, .0025,
     A1412*0./ 
c band 6 of GLI (490 nm at 1km)
      DATA (SR(6,L),L=1,1501)/ 90*0.,
     A .0009, .0028, .0132, .1541, .6700, 1.0000, .9974, .9177,
     A .5027, .0599, .0058, .0018, .0004, 
     A1398*0./ 
c band 7 of GLI (520H/L nm at 1km)
      DATA (SR(7,L),L=1,1501)/ 103*0.,
     A .0016, .0081, .1404, .6543, 1.0000, .9842, .8295, .3512,
     A .0247, .0023, .0000,
     A1387*0./ 
c band 8 of GLI (545H/L nm at 1km)
      DATA (SR(8,L),L=1,1501)/ 111*0.,
     A .0008, .0017, .0054, .0356, .2764, .7050, 1.0000, .9969,
     A .7746, .3752, .0672, .0096, .0034, .0012,
     A1376*0./ 
c band 9 of GLI (565 nm at 1km)
      DATA (SR(9,L),L=1,1501)/ 119*0.,
     A .0003, .0011, .0040, .0215, .1750, .5370, .9137, 1.0000, 
     A .8500, .5092, .1436, .0214, .0073, .0031, .0011, 
     A1367*0./ 
c band 10 of GLI (625 nm at 1km)
      DATA (SR(10,L),L=1,1501)/ 144*0.,
     A .0030, .0066, .0296, .1705, .5002, .9069, 1.0000, .8731, 
     A .5293, .1088, .0148, .0009, .0003, 
     A1344*0./ 
c band 11 of GLI (666 nm at 1km)
      DATA (SR(11,L),L=1,1501)/ 161*0.,
     A .0027, .0080, .0602, .2599, .6287, .9786, 1.0000, .8146, 
     A .4406, .0821, .0101, .0006, .0002, 
     A1327*0./ 
c band 12 of GLI (680 nm at 1km)
      DATA (SR(12,L),L=1,1501)/ 166*0.,
     A .0035, .0041, .0196, .1472, .4664, .8574, 1.0000, .8410,
     A .5263, .1281, .0117, .0005, .0002, 
     A1322*0./ 
c band 13 of GLI (678 nm at 1km)
      DATA (SR(13,L),L=1,1501)/ 165*0.,
     A .0052, .0024, .0112, .0766, .3230, .7425, 1.0000, .9832,
     A .7510, .3495, .0496, .0006, .0003, .0002, .0001, 
     A1321*0./ 
c band 14 of GLI (710 nm at 1km)
      DATA (SR(14,L),L=1,1501)/ 177*0.,
     A .0019, .0058, .0069, .0310, .1591, .4483, .8020, 1.0000, 
     A .9333, .6808, .3058, .0424, .0055, .0007, .0002, 
     A1309*0./ 
c band 15 of GLI (710 nm at 1km)
      DATA (SR(15,L),L=1,1501)/ 177*0.,
     A .0019, .0058, .0094, .0462, .2016, .5075, .8590, 1.0000, 
     A .9067, .6282, .2518, .0323, .0042, .0005, .0001, 
     A1309*0./ 
c band 16 of GLI (749 nm at 1km)
      DATA (SR(16,L),L=1,1501)/ 193*0.,
     A .0035, .0038, .0173, .0867, .3220, .7013, .9994, 1.0000,
     A .8014, .4503, .1004, .0152, .0023, .0004, .0000, 
     A1293*0./ 
c band 17 of GLI (763 nm at 1km)
      DATA (SR(17,L),L=1,1501)/ 200*0.,
     A .0013, .0076, .0821, .3724, .8271, 1.0000, .7206, .2798,
     A .0199, .0031, .0000, 
     A1290*0./ 
c band 18 of GLI (865 nm at 1km)
      DATA (SR(18,L),L=1,1501)/ 236*0.,
     A .0013, .0031, .0024, .0084, .0324, .1326, .3645, .6840,
     A .9222, .9612, .9740, 1.0000, .9819, .8727, .6850, .3029,
     A .0679, .0226, .0070, .0204, .0137, .0033, 
     A1243*0./ 
c band 19 of GLI (865 nm at 1km)
      DATA (SR(19,L),L=1,1501)/ 240*0.,
     A .0010, .0065, .0299, .1312, .3830, .7718, 1.0000, .9379,
     A .7040, .2942, .0449, .0004, .0001, 
     A1248*0./ 
c band 20 of GLI (460 nm at 250m)
      DATA (SR(20,L),L=1,1501)/ 66*0.,
     A .0043, .0160, .0373, .872, .1678, .3194, .4940, .6032,
     A .6765, .7175, .7529, .7680, .7501, .7582, .7786, .8087,
     A .8411, .8650, .8807, .8860, .9122, .9378, .9493, .9414,
     A .9247, .9108, .9236, .9582, 1.0000, .9741, .8148, .5002,
     A .2119, .0787, .0308, .0147, .0077, .0041,  
     A1397*0./ 
c band 21 of GLI (545 nm at 250m)
      DATA (SR(21,L),L=1,1501)/ 102*0.,
     A .0059, .0150, .0368, .0908, .2109, .4416, .7030, .8303,
     A .8361, .8131, .8287, .8874, .9466, .9827, 1.0000, .9816,
     A .9369, .9247, .9719, .9915, .9360, .9012, .9332, .8642,
     A .6192, .3670, .1984, .0938, .0363, .0145, .0061,  
     A1368*0./ 
c band 22 of GLI (660 nm at 250m)
      DATA (SR(22,L),L=1,1501)/ 143*0.,
     A .0050, .0084, .0126, .0193, .0333, .0606, .1010, .1526,
     A .2315, .3722, .5786, .7782, .8558, .8646, .8744, .8732,
     A .8729, .8772, .8969, .9213, .9401, .9467, .9453, .9485, 
     A .9656, .9844, .9986, 1.0000, .9907, .9971, .9878, .9479, 
     A .8280, .6115, .3401, .1529, .0736, .0391, .0237, .0143, 
     A .0080, .0040, .0022, .0013,
     A1314*0./ 
c band 23 of GLI (825 nm at 250m)
      DATA (SR(23,L),L=1,1501)/ 198*0.,
     A .0104, .0166, .0242, .0289, .0393, .0477, .0620, .0847, 
     A .1155, .1654, .2424, .3491, .4884, .6336, .7547, .8044,
     A .8386, .8373, .8479, .8822, .9290, .9644, .9888, .9916, 
     A 1.0000, .9930, .9925, .9916, .9944, .9841, .9813, .9757, 
     A .9747, .9574, .9523, .9370, .9242, .9100, .9003, .8681,
     A .8372, .7883, .7708, .7760, .7806, .7435, .7320, .7169, 
     A .6866, .6593, .6233, .5975, .5890, .5268, .4429, .3085, 
     A .1714, .0903, .0485, .0261, .0138, .0069, .0031, .0014,
     A .0014,  .0008,
     A1237*0./ 
c band 24 of GLI (1050 nm at 1km)
      DATA (SR(24,L),L=1,1501)/ 312*0.,
     A .0043, .0253, .1014, .2803, .5436, .8665, 1.0000, .9959,
     A .9545, .9160, .8200, .6640, .4227, .1146, .0191, .0049,
     A .0037 ,
     A1172*0./ 
c band 25 of GLI (1135 nm at 1km)
      DATA (SR(25,L),L=1,1501)/ 334*0.,
     A .0032, .0064, .0135, .0313, .0709, .1657, .3032, .5037, 
     A .7128, .8368, .8686, .8896, .8938, .8909, .9150, .9421, 
     A .9305, .9427, 1.0000, .9961, .9556, .9633, .9678, .8963, 
     A .8757, .8838, .8893, .8777, .8674, .8761, .8867, .8587, 
     A .7940, .7151, .5976, .4265, .2509, .1289, .0623, .0317, 
     A .0159, .0085, .0046,
     A1124*0./ 
c band 26 of GLI (1240 nm at 1km)
      DATA (SR(26,L),L=1,1501)/ 388*0.,
     A .0058, .0178, .0508, .1410, .2924, .5056, .7681, .9331, 
     A .9930, 1.0000, .9270, .8278, .5676, .2490, .0835, .0235, 
     A .0059, .0020,
     A1095*0./ 
c band 27 of GLI (1338 nm at 1km)
      DATA (SR(27,L),L=1,1501)/ 439*0.,
     A .0068, .0219, .0541, .1136, .2214, .3447, .4893, .6701, 
     A .7770, .8363, .9081, .9563, .9807, 1.0000, .9893, .9989, 
     A .9617, .9284, .8841, .7611, .6234, .4452, .2543, .0950, 
     A .0273, .0081, .0034, .0008,
     A1034*0./ 
c band 28 of GLI (1640 nm at 250m)
      DATA (SR(28,L),L=1,1501)/ 506*0.,
     A .0022, .0042, .0072, .0114, .0181, .0304, .0500, .0864, 
     A .1525, .2561, .3996, .5604, .6781, .7316, .7521, .7678, 
     A .7857, .8055, .8261, .8478, .8650, .8731, .8779, .8840, 
     A .8911, .8986, .9087, .9211, .9313, .9330, .9345, .9424, 
     A .9474, .9456, .9506, .9539, .9576, .9550, .9544, .9609, 
     A .9611, .9619, .9638, .9628, .9564, .9435, .9316, .9189, 
     A .9044, .8829, .8633, .8435, .8332, .8268, .8248, .8276, 
     A .8342, .8459, .8605, .8739, .8905, .9054, .9116, .9168, 
     A .9208, .9184, .9170, .9159, .9161, .9123, .9065, .9042, 
     A .9080, .9129, .9168, .9267, .9410, .9501, .9547, .9648, 
     A .9752, .9831, .9887, .9962, 1.0000, .9988, .9887, .9686, 
     A .9239, .8401, .7266, .5947, .4558, .3330, .2379, .1669, 
     A .1172, .0851, .0612, .0453, .0333, .0244, .0193,
     A892*0./ 
c band 29 of GLI (2210 nm at 250m)
      DATA (SR(29,L),L=1,1501)/ 722*0.,
     A .0045, .0027, .0087, .0069, .0105, .0153, .0255, .0390, 
     A .0653, .1022, .1419, .2048, .2903, .4057, .5334, .6650, 
     A .7886, .8657, .9184, .9321, .9491, .9246, .9173, .9147, 
     A .9202, .9112, .9217, .9243, .9385, .9563, 1.0000, .9859, 
     A .9868, .9994, .9922, .9815, .9908, .9855, .9711, .9728, 
     A .9782, .9934, .9558, .9815, .9481, .9466, .9257, .9285, 
     A .9403, .9677, .9883, .9650, .9908, .9337, .9125, .8639, 
     A .8543, .8834, .8884, .9043, .8717, .8820, .8926, .8361, 
     A .7852, .7500, .7733, .7568, .7741, .7927, .7819, .7689, 
     A .7631, .7051, .7291, .6841, .6780, .6827, .7425, .6906, 
     A .7343, .6891, .6785, .6517, .6190, .6325, .6353, .6531, 
     A .6623, .7007, .6663, .6919, .6916, .6454, .6366, .6423, 
     A .6470, .6354, .6512, .6222, .6069, .5461, .5012, .4481, 
     A .3781, .3251, .2790, .2318, .1869, .1509, .1173, .0889, 
     A .0676, .0430, .0306, .0267, .0247,
     A662*0./ 
c band 30 of GLI (3715 nm at 1km)  (remark: cut-off at 4.um)
      DATA (SR(30,L),L=1,1501)/ 1188*0.,
     A .0001, .0001, .0001, .0001, .0001, .0001, .0002, .0002, 
     A .0002, .0003, .0003, .0003, .0003, .0003, .0003, .0003, 
     A .0003, .0004, .0005, .0005, .0005, .0006, .0007, .0009, 
     A .0012, .0011, .0010, .0013, .0016, .0018, .0021, .0022, 
     A .0022, .0024, .0025, .0027, .0028, .0030, .0031, .0037, 
     A .0042, .0043, .0044, .0047, .0049, .0052, .0054, .0059, 
     A .0063, .0066, .0068, .0070, .0071, .0075, .0079, .0083, 
     A .0088, .0090, .0092, .0097, .0102, .0104, .0106, .0107, 
     A .0108, .0114, .0120, .0124, .0129, .0135, .0141, .0149, 
     A .0157, .0159, .0161, .0168, .0176, .0185, .0193, .0197, 
     A .0202, .0209, .0217, .0229, .0241, .0250, .0259, .0267, 
     A .0275, .0286, .0297, .0305, .0313, .0327, .0341, .0355, 
     A .0368, .0381, .0393, .0409, .0424, .0437, .0449, .0472, 
     A .0495, .0511, .0528, .0561, .0594, .0629, .0663, .0707, 
     A .0751, .0808, .0865, .0935, .1005, .1100, .1196, .1335, 
     A .1475, .1652, .1829, .2060, .2291, .2611, .2931, .3323, 
     A .3715, .4179, .4643, .5140, .5637, .6106, .6575, .6951, 
     A .7328, .7539, .7749, .7815, .7881, .7860, .7838, .7813, 
     A .7789, .7800, .7812, .7868, .7924, .7973, .8022, .8080, 
     A .8138, .8203, .8269, .8315, .8361, .8401, .8440, .8472, 
     A .8503, .8532, .8562, .8572, .8582, .8582, .8582, .8570, 
     A .8559, .8552, .8546, .8551, .8555, .8575, .8595, .8626, 
     A .8658, .8702, .8746, .8799, .8852, .8921, .8990, .9075, 
     A .9161, .9232, .9302, .9355, .9408, .9459, .9510, .9543, 
     A .9576, .9594, .9612, .9605, .9599, .9587, .9576, .9559, 
     A .9543, .9523, .9503, .9493, .9483, .9497, .9510, .9528, 
     A .9546, .9589, .9632, .9678, .9724, .9768, .9812, .9850, 
     A .9888, .9916, .9944, .9969, .9993, .9997, 1.0000,
     A .9992, .9984, .9974, .9964, .9939, .9914, .9885, .9855, 
     A .9844, .9832, .9804, .9776, .9740, .9704, .9689, .9674, 
     A .9659, .9645, .9622, .9599, .9587, .9576, .9544, .9513, 
     A .9472, .9431, .9365, .9299, .9174, .9050, .8832, .8615, 
     A .8323, .8032, .7656, .7279, .6884, .6490, .6135, .5782, 
     A .5497, .5212, .5005, .4798, .4602, .4406, .4189, .3972, 
     A .3704, .3435, .3142, .2849, .2580, .2311, .2078, .1845, 
     A .1660, .1476, .1345, .1214, .1118, .1022, .0944, .0866, 
     A .0810, .0753, .0707, .0659, .0612, .0564, .0542, .0520, 
     A .0494, .0468, .0447, .0425, .0401, .0378, .0359, .0340, 
     A .0328, .0316, .0311, .0305, .0298, .0291, .0282, .0273, 
     A .0262, .0252 / 

c channel 1 lower and upper wavelength
      wli(1)=0.37
      wls(1)=0.3925
c channel 2 lower and upper wavelength
      wli(2)=0.3875
      wls(2)=0.4125
c channel 3 lower and upper wavelength
      wli(3)=0.3975
      wls(3)=0.4275
c channel 4 lower and upper wavelength
      wli(4)=0.4325
      wls(4)=0.4525
c channel 5 lower and upper wavelength
      wli(5)=0.4475
      wls(5)=0.47
c channel 6 lower and upper wavelength
      wli(6)=0.475
      wls(6)=0.505
c channel 7 lower and upper wavelength
      wli(7)=0.5075
      wls(7)=0.5325
c channel 8 lower and upper wavelength
      wli(8)=0.5275
      wls(8)=0.56
c channel 9 lower and upper wavelength
      wli(9)=0.5475
      wls(9)=0.5825
c channel 10 lower and upper wavelength
      wli(10)=0.61
      wls(10)=0.64
c channel 11 lower and upper wavelength
      wli(11)=0.6525
      wls(11)=0.6825
c channel 12 lower and upper wavelength
      wli(12)=0.665
      wls(12)=0.695
c channel 13 lower and upper wavelength
      wli(13)=0.6625
      wls(13)=0.6975
c channel 14 lower and upper wavelength
      wli(14)=0.6925
      wls(14)=0.7275
c channel 15 lower and upper wavelength
      wli(15)=0.6925
      wls(15)=0.7275
c channel 16 lower and upper wavelength
      wli(16)=0.7325
      wls(16)=0.7675
c channel 17 lower and upper wavelength
      wli(17)=0.75
      wls(17)=0.775
c channel 18 lower and upper wavelength
      wli(18)=0.840
      wls(18)=0.8925
c channel 19 lower and upper wavelength
      wli(19)=0.85
      wls(19)=0.88
c channel 20 lower and upper wavelength
      wli(20)=0.415
      wls(20)=0.5075
c channel 21 lower and upper wavelength
      wli(21)=0.505
      wls(21)=0.58
c channel 22 lower and upper wavelength
      wli(22)=0.6075
      wls(22)=0.715
c channel 23 lower and upper wavelength
      wli(23)=0.745
      wls(23)=0.9075
c channel 24 lower and upper wavelength
      wli(24)=1.03
      wls(24)=1.07
c channel 25 lower and upper wavelength
      wli(25)=1.085
      wls(25)=1.19
c channel 26 lower and upper wavelength
      wli(26)=1.22
      wls(26)=1.2625
c channel 27 lower and upper wavelength
      wli(27)=1.3475
      wls(27)=1.415
c channel 28 lower and upper wavelength
      wli(28)=1.515
      wls(28)=1.77
c channel 29 lower and upper wavelength
      wli(29)=2.055
      wls(29)=2.345
c channel 30 lower and upper wavelength
      wli(30)=3.22
      wls(30)=4.0

      do 1 i=1,1501
      s(i)=sr(iwa,i)
    1 continue

      wlinf=wli(iwa)
      wlsup=wls(iwa)
      return
      end
			
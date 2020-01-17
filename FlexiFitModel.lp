\ Model GLayout
\ LP format - for model browsing. Use MPS format to capture full model detail.
Minimize
  0.001 L[0] + 0.001 L[1] + 0.001 L[2] + 0.001 L[3] + 0.001 L[4]
   + 0.001 L[5] + 0.002 R[0] + 0.002 R[1] + 0.002 R[2] + 0.002 R[3]
   + 0.002 R[4] + 0.002 R[5] + 0.001 T[0] + 0.001 T[1] + 0.001 T[2]
   + 0.001 T[3] + 0.001 T[4] + 0.001 T[5] + 0.002 B[0] + 0.002 B[1]
   + 0.002 B[2] + 0.002 B[3] + 0.002 B[4] + 0.002 B[5] - 0.001 H[0]
   - 0.001 H[1] - 0.001 H[2] - 0.001 H[3] - 0.001 H[4] - 0.001 H[5]
   - 0.001 W[0] - 0.001 W[1] - 0.001 W[2] - 0.001 W[3] - 0.001 W[4]
   - 0.001 W[5] + 0 ABOVE[0,0] + 0 ABOVE[1,1] + 0 ABOVE[2,2] + 0 ABOVE[3,3]
   + 0 ABOVE[4,4] + 0 ABOVE[5,5] + 0 LEFT[0,0] + 0 LEFT[1,1] + 0 LEFT[2,2]
   + 0 LEFT[3,3] + 0 LEFT[4,4] + 0 LEFT[5,5] + LAG[0] + LAG[1] + LAG[2]
   + LAG[3] + LAG[4] + LAG[5] + RAG[0] + RAG[1] + RAG[2] + RAG[3] + RAG[4]
   + RAG[5] + TAG[0] + TAG[1] + TAG[2] + TAG[3] + TAG[4] + TAG[5] + BAG[0]
   + BAG[1] + BAG[2] + BAG[3] + BAG[4] + BAG[5]
Subject To
 R0: - R[0] + maxX >= 0
 R1: - B[0] + maxY >= 0
 R2: - R[1] + maxX >= 0
 R3: - B[1] + maxY >= 0
 R4: - R[2] + maxX >= 0
 R5: - B[2] + maxY >= 0
 R6: - R[3] + maxX >= 0
 R7: - B[3] + maxY >= 0
 R8: - R[4] + maxX >= 0
 R9: - B[4] + maxY >= 0
 R10: - R[5] + maxX >= 0
 R11: - B[5] + maxY >= 0
 R12: LAG[0] + LAG[1] + LAG[2] + LAG[3] + LAG[4] + LAG[5] + RAG[0] + RAG[1]
   + RAG[2] + RAG[3] + RAG[4] + RAG[5] + TAG[0] + TAG[1] + TAG[2] + TAG[3]
   + TAG[4] + TAG[5] + BAG[0] + BAG[1] + BAG[2] + BAG[3] + BAG[4] + BAG[5]
   >= 10
 Disable_non-permitted_based_on_prespecified: ABOVE[1,0] + ABOVE[2,0]
   + ABOVE[3,0] + 2 ABOVE[4,0] + ABOVE[4,1] + ABOVE[4,2] + ABOVE[4,3]
   + ABOVE[4,5] + ABOVE[5,0] = 0
 R-L=W(0): L[0] - R[0] + W[0] = 0
 B-T=H(0): T[0] - B[0] + H[0] = 0
 R-L=W(1): L[1] - R[1] + W[1] = 0
 B-T=H(1): T[1] - B[1] + H[1] = 0
 R-L=W(2): L[2] - R[2] + W[2] = 0
 B-T=H(2): T[2] - B[2] + H[2] = 0
 R-L=W(3): L[3] - R[3] + W[3] = 0
 B-T=H(3): T[3] - B[3] + H[3] = 0
 R-L=W(4): L[4] - R[4] + W[4] = 0
 B-T=H(4): T[4] - B[4] + H[4] = 0
 R-L=W(5): L[5] - R[5] + W[5] = 0
 B-T=H(5): T[5] - B[5] + H[5] = 0
 NoOverlap(10): ABOVE[0,1] + ABOVE[1,0] + LEFT[0,1] + LEFT[1,0] >= 1
 UpperLimOfQuadrants(10): ABOVE[0,1] + ABOVE[1,0] + LEFT[0,1] + LEFT[1,0]
   <= 2
 Anti-symmetryABOVE(10): ABOVE[0,1] + ABOVE[1,0] <= 1
 Anti-symmetryLEFT(10): LEFT[0,1] + LEFT[1,0] <= 1
 NoOverlap(20): ABOVE[0,2] + ABOVE[2,0] + LEFT[0,2] + LEFT[2,0] >= 1
 UpperLimOfQuadrants(20): ABOVE[0,2] + ABOVE[2,0] + LEFT[0,2] + LEFT[2,0]
   <= 2
 Anti-symmetryABOVE(20): ABOVE[0,2] + ABOVE[2,0] <= 1
 Anti-symmetryLEFT(20): LEFT[0,2] + LEFT[2,0] <= 1
 NoOverlap(21): ABOVE[1,2] + ABOVE[2,1] + LEFT[1,2] + LEFT[2,1] >= 1
 UpperLimOfQuadrants(21): ABOVE[1,2] + ABOVE[2,1] + LEFT[1,2] + LEFT[2,1]
   <= 2
 Anti-symmetryABOVE(21): ABOVE[1,2] + ABOVE[2,1] <= 1
 Anti-symmetryLEFT(21): LEFT[1,2] + LEFT[2,1] <= 1
 NoOverlap(30): ABOVE[0,3] + ABOVE[3,0] + LEFT[0,3] + LEFT[3,0] >= 1
 UpperLimOfQuadrants(30): ABOVE[0,3] + ABOVE[3,0] + LEFT[0,3] + LEFT[3,0]
   <= 2
 Anti-symmetryABOVE(30): ABOVE[0,3] + ABOVE[3,0] <= 1
 Anti-symmetryLEFT(30): LEFT[0,3] + LEFT[3,0] <= 1
 NoOverlap(31): ABOVE[1,3] + ABOVE[3,1] + LEFT[1,3] + LEFT[3,1] >= 1
 UpperLimOfQuadrants(31): ABOVE[1,3] + ABOVE[3,1] + LEFT[1,3] + LEFT[3,1]
   <= 2
 Anti-symmetryABOVE(31): ABOVE[1,3] + ABOVE[3,1] <= 1
 Anti-symmetryLEFT(31): LEFT[1,3] + LEFT[3,1] <= 1
 NoOverlap(32): ABOVE[2,3] + ABOVE[3,2] + LEFT[2,3] + LEFT[3,2] >= 1
 UpperLimOfQuadrants(32): ABOVE[2,3] + ABOVE[3,2] + LEFT[2,3] + LEFT[3,2]
   <= 2
 Anti-symmetryABOVE(32): ABOVE[2,3] + ABOVE[3,2] <= 1
 Anti-symmetryLEFT(32): LEFT[2,3] + LEFT[3,2] <= 1
 NoOverlap(40): ABOVE[0,4] + ABOVE[4,0] + LEFT[0,4] + LEFT[4,0] >= 1
 UpperLimOfQuadrants(40): ABOVE[0,4] + ABOVE[4,0] + LEFT[0,4] + LEFT[4,0]
   <= 2
 Anti-symmetryABOVE(40): ABOVE[0,4] + ABOVE[4,0] <= 1
 Anti-symmetryLEFT(40): LEFT[0,4] + LEFT[4,0] <= 1
 NoOverlap(41): ABOVE[1,4] + ABOVE[4,1] + LEFT[1,4] + LEFT[4,1] >= 1
 UpperLimOfQuadrants(41): ABOVE[1,4] + ABOVE[4,1] + LEFT[1,4] + LEFT[4,1]
   <= 2
 Anti-symmetryABOVE(41): ABOVE[1,4] + ABOVE[4,1] <= 1
 Anti-symmetryLEFT(41): LEFT[1,4] + LEFT[4,1] <= 1
 NoOverlap(42): ABOVE[2,4] + ABOVE[4,2] + LEFT[2,4] + LEFT[4,2] >= 1
 UpperLimOfQuadrants(42): ABOVE[2,4] + ABOVE[4,2] + LEFT[2,4] + LEFT[4,2]
   <= 2
 Anti-symmetryABOVE(42): ABOVE[2,4] + ABOVE[4,2] <= 1
 Anti-symmetryLEFT(42): LEFT[2,4] + LEFT[4,2] <= 1
 NoOverlap(43): ABOVE[3,4] + ABOVE[4,3] + LEFT[3,4] + LEFT[4,3] >= 1
 UpperLimOfQuadrants(43): ABOVE[3,4] + ABOVE[4,3] + LEFT[3,4] + LEFT[4,3]
   <= 2
 Anti-symmetryABOVE(43): ABOVE[3,4] + ABOVE[4,3] <= 1
 Anti-symmetryLEFT(43): LEFT[3,4] + LEFT[4,3] <= 1
 NoOverlap(50): ABOVE[0,5] + ABOVE[5,0] + LEFT[0,5] + LEFT[5,0] >= 1
 UpperLimOfQuadrants(50): ABOVE[0,5] + ABOVE[5,0] + LEFT[0,5] + LEFT[5,0]
   <= 2
 Anti-symmetryABOVE(50): ABOVE[0,5] + ABOVE[5,0] <= 1
 Anti-symmetryLEFT(50): LEFT[0,5] + LEFT[5,0] <= 1
 NoOverlap(51): ABOVE[1,5] + ABOVE[5,1] + LEFT[1,5] + LEFT[5,1] >= 1
 UpperLimOfQuadrants(51): ABOVE[1,5] + ABOVE[5,1] + LEFT[1,5] + LEFT[5,1]
   <= 2
 Anti-symmetryABOVE(51): ABOVE[1,5] + ABOVE[5,1] <= 1
 Anti-symmetryLEFT(51): LEFT[1,5] + LEFT[5,1] <= 1
 NoOverlap(52): ABOVE[2,5] + ABOVE[5,2] + LEFT[2,5] + LEFT[5,2] >= 1
 UpperLimOfQuadrants(52): ABOVE[2,5] + ABOVE[5,2] + LEFT[2,5] + LEFT[5,2]
   <= 2
 Anti-symmetryABOVE(52): ABOVE[2,5] + ABOVE[5,2] <= 1
 Anti-symmetryLEFT(52): LEFT[2,5] + LEFT[5,2] <= 1
 NoOverlap(53): ABOVE[3,5] + ABOVE[5,3] + LEFT[3,5] + LEFT[5,3] >= 1
 UpperLimOfQuadrants(53): ABOVE[3,5] + ABOVE[5,3] + LEFT[3,5] + LEFT[5,3]
   <= 2
 Anti-symmetryABOVE(53): ABOVE[3,5] + ABOVE[5,3] <= 1
 Anti-symmetryLEFT(53): LEFT[3,5] + LEFT[5,3] <= 1
 NoOverlap(54): ABOVE[4,5] + ABOVE[5,4] + LEFT[4,5] + LEFT[5,4] >= 1
 UpperLimOfQuadrants(54): ABOVE[4,5] + ABOVE[5,4] + LEFT[4,5] + LEFT[5,4]
   <= 2
 Anti-symmetryABOVE(54): ABOVE[4,5] + ABOVE[5,4] <= 1
 Anti-symmetryLEFT(54): LEFT[4,5] + LEFT[5,4] <= 1
 0(ToLeftOf)1: - L[1] + R[0] + 1112 LEFT[0,1] <= 1080
 0(Above)1: - T[1] + B[0] + 1952 ABOVE[0,1] <= 1920
 0(ConverseOfToLeftOf)1: L[1] - R[0] - 1080 LEFT[0,1] <= 32
 0(ConverseOfAboveOf)1: T[1] - B[0] - 1920 ABOVE[0,1] <= 32
 0(ToLeftOf)2: - L[2] + R[0] + 1112 LEFT[0,2] <= 1080
 0(Above)2: - T[2] + B[0] + 1952 ABOVE[0,2] <= 1920
 0(ConverseOfToLeftOf)2: L[2] - R[0] - 1080 LEFT[0,2] <= 32
 0(ConverseOfAboveOf)2: T[2] - B[0] - 1920 ABOVE[0,2] <= 32
 0(ToLeftOf)3: - L[3] + R[0] + 1112 LEFT[0,3] <= 1080
 0(Above)3: - T[3] + B[0] + 1952 ABOVE[0,3] <= 1920
 0(ConverseOfToLeftOf)3: L[3] - R[0] - 1080 LEFT[0,3] <= 32
 0(ConverseOfAboveOf)3: T[3] - B[0] - 1920 ABOVE[0,3] <= 32
 0(ToLeftOf)4: - L[4] + R[0] + 1112 LEFT[0,4] <= 1080
 0(Above)4: - T[4] + B[0] + 1952 ABOVE[0,4] <= 1920
 0(ConverseOfToLeftOf)4: L[4] - R[0] - 1080 LEFT[0,4] <= 32
 0(ConverseOfAboveOf)4: T[4] - B[0] - 1920 ABOVE[0,4] <= 32
 0(ToLeftOf)5: - L[5] + R[0] + 1112 LEFT[0,5] <= 1080
 0(Above)5: - T[5] + B[0] + 1952 ABOVE[0,5] <= 1920
 0(ConverseOfToLeftOf)5: L[5] - R[0] - 1080 LEFT[0,5] <= 32
 0(ConverseOfAboveOf)5: T[5] - B[0] - 1920 ABOVE[0,5] <= 32
 1(ToLeftOf)0: - L[0] + R[1] + 1112 LEFT[1,0] <= 1080
 1(Above)0: - T[0] + B[1] + 1952 ABOVE[1,0] <= 1920
 1(ConverseOfToLeftOf)0: L[0] - R[1] - 1080 LEFT[1,0] <= 32
 1(ConverseOfAboveOf)0: T[0] - B[1] - 1920 ABOVE[1,0] <= 32
 1(ToLeftOf)2: - L[2] + R[1] + 1112 LEFT[1,2] <= 1080
 1(Above)2: - T[2] + B[1] + 1952 ABOVE[1,2] <= 1920
 1(ConverseOfToLeftOf)2: L[2] - R[1] - 1080 LEFT[1,2] <= 32
 1(ConverseOfAboveOf)2: T[2] - B[1] - 1920 ABOVE[1,2] <= 32
 1(ToLeftOf)3: - L[3] + R[1] + 1112 LEFT[1,3] <= 1080
 1(Above)3: - T[3] + B[1] + 1952 ABOVE[1,3] <= 1920
 1(ConverseOfToLeftOf)3: L[3] - R[1] - 1080 LEFT[1,3] <= 32
 1(ConverseOfAboveOf)3: T[3] - B[1] - 1920 ABOVE[1,3] <= 32
 1(ToLeftOf)4: - L[4] + R[1] + 1112 LEFT[1,4] <= 1080
 1(Above)4: - T[4] + B[1] + 1952 ABOVE[1,4] <= 1920
 1(ConverseOfToLeftOf)4: L[4] - R[1] - 1080 LEFT[1,4] <= 32
 1(ConverseOfAboveOf)4: T[4] - B[1] - 1920 ABOVE[1,4] <= 32
 1(ToLeftOf)5: - L[5] + R[1] + 1112 LEFT[1,5] <= 1080
 1(Above)5: - T[5] + B[1] + 1952 ABOVE[1,5] <= 1920
 1(ConverseOfToLeftOf)5: L[5] - R[1] - 1080 LEFT[1,5] <= 32
 1(ConverseOfAboveOf)5: T[5] - B[1] - 1920 ABOVE[1,5] <= 32
 2(ToLeftOf)0: - L[0] + R[2] + 1112 LEFT[2,0] <= 1080
 2(Above)0: - T[0] + B[2] + 1952 ABOVE[2,0] <= 1920
 2(ConverseOfToLeftOf)0: L[0] - R[2] - 1080 LEFT[2,0] <= 32
 2(ConverseOfAboveOf)0: T[0] - B[2] - 1920 ABOVE[2,0] <= 32
 2(ToLeftOf)1: - L[1] + R[2] + 1112 LEFT[2,1] <= 1080
 2(Above)1: - T[1] + B[2] + 1952 ABOVE[2,1] <= 1920
 2(ConverseOfToLeftOf)1: L[1] - R[2] - 1080 LEFT[2,1] <= 32
 2(ConverseOfAboveOf)1: T[1] - B[2] - 1920 ABOVE[2,1] <= 32
 2(ToLeftOf)3: - L[3] + R[2] + 1112 LEFT[2,3] <= 1080
 2(Above)3: - T[3] + B[2] + 1952 ABOVE[2,3] <= 1920
 2(ConverseOfToLeftOf)3: L[3] - R[2] - 1080 LEFT[2,3] <= 32
 2(ConverseOfAboveOf)3: T[3] - B[2] - 1920 ABOVE[2,3] <= 32
 2(ToLeftOf)4: - L[4] + R[2] + 1112 LEFT[2,4] <= 1080
 2(Above)4: - T[4] + B[2] + 1952 ABOVE[2,4] <= 1920
 2(ConverseOfToLeftOf)4: L[4] - R[2] - 1080 LEFT[2,4] <= 32
 2(ConverseOfAboveOf)4: T[4] - B[2] - 1920 ABOVE[2,4] <= 32
 2(ToLeftOf)5: - L[5] + R[2] + 1112 LEFT[2,5] <= 1080
 2(Above)5: - T[5] + B[2] + 1952 ABOVE[2,5] <= 1920
 2(ConverseOfToLeftOf)5: L[5] - R[2] - 1080 LEFT[2,5] <= 32
 2(ConverseOfAboveOf)5: T[5] - B[2] - 1920 ABOVE[2,5] <= 32
 3(ToLeftOf)0: - L[0] + R[3] + 1112 LEFT[3,0] <= 1080
 3(Above)0: - T[0] + B[3] + 1952 ABOVE[3,0] <= 1920
 3(ConverseOfToLeftOf)0: L[0] - R[3] - 1080 LEFT[3,0] <= 32
 3(ConverseOfAboveOf)0: T[0] - B[3] - 1920 ABOVE[3,0] <= 32
 3(ToLeftOf)1: - L[1] + R[3] + 1112 LEFT[3,1] <= 1080
 3(Above)1: - T[1] + B[3] + 1952 ABOVE[3,1] <= 1920
 3(ConverseOfToLeftOf)1: L[1] - R[3] - 1080 LEFT[3,1] <= 32
 3(ConverseOfAboveOf)1: T[1] - B[3] - 1920 ABOVE[3,1] <= 32
 3(ToLeftOf)2: - L[2] + R[3] + 1112 LEFT[3,2] <= 1080
 3(Above)2: - T[2] + B[3] + 1952 ABOVE[3,2] <= 1920
 3(ConverseOfToLeftOf)2: L[2] - R[3] - 1080 LEFT[3,2] <= 32
 3(ConverseOfAboveOf)2: T[2] - B[3] - 1920 ABOVE[3,2] <= 32
 3(ToLeftOf)4: - L[4] + R[3] + 1112 LEFT[3,4] <= 1080
 3(Above)4: - T[4] + B[3] + 1952 ABOVE[3,4] <= 1920
 3(ConverseOfToLeftOf)4: L[4] - R[3] - 1080 LEFT[3,4] <= 32
 3(ConverseOfAboveOf)4: T[4] - B[3] - 1920 ABOVE[3,4] <= 32
 3(ToLeftOf)5: - L[5] + R[3] + 1112 LEFT[3,5] <= 1080
 3(Above)5: - T[5] + B[3] + 1952 ABOVE[3,5] <= 1920
 3(ConverseOfToLeftOf)5: L[5] - R[3] - 1080 LEFT[3,5] <= 32
 3(ConverseOfAboveOf)5: T[5] - B[3] - 1920 ABOVE[3,5] <= 32
 4(ToLeftOf)0: - L[0] + R[4] + 1112 LEFT[4,0] <= 1080
 4(Above)0: - T[0] + B[4] + 1952 ABOVE[4,0] <= 1920
 4(ConverseOfToLeftOf)0: L[0] - R[4] - 1080 LEFT[4,0] <= 32
 4(ConverseOfAboveOf)0: T[0] - B[4] - 1920 ABOVE[4,0] <= 32
 4(ToLeftOf)1: - L[1] + R[4] + 1112 LEFT[4,1] <= 1080
 4(Above)1: - T[1] + B[4] + 1952 ABOVE[4,1] <= 1920
 4(ConverseOfToLeftOf)1: L[1] - R[4] - 1080 LEFT[4,1] <= 32
 4(ConverseOfAboveOf)1: T[1] - B[4] - 1920 ABOVE[4,1] <= 32
 4(ToLeftOf)2: - L[2] + R[4] + 1112 LEFT[4,2] <= 1080
 4(Above)2: - T[2] + B[4] + 1952 ABOVE[4,2] <= 1920
 4(ConverseOfToLeftOf)2: L[2] - R[4] - 1080 LEFT[4,2] <= 32
 4(ConverseOfAboveOf)2: T[2] - B[4] - 1920 ABOVE[4,2] <= 32
 4(ToLeftOf)3: - L[3] + R[4] + 1112 LEFT[4,3] <= 1080
 4(Above)3: - T[3] + B[4] + 1952 ABOVE[4,3] <= 1920
 4(ConverseOfToLeftOf)3: L[3] - R[4] - 1080 LEFT[4,3] <= 32
 4(ConverseOfAboveOf)3: T[3] - B[4] - 1920 ABOVE[4,3] <= 32
 4(ToLeftOf)5: - L[5] + R[4] + 1112 LEFT[4,5] <= 1080
 4(Above)5: - T[5] + B[4] + 1952 ABOVE[4,5] <= 1920
 4(ConverseOfToLeftOf)5: L[5] - R[4] - 1080 LEFT[4,5] <= 32
 4(ConverseOfAboveOf)5: T[5] - B[4] - 1920 ABOVE[4,5] <= 32
 5(ToLeftOf)0: - L[0] + R[5] + 1112 LEFT[5,0] <= 1080
 5(Above)0: - T[0] + B[5] + 1952 ABOVE[5,0] <= 1920
 5(ConverseOfToLeftOf)0: L[0] - R[5] - 1080 LEFT[5,0] <= 32
 5(ConverseOfAboveOf)0: T[0] - B[5] - 1920 ABOVE[5,0] <= 32
 5(ToLeftOf)1: - L[1] + R[5] + 1112 LEFT[5,1] <= 1080
 5(Above)1: - T[1] + B[5] + 1952 ABOVE[5,1] <= 1920
 5(ConverseOfToLeftOf)1: L[1] - R[5] - 1080 LEFT[5,1] <= 32
 5(ConverseOfAboveOf)1: T[1] - B[5] - 1920 ABOVE[5,1] <= 32
 5(ToLeftOf)2: - L[2] + R[5] + 1112 LEFT[5,2] <= 1080
 5(Above)2: - T[2] + B[5] + 1952 ABOVE[5,2] <= 1920
 5(ConverseOfToLeftOf)2: L[2] - R[5] - 1080 LEFT[5,2] <= 32
 5(ConverseOfAboveOf)2: T[2] - B[5] - 1920 ABOVE[5,2] <= 32
 5(ToLeftOf)3: - L[3] + R[5] + 1112 LEFT[5,3] <= 1080
 5(Above)3: - T[3] + B[5] + 1952 ABOVE[5,3] <= 1920
 5(ConverseOfToLeftOf)3: L[3] - R[5] - 1080 LEFT[5,3] <= 32
 5(ConverseOfAboveOf)3: T[3] - B[5] - 1920 ABOVE[5,3] <= 32
 5(ToLeftOf)4: - L[4] + R[5] + 1112 LEFT[5,4] <= 1080
 5(Above)4: - T[4] + B[5] + 1952 ABOVE[5,4] <= 1920
 5(ConverseOfToLeftOf)4: L[4] - R[5] - 1080 LEFT[5,4] <= 32
 5(ConverseOfAboveOf)4: T[4] - B[5] - 1920 ABOVE[5,4] <= 32
 OneLAGForElement[0]: zLAG[0,0] + zLAG[0,1] + zLAG[0,2] + zLAG[0,3]
   + zLAG[0,4] + zLAG[0,5] = 1
 OneTAGForElement[0]: zTAG[0,0] + zTAG[0,1] + zTAG[0,2] + zTAG[0,3]
   + zTAG[0,4] + zTAG[0,5] = 1
 OneBAGForElement[0]: zBAG[0,0] + zBAG[0,1] + zBAG[0,2] + zBAG[0,3]
   + zBAG[0,4] + zBAG[0,5] = 1
 OneRAGForElement[0]: zRAG[0,0] + zRAG[0,1] + zRAG[0,2] + zRAG[0,3]
   + zRAG[0,4] + zRAG[0,5] = 1
 OneLAGForElement[1]: zLAG[1,0] + zLAG[1,1] + zLAG[1,2] + zLAG[1,3]
   + zLAG[1,4] + zLAG[1,5] = 1
 OneTAGForElement[1]: zTAG[1,0] + zTAG[1,1] + zTAG[1,2] + zTAG[1,3]
   + zTAG[1,4] + zTAG[1,5] = 1
 OneBAGForElement[1]: zBAG[1,0] + zBAG[1,1] + zBAG[1,2] + zBAG[1,3]
   + zBAG[1,4] + zBAG[1,5] = 1
 OneRAGForElement[1]: zRAG[1,0] + zRAG[1,1] + zRAG[1,2] + zRAG[1,3]
   + zRAG[1,4] + zRAG[1,5] = 1
 OneLAGForElement[2]: zLAG[2,0] + zLAG[2,1] + zLAG[2,2] + zLAG[2,3]
   + zLAG[2,4] + zLAG[2,5] = 1
 OneTAGForElement[2]: zTAG[2,0] + zTAG[2,1] + zTAG[2,2] + zTAG[2,3]
   + zTAG[2,4] + zTAG[2,5] = 1
 OneBAGForElement[2]: zBAG[2,0] + zBAG[2,1] + zBAG[2,2] + zBAG[2,3]
   + zBAG[2,4] + zBAG[2,5] = 1
 OneRAGForElement[2]: zRAG[2,0] + zRAG[2,1] + zRAG[2,2] + zRAG[2,3]
   + zRAG[2,4] + zRAG[2,5] = 1
 OneLAGForElement[3]: zLAG[3,0] + zLAG[3,1] + zLAG[3,2] + zLAG[3,3]
   + zLAG[3,4] + zLAG[3,5] = 1
 OneTAGForElement[3]: zTAG[3,0] + zTAG[3,1] + zTAG[3,2] + zTAG[3,3]
   + zTAG[3,4] + zTAG[3,5] = 1
 OneBAGForElement[3]: zBAG[3,0] + zBAG[3,1] + zBAG[3,2] + zBAG[3,3]
   + zBAG[3,4] + zBAG[3,5] = 1
 OneRAGForElement[3]: zRAG[3,0] + zRAG[3,1] + zRAG[3,2] + zRAG[3,3]
   + zRAG[3,4] + zRAG[3,5] = 1
 OneLAGForElement[4]: zLAG[4,0] + zLAG[4,1] + zLAG[4,2] + zLAG[4,3]
   + zLAG[4,4] + zLAG[4,5] = 1
 OneTAGForElement[4]: zTAG[4,0] + zTAG[4,1] + zTAG[4,2] + zTAG[4,3]
   + zTAG[4,4] + zTAG[4,5] = 1
 OneBAGForElement[4]: zBAG[4,0] + zBAG[4,1] + zBAG[4,2] + zBAG[4,3]
   + zBAG[4,4] + zBAG[4,5] = 1
 OneRAGForElement[4]: zRAG[4,0] + zRAG[4,1] + zRAG[4,2] + zRAG[4,3]
   + zRAG[4,4] + zRAG[4,5] = 1
 OneLAGForElement[5]: zLAG[5,0] + zLAG[5,1] + zLAG[5,2] + zLAG[5,3]
   + zLAG[5,4] + zLAG[5,5] = 1
 OneTAGForElement[5]: zTAG[5,0] + zTAG[5,1] + zTAG[5,2] + zTAG[5,3]
   + zTAG[5,4] + zTAG[5,5] = 1
 OneBAGForElement[5]: zBAG[5,0] + zBAG[5,1] + zBAG[5,2] + zBAG[5,3]
   + zBAG[5,4] + zBAG[5,5] = 1
 OneRAGForElement[5]: zRAG[5,0] + zRAG[5,1] + zRAG[5,2] + zRAG[5,3]
   + zRAG[5,4] + zRAG[5,5] = 1
 R230: - LAG[0] + zLAG[0,0] <= 0
 R231: - RAG[0] + zRAG[0,0] <= 0
 R232: - TAG[0] + zTAG[0,0] <= 0
 R233: - BAG[0] + zBAG[0,0] <= 0
 R234: - LAG[0] + zLAG[1,0] <= 0
 R235: - RAG[0] + zRAG[1,0] <= 0
 R236: - TAG[0] + zTAG[1,0] <= 0
 R237: - BAG[0] + zBAG[1,0] <= 0
 R238: - LAG[0] + zLAG[2,0] <= 0
 R239: - RAG[0] + zRAG[2,0] <= 0
 R240: - TAG[0] + zTAG[2,0] <= 0
 R241: - BAG[0] + zBAG[2,0] <= 0
 R242: - LAG[0] + zLAG[3,0] <= 0
 R243: - RAG[0] + zRAG[3,0] <= 0
 R244: - TAG[0] + zTAG[3,0] <= 0
 R245: - BAG[0] + zBAG[3,0] <= 0
 R246: - LAG[0] + zLAG[4,0] <= 0
 R247: - RAG[0] + zRAG[4,0] <= 0
 R248: - TAG[0] + zTAG[4,0] <= 0
 R249: - BAG[0] + zBAG[4,0] <= 0
 R250: - LAG[0] + zLAG[5,0] <= 0
 R251: - RAG[0] + zRAG[5,0] <= 0
 R252: - TAG[0] + zTAG[5,0] <= 0
 R253: - BAG[0] + zBAG[5,0] <= 0
 R254: - LAG[1] + zLAG[0,1] <= 0
 R255: - RAG[1] + zRAG[0,1] <= 0
 R256: - TAG[1] + zTAG[0,1] <= 0
 R257: - BAG[1] + zBAG[0,1] <= 0
 R258: - LAG[1] + zLAG[1,1] <= 0
 R259: - RAG[1] + zRAG[1,1] <= 0
 R260: - TAG[1] + zTAG[1,1] <= 0
 R261: - BAG[1] + zBAG[1,1] <= 0
 R262: - LAG[1] + zLAG[2,1] <= 0
 R263: - RAG[1] + zRAG[2,1] <= 0
 R264: - TAG[1] + zTAG[2,1] <= 0
 R265: - BAG[1] + zBAG[2,1] <= 0
 R266: - LAG[1] + zLAG[3,1] <= 0
 R267: - RAG[1] + zRAG[3,1] <= 0
 R268: - TAG[1] + zTAG[3,1] <= 0
 R269: - BAG[1] + zBAG[3,1] <= 0
 R270: - LAG[1] + zLAG[4,1] <= 0
 R271: - RAG[1] + zRAG[4,1] <= 0
 R272: - TAG[1] + zTAG[4,1] <= 0
 R273: - BAG[1] + zBAG[4,1] <= 0
 R274: - LAG[1] + zLAG[5,1] <= 0
 R275: - RAG[1] + zRAG[5,1] <= 0
 R276: - TAG[1] + zTAG[5,1] <= 0
 R277: - BAG[1] + zBAG[5,1] <= 0
 R278: - LAG[2] + zLAG[0,2] <= 0
 R279: - RAG[2] + zRAG[0,2] <= 0
 R280: - TAG[2] + zTAG[0,2] <= 0
 R281: - BAG[2] + zBAG[0,2] <= 0
 R282: - LAG[2] + zLAG[1,2] <= 0
 R283: - RAG[2] + zRAG[1,2] <= 0
 R284: - TAG[2] + zTAG[1,2] <= 0
 R285: - BAG[2] + zBAG[1,2] <= 0
 R286: - LAG[2] + zLAG[2,2] <= 0
 R287: - RAG[2] + zRAG[2,2] <= 0
 R288: - TAG[2] + zTAG[2,2] <= 0
 R289: - BAG[2] + zBAG[2,2] <= 0
 R290: - LAG[2] + zLAG[3,2] <= 0
 R291: - RAG[2] + zRAG[3,2] <= 0
 R292: - TAG[2] + zTAG[3,2] <= 0
 R293: - BAG[2] + zBAG[3,2] <= 0
 R294: - LAG[2] + zLAG[4,2] <= 0
 R295: - RAG[2] + zRAG[4,2] <= 0
 R296: - TAG[2] + zTAG[4,2] <= 0
 R297: - BAG[2] + zBAG[4,2] <= 0
 R298: - LAG[2] + zLAG[5,2] <= 0
 R299: - RAG[2] + zRAG[5,2] <= 0
 R300: - TAG[2] + zTAG[5,2] <= 0
 R301: - BAG[2] + zBAG[5,2] <= 0
 R302: - LAG[3] + zLAG[0,3] <= 0
 R303: - RAG[3] + zRAG[0,3] <= 0
 R304: - TAG[3] + zTAG[0,3] <= 0
 R305: - BAG[3] + zBAG[0,3] <= 0
 R306: - LAG[3] + zLAG[1,3] <= 0
 R307: - RAG[3] + zRAG[1,3] <= 0
 R308: - TAG[3] + zTAG[1,3] <= 0
 R309: - BAG[3] + zBAG[1,3] <= 0
 R310: - LAG[3] + zLAG[2,3] <= 0
 R311: - RAG[3] + zRAG[2,3] <= 0
 R312: - TAG[3] + zTAG[2,3] <= 0
 R313: - BAG[3] + zBAG[2,3] <= 0
 R314: - LAG[3] + zLAG[3,3] <= 0
 R315: - RAG[3] + zRAG[3,3] <= 0
 R316: - TAG[3] + zTAG[3,3] <= 0
 R317: - BAG[3] + zBAG[3,3] <= 0
 R318: - LAG[3] + zLAG[4,3] <= 0
 R319: - RAG[3] + zRAG[4,3] <= 0
 R320: - TAG[3] + zTAG[4,3] <= 0
 R321: - BAG[3] + zBAG[4,3] <= 0
 R322: - LAG[3] + zLAG[5,3] <= 0
 R323: - RAG[3] + zRAG[5,3] <= 0
 R324: - TAG[3] + zTAG[5,3] <= 0
 R325: - BAG[3] + zBAG[5,3] <= 0
 R326: - LAG[4] + zLAG[0,4] <= 0
 R327: - RAG[4] + zRAG[0,4] <= 0
 R328: - TAG[4] + zTAG[0,4] <= 0
 R329: - BAG[4] + zBAG[0,4] <= 0
 R330: - LAG[4] + zLAG[1,4] <= 0
 R331: - RAG[4] + zRAG[1,4] <= 0
 R332: - TAG[4] + zTAG[1,4] <= 0
 R333: - BAG[4] + zBAG[1,4] <= 0
 R334: - LAG[4] + zLAG[2,4] <= 0
 R335: - RAG[4] + zRAG[2,4] <= 0
 R336: - TAG[4] + zTAG[2,4] <= 0
 R337: - BAG[4] + zBAG[2,4] <= 0
 R338: - LAG[4] + zLAG[3,4] <= 0
 R339: - RAG[4] + zRAG[3,4] <= 0
 R340: - TAG[4] + zTAG[3,4] <= 0
 R341: - BAG[4] + zBAG[3,4] <= 0
 R342: - LAG[4] + zLAG[4,4] <= 0
 R343: - RAG[4] + zRAG[4,4] <= 0
 R344: - TAG[4] + zTAG[4,4] <= 0
 R345: - BAG[4] + zBAG[4,4] <= 0
 R346: - LAG[4] + zLAG[5,4] <= 0
 R347: - RAG[4] + zRAG[5,4] <= 0
 R348: - TAG[4] + zTAG[5,4] <= 0
 R349: - BAG[4] + zBAG[5,4] <= 0
 R350: - LAG[5] + zLAG[0,5] <= 0
 R351: - RAG[5] + zRAG[0,5] <= 0
 R352: - TAG[5] + zTAG[0,5] <= 0
 R353: - BAG[5] + zBAG[0,5] <= 0
 R354: - LAG[5] + zLAG[1,5] <= 0
 R355: - RAG[5] + zRAG[1,5] <= 0
 R356: - TAG[5] + zTAG[1,5] <= 0
 R357: - BAG[5] + zBAG[1,5] <= 0
 R358: - LAG[5] + zLAG[2,5] <= 0
 R359: - RAG[5] + zRAG[2,5] <= 0
 R360: - TAG[5] + zTAG[2,5] <= 0
 R361: - BAG[5] + zBAG[2,5] <= 0
 R362: - LAG[5] + zLAG[3,5] <= 0
 R363: - RAG[5] + zRAG[3,5] <= 0
 R364: - TAG[5] + zTAG[3,5] <= 0
 R365: - BAG[5] + zBAG[3,5] <= 0
 R366: - LAG[5] + zLAG[4,5] <= 0
 R367: - RAG[5] + zRAG[4,5] <= 0
 R368: - TAG[5] + zTAG[4,5] <= 0
 R369: - BAG[5] + zBAG[4,5] <= 0
 R370: - LAG[5] + zLAG[5,5] <= 0
 R371: - RAG[5] + zRAG[5,5] <= 0
 R372: - TAG[5] + zTAG[5,5] <= 0
 R373: - BAG[5] + zBAG[5,5] <= 0
 MinsideConnectL[0]ToLAG[0]: L[0] - vLAG[0] + 1080 zLAG[0,0] <= 1080
 MinsideConnectR[0]ToRAG[0]: R[0] - vRAG[0] + 1080 zRAG[0,0] <= 1080
 MinsideConnectT[0]ToTAG[0]: T[0] - vTAG[0] + 1920 zTAG[0,0] <= 1920
 MinsideConnectB[0]ToBAG[0]: B[0] - vBAG[0] + 1920 zBAG[0,0] <= 1920
 MaxsideConnectL[0]ToLAG[0]: L[0] - vLAG[0] - 1080 zLAG[0,0] >= -1080
 MaxsideConnectR[0]ToRAG[0]: R[0] - vRAG[0] - 1080 zRAG[0,0] >= -1080
 MaxsideConnectT[0]ToTAG[0]: T[0] - vTAG[0] - 1920 zTAG[0,0] >= -1920
 MaxsideConnectB[0]ToBAG[0]: B[0] - vBAG[0] - 1920 zBAG[0,0] >= -1920
 MinsideConnectL[1]ToLAG[0]: L[1] - vLAG[0] + 1080 zLAG[1,0] <= 1080
 MinsideConnectR[1]ToRAG[0]: R[1] - vRAG[0] + 1080 zRAG[1,0] <= 1080
 MinsideConnectT[1]ToTAG[0]: T[1] - vTAG[0] + 1920 zTAG[1,0] <= 1920
 MinsideConnectB[1]ToBAG[0]: B[1] - vBAG[0] + 1920 zBAG[1,0] <= 1920
 MaxsideConnectL[1]ToLAG[0]: L[1] - vLAG[0] - 1080 zLAG[1,0] >= -1080
 MaxsideConnectR[1]ToRAG[0]: R[1] - vRAG[0] - 1080 zRAG[1,0] >= -1080
 MaxsideConnectT[1]ToTAG[0]: T[1] - vTAG[0] - 1920 zTAG[1,0] >= -1920
 MaxsideConnectB[1]ToBAG[0]: B[1] - vBAG[0] - 1920 zBAG[1,0] >= -1920
 MinsideConnectL[2]ToLAG[0]: L[2] - vLAG[0] + 1080 zLAG[2,0] <= 1080
 MinsideConnectR[2]ToRAG[0]: R[2] - vRAG[0] + 1080 zRAG[2,0] <= 1080
 MinsideConnectT[2]ToTAG[0]: T[2] - vTAG[0] + 1920 zTAG[2,0] <= 1920
 MinsideConnectB[2]ToBAG[0]: B[2] - vBAG[0] + 1920 zBAG[2,0] <= 1920
 MaxsideConnectL[2]ToLAG[0]: L[2] - vLAG[0] - 1080 zLAG[2,0] >= -1080
 MaxsideConnectR[2]ToRAG[0]: R[2] - vRAG[0] - 1080 zRAG[2,0] >= -1080
 MaxsideConnectT[2]ToTAG[0]: T[2] - vTAG[0] - 1920 zTAG[2,0] >= -1920
 MaxsideConnectB[2]ToBAG[0]: B[2] - vBAG[0] - 1920 zBAG[2,0] >= -1920
 MinsideConnectL[3]ToLAG[0]: L[3] - vLAG[0] + 1080 zLAG[3,0] <= 1080
 MinsideConnectR[3]ToRAG[0]: R[3] - vRAG[0] + 1080 zRAG[3,0] <= 1080
 MinsideConnectT[3]ToTAG[0]: T[3] - vTAG[0] + 1920 zTAG[3,0] <= 1920
 MinsideConnectB[3]ToBAG[0]: B[3] - vBAG[0] + 1920 zBAG[3,0] <= 1920
 MaxsideConnectL[3]ToLAG[0]: L[3] - vLAG[0] - 1080 zLAG[3,0] >= -1080
 MaxsideConnectR[3]ToRAG[0]: R[3] - vRAG[0] - 1080 zRAG[3,0] >= -1080
 MaxsideConnectT[3]ToTAG[0]: T[3] - vTAG[0] - 1920 zTAG[3,0] >= -1920
 MaxsideConnectB[3]ToBAG[0]: B[3] - vBAG[0] - 1920 zBAG[3,0] >= -1920
 MinsideConnectL[4]ToLAG[0]: L[4] - vLAG[0] + 1080 zLAG[4,0] <= 1080
 MinsideConnectR[4]ToRAG[0]: R[4] - vRAG[0] + 1080 zRAG[4,0] <= 1080
 MinsideConnectT[4]ToTAG[0]: T[4] - vTAG[0] + 1920 zTAG[4,0] <= 1920
 MinsideConnectB[4]ToBAG[0]: B[4] - vBAG[0] + 1920 zBAG[4,0] <= 1920
 MaxsideConnectL[4]ToLAG[0]: L[4] - vLAG[0] - 1080 zLAG[4,0] >= -1080
 MaxsideConnectR[4]ToRAG[0]: R[4] - vRAG[0] - 1080 zRAG[4,0] >= -1080
 MaxsideConnectT[4]ToTAG[0]: T[4] - vTAG[0] - 1920 zTAG[4,0] >= -1920
 MaxsideConnectB[4]ToBAG[0]: B[4] - vBAG[0] - 1920 zBAG[4,0] >= -1920
 MinsideConnectL[5]ToLAG[0]: L[5] - vLAG[0] + 1080 zLAG[5,0] <= 1080
 MinsideConnectR[5]ToRAG[0]: R[5] - vRAG[0] + 1080 zRAG[5,0] <= 1080
 MinsideConnectT[5]ToTAG[0]: T[5] - vTAG[0] + 1920 zTAG[5,0] <= 1920
 MinsideConnectB[5]ToBAG[0]: B[5] - vBAG[0] + 1920 zBAG[5,0] <= 1920
 MaxsideConnectL[5]ToLAG[0]: L[5] - vLAG[0] - 1080 zLAG[5,0] >= -1080
 MaxsideConnectR[5]ToRAG[0]: R[5] - vRAG[0] - 1080 zRAG[5,0] >= -1080
 MaxsideConnectT[5]ToTAG[0]: T[5] - vTAG[0] - 1920 zTAG[5,0] >= -1920
 MaxsideConnectB[5]ToBAG[0]: B[5] - vBAG[0] - 1920 zBAG[5,0] >= -1920
 MinsideConnectL[0]ToLAG[1]: L[0] - vLAG[1] + 1080 zLAG[0,1] <= 1080
 MinsideConnectR[0]ToRAG[1]: R[0] - vRAG[1] + 1080 zRAG[0,1] <= 1080
 MinsideConnectT[0]ToTAG[1]: T[0] - vTAG[1] + 1920 zTAG[0,1] <= 1920
 MinsideConnectB[0]ToBAG[1]: B[0] - vBAG[1] + 1920 zBAG[0,1] <= 1920
 MaxsideConnectL[0]ToLAG[1]: L[0] - vLAG[1] - 1080 zLAG[0,1] >= -1080
 MaxsideConnectR[0]ToRAG[1]: R[0] - vRAG[1] - 1080 zRAG[0,1] >= -1080
 MaxsideConnectT[0]ToTAG[1]: T[0] - vTAG[1] - 1920 zTAG[0,1] >= -1920
 MaxsideConnectB[0]ToBAG[1]: B[0] - vBAG[1] - 1920 zBAG[0,1] >= -1920
 MinsideConnectL[1]ToLAG[1]: L[1] - vLAG[1] + 1080 zLAG[1,1] <= 1080
 MinsideConnectR[1]ToRAG[1]: R[1] - vRAG[1] + 1080 zRAG[1,1] <= 1080
 MinsideConnectT[1]ToTAG[1]: T[1] - vTAG[1] + 1920 zTAG[1,1] <= 1920
 MinsideConnectB[1]ToBAG[1]: B[1] - vBAG[1] + 1920 zBAG[1,1] <= 1920
 MaxsideConnectL[1]ToLAG[1]: L[1] - vLAG[1] - 1080 zLAG[1,1] >= -1080
 MaxsideConnectR[1]ToRAG[1]: R[1] - vRAG[1] - 1080 zRAG[1,1] >= -1080
 MaxsideConnectT[1]ToTAG[1]: T[1] - vTAG[1] - 1920 zTAG[1,1] >= -1920
 MaxsideConnectB[1]ToBAG[1]: B[1] - vBAG[1] - 1920 zBAG[1,1] >= -1920
 MinsideConnectL[2]ToLAG[1]: L[2] - vLAG[1] + 1080 zLAG[2,1] <= 1080
 MinsideConnectR[2]ToRAG[1]: R[2] - vRAG[1] + 1080 zRAG[2,1] <= 1080
 MinsideConnectT[2]ToTAG[1]: T[2] - vTAG[1] + 1920 zTAG[2,1] <= 1920
 MinsideConnectB[2]ToBAG[1]: B[2] - vBAG[1] + 1920 zBAG[2,1] <= 1920
 MaxsideConnectL[2]ToLAG[1]: L[2] - vLAG[1] - 1080 zLAG[2,1] >= -1080
 MaxsideConnectR[2]ToRAG[1]: R[2] - vRAG[1] - 1080 zRAG[2,1] >= -1080
 MaxsideConnectT[2]ToTAG[1]: T[2] - vTAG[1] - 1920 zTAG[2,1] >= -1920
 MaxsideConnectB[2]ToBAG[1]: B[2] - vBAG[1] - 1920 zBAG[2,1] >= -1920
 MinsideConnectL[3]ToLAG[1]: L[3] - vLAG[1] + 1080 zLAG[3,1] <= 1080
 MinsideConnectR[3]ToRAG[1]: R[3] - vRAG[1] + 1080 zRAG[3,1] <= 1080
 MinsideConnectT[3]ToTAG[1]: T[3] - vTAG[1] + 1920 zTAG[3,1] <= 1920
 MinsideConnectB[3]ToBAG[1]: B[3] - vBAG[1] + 1920 zBAG[3,1] <= 1920
 MaxsideConnectL[3]ToLAG[1]: L[3] - vLAG[1] - 1080 zLAG[3,1] >= -1080
 MaxsideConnectR[3]ToRAG[1]: R[3] - vRAG[1] - 1080 zRAG[3,1] >= -1080
 MaxsideConnectT[3]ToTAG[1]: T[3] - vTAG[1] - 1920 zTAG[3,1] >= -1920
 MaxsideConnectB[3]ToBAG[1]: B[3] - vBAG[1] - 1920 zBAG[3,1] >= -1920
 MinsideConnectL[4]ToLAG[1]: L[4] - vLAG[1] + 1080 zLAG[4,1] <= 1080
 MinsideConnectR[4]ToRAG[1]: R[4] - vRAG[1] + 1080 zRAG[4,1] <= 1080
 MinsideConnectT[4]ToTAG[1]: T[4] - vTAG[1] + 1920 zTAG[4,1] <= 1920
 MinsideConnectB[4]ToBAG[1]: B[4] - vBAG[1] + 1920 zBAG[4,1] <= 1920
 MaxsideConnectL[4]ToLAG[1]: L[4] - vLAG[1] - 1080 zLAG[4,1] >= -1080
 MaxsideConnectR[4]ToRAG[1]: R[4] - vRAG[1] - 1080 zRAG[4,1] >= -1080
 MaxsideConnectT[4]ToTAG[1]: T[4] - vTAG[1] - 1920 zTAG[4,1] >= -1920
 MaxsideConnectB[4]ToBAG[1]: B[4] - vBAG[1] - 1920 zBAG[4,1] >= -1920
 MinsideConnectL[5]ToLAG[1]: L[5] - vLAG[1] + 1080 zLAG[5,1] <= 1080
 MinsideConnectR[5]ToRAG[1]: R[5] - vRAG[1] + 1080 zRAG[5,1] <= 1080
 MinsideConnectT[5]ToTAG[1]: T[5] - vTAG[1] + 1920 zTAG[5,1] <= 1920
 MinsideConnectB[5]ToBAG[1]: B[5] - vBAG[1] + 1920 zBAG[5,1] <= 1920
 MaxsideConnectL[5]ToLAG[1]: L[5] - vLAG[1] - 1080 zLAG[5,1] >= -1080
 MaxsideConnectR[5]ToRAG[1]: R[5] - vRAG[1] - 1080 zRAG[5,1] >= -1080
 MaxsideConnectT[5]ToTAG[1]: T[5] - vTAG[1] - 1920 zTAG[5,1] >= -1920
 MaxsideConnectB[5]ToBAG[1]: B[5] - vBAG[1] - 1920 zBAG[5,1] >= -1920
 MinsideConnectL[0]ToLAG[2]: L[0] - vLAG[2] + 1080 zLAG[0,2] <= 1080
 MinsideConnectR[0]ToRAG[2]: R[0] - vRAG[2] + 1080 zRAG[0,2] <= 1080
 MinsideConnectT[0]ToTAG[2]: T[0] - vTAG[2] + 1920 zTAG[0,2] <= 1920
 MinsideConnectB[0]ToBAG[2]: B[0] - vBAG[2] + 1920 zBAG[0,2] <= 1920
 MaxsideConnectL[0]ToLAG[2]: L[0] - vLAG[2] - 1080 zLAG[0,2] >= -1080
 MaxsideConnectR[0]ToRAG[2]: R[0] - vRAG[2] - 1080 zRAG[0,2] >= -1080
 MaxsideConnectT[0]ToTAG[2]: T[0] - vTAG[2] - 1920 zTAG[0,2] >= -1920
 MaxsideConnectB[0]ToBAG[2]: B[0] - vBAG[2] - 1920 zBAG[0,2] >= -1920
 MinsideConnectL[1]ToLAG[2]: L[1] - vLAG[2] + 1080 zLAG[1,2] <= 1080
 MinsideConnectR[1]ToRAG[2]: R[1] - vRAG[2] + 1080 zRAG[1,2] <= 1080
 MinsideConnectT[1]ToTAG[2]: T[1] - vTAG[2] + 1920 zTAG[1,2] <= 1920
 MinsideConnectB[1]ToBAG[2]: B[1] - vBAG[2] + 1920 zBAG[1,2] <= 1920
 MaxsideConnectL[1]ToLAG[2]: L[1] - vLAG[2] - 1080 zLAG[1,2] >= -1080
 MaxsideConnectR[1]ToRAG[2]: R[1] - vRAG[2] - 1080 zRAG[1,2] >= -1080
 MaxsideConnectT[1]ToTAG[2]: T[1] - vTAG[2] - 1920 zTAG[1,2] >= -1920
 MaxsideConnectB[1]ToBAG[2]: B[1] - vBAG[2] - 1920 zBAG[1,2] >= -1920
 MinsideConnectL[2]ToLAG[2]: L[2] - vLAG[2] + 1080 zLAG[2,2] <= 1080
 MinsideConnectR[2]ToRAG[2]: R[2] - vRAG[2] + 1080 zRAG[2,2] <= 1080
 MinsideConnectT[2]ToTAG[2]: T[2] - vTAG[2] + 1920 zTAG[2,2] <= 1920
 MinsideConnectB[2]ToBAG[2]: B[2] - vBAG[2] + 1920 zBAG[2,2] <= 1920
 MaxsideConnectL[2]ToLAG[2]: L[2] - vLAG[2] - 1080 zLAG[2,2] >= -1080
 MaxsideConnectR[2]ToRAG[2]: R[2] - vRAG[2] - 1080 zRAG[2,2] >= -1080
 MaxsideConnectT[2]ToTAG[2]: T[2] - vTAG[2] - 1920 zTAG[2,2] >= -1920
 MaxsideConnectB[2]ToBAG[2]: B[2] - vBAG[2] - 1920 zBAG[2,2] >= -1920
 MinsideConnectL[3]ToLAG[2]: L[3] - vLAG[2] + 1080 zLAG[3,2] <= 1080
 MinsideConnectR[3]ToRAG[2]: R[3] - vRAG[2] + 1080 zRAG[3,2] <= 1080
 MinsideConnectT[3]ToTAG[2]: T[3] - vTAG[2] + 1920 zTAG[3,2] <= 1920
 MinsideConnectB[3]ToBAG[2]: B[3] - vBAG[2] + 1920 zBAG[3,2] <= 1920
 MaxsideConnectL[3]ToLAG[2]: L[3] - vLAG[2] - 1080 zLAG[3,2] >= -1080
 MaxsideConnectR[3]ToRAG[2]: R[3] - vRAG[2] - 1080 zRAG[3,2] >= -1080
 MaxsideConnectT[3]ToTAG[2]: T[3] - vTAG[2] - 1920 zTAG[3,2] >= -1920
 MaxsideConnectB[3]ToBAG[2]: B[3] - vBAG[2] - 1920 zBAG[3,2] >= -1920
 MinsideConnectL[4]ToLAG[2]: L[4] - vLAG[2] + 1080 zLAG[4,2] <= 1080
 MinsideConnectR[4]ToRAG[2]: R[4] - vRAG[2] + 1080 zRAG[4,2] <= 1080
 MinsideConnectT[4]ToTAG[2]: T[4] - vTAG[2] + 1920 zTAG[4,2] <= 1920
 MinsideConnectB[4]ToBAG[2]: B[4] - vBAG[2] + 1920 zBAG[4,2] <= 1920
 MaxsideConnectL[4]ToLAG[2]: L[4] - vLAG[2] - 1080 zLAG[4,2] >= -1080
 MaxsideConnectR[4]ToRAG[2]: R[4] - vRAG[2] - 1080 zRAG[4,2] >= -1080
 MaxsideConnectT[4]ToTAG[2]: T[4] - vTAG[2] - 1920 zTAG[4,2] >= -1920
 MaxsideConnectB[4]ToBAG[2]: B[4] - vBAG[2] - 1920 zBAG[4,2] >= -1920
 MinsideConnectL[5]ToLAG[2]: L[5] - vLAG[2] + 1080 zLAG[5,2] <= 1080
 MinsideConnectR[5]ToRAG[2]: R[5] - vRAG[2] + 1080 zRAG[5,2] <= 1080
 MinsideConnectT[5]ToTAG[2]: T[5] - vTAG[2] + 1920 zTAG[5,2] <= 1920
 MinsideConnectB[5]ToBAG[2]: B[5] - vBAG[2] + 1920 zBAG[5,2] <= 1920
 MaxsideConnectL[5]ToLAG[2]: L[5] - vLAG[2] - 1080 zLAG[5,2] >= -1080
 MaxsideConnectR[5]ToRAG[2]: R[5] - vRAG[2] - 1080 zRAG[5,2] >= -1080
 MaxsideConnectT[5]ToTAG[2]: T[5] - vTAG[2] - 1920 zTAG[5,2] >= -1920
 MaxsideConnectB[5]ToBAG[2]: B[5] - vBAG[2] - 1920 zBAG[5,2] >= -1920
 MinsideConnectL[0]ToLAG[3]: L[0] - vLAG[3] + 1080 zLAG[0,3] <= 1080
 MinsideConnectR[0]ToRAG[3]: R[0] - vRAG[3] + 1080 zRAG[0,3] <= 1080
 MinsideConnectT[0]ToTAG[3]: T[0] - vTAG[3] + 1920 zTAG[0,3] <= 1920
 MinsideConnectB[0]ToBAG[3]: B[0] - vBAG[3] + 1920 zBAG[0,3] <= 1920
 MaxsideConnectL[0]ToLAG[3]: L[0] - vLAG[3] - 1080 zLAG[0,3] >= -1080
 MaxsideConnectR[0]ToRAG[3]: R[0] - vRAG[3] - 1080 zRAG[0,3] >= -1080
 MaxsideConnectT[0]ToTAG[3]: T[0] - vTAG[3] - 1920 zTAG[0,3] >= -1920
 MaxsideConnectB[0]ToBAG[3]: B[0] - vBAG[3] - 1920 zBAG[0,3] >= -1920
 MinsideConnectL[1]ToLAG[3]: L[1] - vLAG[3] + 1080 zLAG[1,3] <= 1080
 MinsideConnectR[1]ToRAG[3]: R[1] - vRAG[3] + 1080 zRAG[1,3] <= 1080
 MinsideConnectT[1]ToTAG[3]: T[1] - vTAG[3] + 1920 zTAG[1,3] <= 1920
 MinsideConnectB[1]ToBAG[3]: B[1] - vBAG[3] + 1920 zBAG[1,3] <= 1920
 MaxsideConnectL[1]ToLAG[3]: L[1] - vLAG[3] - 1080 zLAG[1,3] >= -1080
 MaxsideConnectR[1]ToRAG[3]: R[1] - vRAG[3] - 1080 zRAG[1,3] >= -1080
 MaxsideConnectT[1]ToTAG[3]: T[1] - vTAG[3] - 1920 zTAG[1,3] >= -1920
 MaxsideConnectB[1]ToBAG[3]: B[1] - vBAG[3] - 1920 zBAG[1,3] >= -1920
 MinsideConnectL[2]ToLAG[3]: L[2] - vLAG[3] + 1080 zLAG[2,3] <= 1080
 MinsideConnectR[2]ToRAG[3]: R[2] - vRAG[3] + 1080 zRAG[2,3] <= 1080
 MinsideConnectT[2]ToTAG[3]: T[2] - vTAG[3] + 1920 zTAG[2,3] <= 1920
 MinsideConnectB[2]ToBAG[3]: B[2] - vBAG[3] + 1920 zBAG[2,3] <= 1920
 MaxsideConnectL[2]ToLAG[3]: L[2] - vLAG[3] - 1080 zLAG[2,3] >= -1080
 MaxsideConnectR[2]ToRAG[3]: R[2] - vRAG[3] - 1080 zRAG[2,3] >= -1080
 MaxsideConnectT[2]ToTAG[3]: T[2] - vTAG[3] - 1920 zTAG[2,3] >= -1920
 MaxsideConnectB[2]ToBAG[3]: B[2] - vBAG[3] - 1920 zBAG[2,3] >= -1920
 MinsideConnectL[3]ToLAG[3]: L[3] - vLAG[3] + 1080 zLAG[3,3] <= 1080
 MinsideConnectR[3]ToRAG[3]: R[3] - vRAG[3] + 1080 zRAG[3,3] <= 1080
 MinsideConnectT[3]ToTAG[3]: T[3] - vTAG[3] + 1920 zTAG[3,3] <= 1920
 MinsideConnectB[3]ToBAG[3]: B[3] - vBAG[3] + 1920 zBAG[3,3] <= 1920
 MaxsideConnectL[3]ToLAG[3]: L[3] - vLAG[3] - 1080 zLAG[3,3] >= -1080
 MaxsideConnectR[3]ToRAG[3]: R[3] - vRAG[3] - 1080 zRAG[3,3] >= -1080
 MaxsideConnectT[3]ToTAG[3]: T[3] - vTAG[3] - 1920 zTAG[3,3] >= -1920
 MaxsideConnectB[3]ToBAG[3]: B[3] - vBAG[3] - 1920 zBAG[3,3] >= -1920
 MinsideConnectL[4]ToLAG[3]: L[4] - vLAG[3] + 1080 zLAG[4,3] <= 1080
 MinsideConnectR[4]ToRAG[3]: R[4] - vRAG[3] + 1080 zRAG[4,3] <= 1080
 MinsideConnectT[4]ToTAG[3]: T[4] - vTAG[3] + 1920 zTAG[4,3] <= 1920
 MinsideConnectB[4]ToBAG[3]: B[4] - vBAG[3] + 1920 zBAG[4,3] <= 1920
 MaxsideConnectL[4]ToLAG[3]: L[4] - vLAG[3] - 1080 zLAG[4,3] >= -1080
 MaxsideConnectR[4]ToRAG[3]: R[4] - vRAG[3] - 1080 zRAG[4,3] >= -1080
 MaxsideConnectT[4]ToTAG[3]: T[4] - vTAG[3] - 1920 zTAG[4,3] >= -1920
 MaxsideConnectB[4]ToBAG[3]: B[4] - vBAG[3] - 1920 zBAG[4,3] >= -1920
 MinsideConnectL[5]ToLAG[3]: L[5] - vLAG[3] + 1080 zLAG[5,3] <= 1080
 MinsideConnectR[5]ToRAG[3]: R[5] - vRAG[3] + 1080 zRAG[5,3] <= 1080
 MinsideConnectT[5]ToTAG[3]: T[5] - vTAG[3] + 1920 zTAG[5,3] <= 1920
 MinsideConnectB[5]ToBAG[3]: B[5] - vBAG[3] + 1920 zBAG[5,3] <= 1920
 MaxsideConnectL[5]ToLAG[3]: L[5] - vLAG[3] - 1080 zLAG[5,3] >= -1080
 MaxsideConnectR[5]ToRAG[3]: R[5] - vRAG[3] - 1080 zRAG[5,3] >= -1080
 MaxsideConnectT[5]ToTAG[3]: T[5] - vTAG[3] - 1920 zTAG[5,3] >= -1920
 MaxsideConnectB[5]ToBAG[3]: B[5] - vBAG[3] - 1920 zBAG[5,3] >= -1920
 MinsideConnectL[0]ToLAG[4]: L[0] - vLAG[4] + 1080 zLAG[0,4] <= 1080
 MinsideConnectR[0]ToRAG[4]: R[0] - vRAG[4] + 1080 zRAG[0,4] <= 1080
 MinsideConnectT[0]ToTAG[4]: T[0] - vTAG[4] + 1920 zTAG[0,4] <= 1920
 MinsideConnectB[0]ToBAG[4]: B[0] - vBAG[4] + 1920 zBAG[0,4] <= 1920
 MaxsideConnectL[0]ToLAG[4]: L[0] - vLAG[4] - 1080 zLAG[0,4] >= -1080
 MaxsideConnectR[0]ToRAG[4]: R[0] - vRAG[4] - 1080 zRAG[0,4] >= -1080
 MaxsideConnectT[0]ToTAG[4]: T[0] - vTAG[4] - 1920 zTAG[0,4] >= -1920
 MaxsideConnectB[0]ToBAG[4]: B[0] - vBAG[4] - 1920 zBAG[0,4] >= -1920
 MinsideConnectL[1]ToLAG[4]: L[1] - vLAG[4] + 1080 zLAG[1,4] <= 1080
 MinsideConnectR[1]ToRAG[4]: R[1] - vRAG[4] + 1080 zRAG[1,4] <= 1080
 MinsideConnectT[1]ToTAG[4]: T[1] - vTAG[4] + 1920 zTAG[1,4] <= 1920
 MinsideConnectB[1]ToBAG[4]: B[1] - vBAG[4] + 1920 zBAG[1,4] <= 1920
 MaxsideConnectL[1]ToLAG[4]: L[1] - vLAG[4] - 1080 zLAG[1,4] >= -1080
 MaxsideConnectR[1]ToRAG[4]: R[1] - vRAG[4] - 1080 zRAG[1,4] >= -1080
 MaxsideConnectT[1]ToTAG[4]: T[1] - vTAG[4] - 1920 zTAG[1,4] >= -1920
 MaxsideConnectB[1]ToBAG[4]: B[1] - vBAG[4] - 1920 zBAG[1,4] >= -1920
 MinsideConnectL[2]ToLAG[4]: L[2] - vLAG[4] + 1080 zLAG[2,4] <= 1080
 MinsideConnectR[2]ToRAG[4]: R[2] - vRAG[4] + 1080 zRAG[2,4] <= 1080
 MinsideConnectT[2]ToTAG[4]: T[2] - vTAG[4] + 1920 zTAG[2,4] <= 1920
 MinsideConnectB[2]ToBAG[4]: B[2] - vBAG[4] + 1920 zBAG[2,4] <= 1920
 MaxsideConnectL[2]ToLAG[4]: L[2] - vLAG[4] - 1080 zLAG[2,4] >= -1080
 MaxsideConnectR[2]ToRAG[4]: R[2] - vRAG[4] - 1080 zRAG[2,4] >= -1080
 MaxsideConnectT[2]ToTAG[4]: T[2] - vTAG[4] - 1920 zTAG[2,4] >= -1920
 MaxsideConnectB[2]ToBAG[4]: B[2] - vBAG[4] - 1920 zBAG[2,4] >= -1920
 MinsideConnectL[3]ToLAG[4]: L[3] - vLAG[4] + 1080 zLAG[3,4] <= 1080
 MinsideConnectR[3]ToRAG[4]: R[3] - vRAG[4] + 1080 zRAG[3,4] <= 1080
 MinsideConnectT[3]ToTAG[4]: T[3] - vTAG[4] + 1920 zTAG[3,4] <= 1920
 MinsideConnectB[3]ToBAG[4]: B[3] - vBAG[4] + 1920 zBAG[3,4] <= 1920
 MaxsideConnectL[3]ToLAG[4]: L[3] - vLAG[4] - 1080 zLAG[3,4] >= -1080
 MaxsideConnectR[3]ToRAG[4]: R[3] - vRAG[4] - 1080 zRAG[3,4] >= -1080
 MaxsideConnectT[3]ToTAG[4]: T[3] - vTAG[4] - 1920 zTAG[3,4] >= -1920
 MaxsideConnectB[3]ToBAG[4]: B[3] - vBAG[4] - 1920 zBAG[3,4] >= -1920
 MinsideConnectL[4]ToLAG[4]: L[4] - vLAG[4] + 1080 zLAG[4,4] <= 1080
 MinsideConnectR[4]ToRAG[4]: R[4] - vRAG[4] + 1080 zRAG[4,4] <= 1080
 MinsideConnectT[4]ToTAG[4]: T[4] - vTAG[4] + 1920 zTAG[4,4] <= 1920
 MinsideConnectB[4]ToBAG[4]: B[4] - vBAG[4] + 1920 zBAG[4,4] <= 1920
 MaxsideConnectL[4]ToLAG[4]: L[4] - vLAG[4] - 1080 zLAG[4,4] >= -1080
 MaxsideConnectR[4]ToRAG[4]: R[4] - vRAG[4] - 1080 zRAG[4,4] >= -1080
 MaxsideConnectT[4]ToTAG[4]: T[4] - vTAG[4] - 1920 zTAG[4,4] >= -1920
 MaxsideConnectB[4]ToBAG[4]: B[4] - vBAG[4] - 1920 zBAG[4,4] >= -1920
 MinsideConnectL[5]ToLAG[4]: L[5] - vLAG[4] + 1080 zLAG[5,4] <= 1080
 MinsideConnectR[5]ToRAG[4]: R[5] - vRAG[4] + 1080 zRAG[5,4] <= 1080
 MinsideConnectT[5]ToTAG[4]: T[5] - vTAG[4] + 1920 zTAG[5,4] <= 1920
 MinsideConnectB[5]ToBAG[4]: B[5] - vBAG[4] + 1920 zBAG[5,4] <= 1920
 MaxsideConnectL[5]ToLAG[4]: L[5] - vLAG[4] - 1080 zLAG[5,4] >= -1080
 MaxsideConnectR[5]ToRAG[4]: R[5] - vRAG[4] - 1080 zRAG[5,4] >= -1080
 MaxsideConnectT[5]ToTAG[4]: T[5] - vTAG[4] - 1920 zTAG[5,4] >= -1920
 MaxsideConnectB[5]ToBAG[4]: B[5] - vBAG[4] - 1920 zBAG[5,4] >= -1920
 MinsideConnectL[0]ToLAG[5]: L[0] - vLAG[5] + 1080 zLAG[0,5] <= 1080
 MinsideConnectR[0]ToRAG[5]: R[0] - vRAG[5] + 1080 zRAG[0,5] <= 1080
 MinsideConnectT[0]ToTAG[5]: T[0] - vTAG[5] + 1920 zTAG[0,5] <= 1920
 MinsideConnectB[0]ToBAG[5]: B[0] - vBAG[5] + 1920 zBAG[0,5] <= 1920
 MaxsideConnectL[0]ToLAG[5]: L[0] - vLAG[5] - 1080 zLAG[0,5] >= -1080
 MaxsideConnectR[0]ToRAG[5]: R[0] - vRAG[5] - 1080 zRAG[0,5] >= -1080
 MaxsideConnectT[0]ToTAG[5]: T[0] - vTAG[5] - 1920 zTAG[0,5] >= -1920
 MaxsideConnectB[0]ToBAG[5]: B[0] - vBAG[5] - 1920 zBAG[0,5] >= -1920
 MinsideConnectL[1]ToLAG[5]: L[1] - vLAG[5] + 1080 zLAG[1,5] <= 1080
 MinsideConnectR[1]ToRAG[5]: R[1] - vRAG[5] + 1080 zRAG[1,5] <= 1080
 MinsideConnectT[1]ToTAG[5]: T[1] - vTAG[5] + 1920 zTAG[1,5] <= 1920
 MinsideConnectB[1]ToBAG[5]: B[1] - vBAG[5] + 1920 zBAG[1,5] <= 1920
 MaxsideConnectL[1]ToLAG[5]: L[1] - vLAG[5] - 1080 zLAG[1,5] >= -1080
 MaxsideConnectR[1]ToRAG[5]: R[1] - vRAG[5] - 1080 zRAG[1,5] >= -1080
 MaxsideConnectT[1]ToTAG[5]: T[1] - vTAG[5] - 1920 zTAG[1,5] >= -1920
 MaxsideConnectB[1]ToBAG[5]: B[1] - vBAG[5] - 1920 zBAG[1,5] >= -1920
 MinsideConnectL[2]ToLAG[5]: L[2] - vLAG[5] + 1080 zLAG[2,5] <= 1080
 MinsideConnectR[2]ToRAG[5]: R[2] - vRAG[5] + 1080 zRAG[2,5] <= 1080
 MinsideConnectT[2]ToTAG[5]: T[2] - vTAG[5] + 1920 zTAG[2,5] <= 1920
 MinsideConnectB[2]ToBAG[5]: B[2] - vBAG[5] + 1920 zBAG[2,5] <= 1920
 MaxsideConnectL[2]ToLAG[5]: L[2] - vLAG[5] - 1080 zLAG[2,5] >= -1080
 MaxsideConnectR[2]ToRAG[5]: R[2] - vRAG[5] - 1080 zRAG[2,5] >= -1080
 MaxsideConnectT[2]ToTAG[5]: T[2] - vTAG[5] - 1920 zTAG[2,5] >= -1920
 MaxsideConnectB[2]ToBAG[5]: B[2] - vBAG[5] - 1920 zBAG[2,5] >= -1920
 MinsideConnectL[3]ToLAG[5]: L[3] - vLAG[5] + 1080 zLAG[3,5] <= 1080
 MinsideConnectR[3]ToRAG[5]: R[3] - vRAG[5] + 1080 zRAG[3,5] <= 1080
 MinsideConnectT[3]ToTAG[5]: T[3] - vTAG[5] + 1920 zTAG[3,5] <= 1920
 MinsideConnectB[3]ToBAG[5]: B[3] - vBAG[5] + 1920 zBAG[3,5] <= 1920
 MaxsideConnectL[3]ToLAG[5]: L[3] - vLAG[5] - 1080 zLAG[3,5] >= -1080
 MaxsideConnectR[3]ToRAG[5]: R[3] - vRAG[5] - 1080 zRAG[3,5] >= -1080
 MaxsideConnectT[3]ToTAG[5]: T[3] - vTAG[5] - 1920 zTAG[3,5] >= -1920
 MaxsideConnectB[3]ToBAG[5]: B[3] - vBAG[5] - 1920 zBAG[3,5] >= -1920
 MinsideConnectL[4]ToLAG[5]: L[4] - vLAG[5] + 1080 zLAG[4,5] <= 1080
 MinsideConnectR[4]ToRAG[5]: R[4] - vRAG[5] + 1080 zRAG[4,5] <= 1080
 MinsideConnectT[4]ToTAG[5]: T[4] - vTAG[5] + 1920 zTAG[4,5] <= 1920
 MinsideConnectB[4]ToBAG[5]: B[4] - vBAG[5] + 1920 zBAG[4,5] <= 1920
 MaxsideConnectL[4]ToLAG[5]: L[4] - vLAG[5] - 1080 zLAG[4,5] >= -1080
 MaxsideConnectR[4]ToRAG[5]: R[4] - vRAG[5] - 1080 zRAG[4,5] >= -1080
 MaxsideConnectT[4]ToTAG[5]: T[4] - vTAG[5] - 1920 zTAG[4,5] >= -1920
 MaxsideConnectB[4]ToBAG[5]: B[4] - vBAG[5] - 1920 zBAG[4,5] >= -1920
 MinsideConnectL[5]ToLAG[5]: L[5] - vLAG[5] + 1080 zLAG[5,5] <= 1080
 MinsideConnectR[5]ToRAG[5]: R[5] - vRAG[5] + 1080 zRAG[5,5] <= 1080
 MinsideConnectT[5]ToTAG[5]: T[5] - vTAG[5] + 1920 zTAG[5,5] <= 1920
 MinsideConnectB[5]ToBAG[5]: B[5] - vBAG[5] + 1920 zBAG[5,5] <= 1920
 MaxsideConnectL[5]ToLAG[5]: L[5] - vLAG[5] - 1080 zLAG[5,5] >= -1080
 MaxsideConnectR[5]ToRAG[5]: R[5] - vRAG[5] - 1080 zRAG[5,5] >= -1080
 MaxsideConnectT[5]ToTAG[5]: T[5] - vTAG[5] - 1920 zTAG[5,5] >= -1920
 MaxsideConnectB[5]ToBAG[5]: B[5] - vBAG[5] - 1920 zBAG[5,5] >= -1920
Bounds
 28 <= L[0] <= 37
 28 <= L[1] <= 36
 28 <= L[2] <= 571
 28 <= L[3] <= 148
 28 <= L[4] <= 30
 28 <= L[5] <= 605
 1043 <= R[0] <= 1052
 1044 <= R[1] <= 1052
 509 <= R[2] <= 1052
 932 <= R[3] <= 1052
 1050 <= R[4] <= 1052
 475 <= R[5] <= 1052
 32 <= T[0] <= 1748
 32 <= T[1] <= 1339
 32 <= T[2] <= 1760
 32 <= T[3] <= 1265
 32 <= T[4] <= 1690
 32 <= T[5] <= 1760
 172 <= B[0] <= 1888
 581 <= B[1] <= 1888
 160 <= B[2] <= 1888
 655 <= B[3] <= 1888
 230 <= B[4] <= 1888
 160 <= B[5] <= 1888
 H[0] = 140
 H[1] = 549
 H[2] = 128
 H[3] = 623
 H[4] = 198
 H[5] = 128
 W[0] = 1015
 W[1] = 1016
 W[2] = 481
 W[3] = 904
 W[4] = 1022
 W[5] = 447
 vLAG[0] <= 1079
 vLAG[1] <= 1079
 vLAG[2] <= 1079
 vLAG[3] <= 1079
 vLAG[4] <= 1079
 vLAG[5] <= 1079
 1 <= vRAG[0] <= 1080
 1 <= vRAG[1] <= 1080
 1 <= vRAG[2] <= 1080
 1 <= vRAG[3] <= 1080
 1 <= vRAG[4] <= 1080
 1 <= vRAG[5] <= 1080
 vTAG[0] <= 1919
 vTAG[1] <= 1919
 vTAG[2] <= 1919
 vTAG[3] <= 1919
 vTAG[4] <= 1919
 vTAG[5] <= 1919
 1 <= vBAG[0] <= 1920
 1 <= vBAG[1] <= 1920
 1 <= vBAG[2] <= 1920
 1 <= vBAG[3] <= 1920
 1 <= vBAG[4] <= 1920
 1 <= vBAG[5] <= 1920
Binaries
 ABOVE[0,0] ABOVE[0,1] ABOVE[0,2] ABOVE[0,3] ABOVE[0,4] ABOVE[0,5]
 ABOVE[1,0] ABOVE[1,1] ABOVE[1,2] ABOVE[1,3] ABOVE[1,4] ABOVE[1,5]
 ABOVE[2,0] ABOVE[2,1] ABOVE[2,2] ABOVE[2,3] ABOVE[2,4] ABOVE[2,5]
 ABOVE[3,0] ABOVE[3,1] ABOVE[3,2] ABOVE[3,3] ABOVE[3,4] ABOVE[3,5]
 ABOVE[4,0] ABOVE[4,1] ABOVE[4,2] ABOVE[4,3] ABOVE[4,4] ABOVE[4,5]
 ABOVE[5,0] ABOVE[5,1] ABOVE[5,2] ABOVE[5,3] ABOVE[5,4] ABOVE[5,5]
 LEFT[0,0] LEFT[0,1] LEFT[0,2] LEFT[0,3] LEFT[0,4] LEFT[0,5] LEFT[1,0]
 LEFT[1,1] LEFT[1,2] LEFT[1,3] LEFT[1,4] LEFT[1,5] LEFT[2,0] LEFT[2,1]
 LEFT[2,2] LEFT[2,3] LEFT[2,4] LEFT[2,5] LEFT[3,0] LEFT[3,1] LEFT[3,2]
 LEFT[3,3] LEFT[3,4] LEFT[3,5] LEFT[4,0] LEFT[4,1] LEFT[4,2] LEFT[4,3]
 LEFT[4,4] LEFT[4,5] LEFT[5,0] LEFT[5,1] LEFT[5,2] LEFT[5,3] LEFT[5,4]
 LEFT[5,5] LAG[0] LAG[1] LAG[2] LAG[3] LAG[4] LAG[5] RAG[0] RAG[1] RAG[2]
 RAG[3] RAG[4] RAG[5] TAG[0] TAG[1] TAG[2] TAG[3] TAG[4] TAG[5] BAG[0]
 BAG[1] BAG[2] BAG[3] BAG[4] BAG[5] zLAG[0,0] zLAG[0,1] zLAG[0,2] zLAG[0,3]
 zLAG[0,4] zLAG[0,5] zLAG[1,0] zLAG[1,1] zLAG[1,2] zLAG[1,3] zLAG[1,4]
 zLAG[1,5] zLAG[2,0] zLAG[2,1] zLAG[2,2] zLAG[2,3] zLAG[2,4] zLAG[2,5]
 zLAG[3,0] zLAG[3,1] zLAG[3,2] zLAG[3,3] zLAG[3,4] zLAG[3,5] zLAG[4,0]
 zLAG[4,1] zLAG[4,2] zLAG[4,3] zLAG[4,4] zLAG[4,5] zLAG[5,0] zLAG[5,1]
 zLAG[5,2] zLAG[5,3] zLAG[5,4] zLAG[5,5] zRAG[0,0] zRAG[0,1] zRAG[0,2]
 zRAG[0,3] zRAG[0,4] zRAG[0,5] zRAG[1,0] zRAG[1,1] zRAG[1,2] zRAG[1,3]
 zRAG[1,4] zRAG[1,5] zRAG[2,0] zRAG[2,1] zRAG[2,2] zRAG[2,3] zRAG[2,4]
 zRAG[2,5] zRAG[3,0] zRAG[3,1] zRAG[3,2] zRAG[3,3] zRAG[3,4] zRAG[3,5]
 zRAG[4,0] zRAG[4,1] zRAG[4,2] zRAG[4,3] zRAG[4,4] zRAG[4,5] zRAG[5,0]
 zRAG[5,1] zRAG[5,2] zRAG[5,3] zRAG[5,4] zRAG[5,5] zTAG[0,0] zTAG[0,1]
 zTAG[0,2] zTAG[0,3] zTAG[0,4] zTAG[0,5] zTAG[1,0] zTAG[1,1] zTAG[1,2]
 zTAG[1,3] zTAG[1,4] zTAG[1,5] zTAG[2,0] zTAG[2,1] zTAG[2,2] zTAG[2,3]
 zTAG[2,4] zTAG[2,5] zTAG[3,0] zTAG[3,1] zTAG[3,2] zTAG[3,3] zTAG[3,4]
 zTAG[3,5] zTAG[4,0] zTAG[4,1] zTAG[4,2] zTAG[4,3] zTAG[4,4] zTAG[4,5]
 zTAG[5,0] zTAG[5,1] zTAG[5,2] zTAG[5,3] zTAG[5,4] zTAG[5,5] zBAG[0,0]
 zBAG[0,1] zBAG[0,2] zBAG[0,3] zBAG[0,4] zBAG[0,5] zBAG[1,0] zBAG[1,1]
 zBAG[1,2] zBAG[1,3] zBAG[1,4] zBAG[1,5] zBAG[2,0] zBAG[2,1] zBAG[2,2]
 zBAG[2,3] zBAG[2,4] zBAG[2,5] zBAG[3,0] zBAG[3,1] zBAG[3,2] zBAG[3,3]
 zBAG[3,4] zBAG[3,5] zBAG[4,0] zBAG[4,1] zBAG[4,2] zBAG[4,3] zBAG[4,4]
 zBAG[4,5] zBAG[5,0] zBAG[5,1] zBAG[5,2] zBAG[5,3] zBAG[5,4] zBAG[5,5]
Generals
 L[0] L[1] L[2] L[3] L[4] L[5] R[0] R[1] R[2] R[3] R[4] R[5] T[0] T[1] T[2]
 T[3] T[4] T[5] B[0] B[1] B[2] B[3] B[4] B[5] H[0] H[1] H[2] H[3] H[4] H[5]
 W[0] W[1] W[2] W[3] W[4] W[5] vLAG[0] vLAG[1] vLAG[2] vLAG[3] vLAG[4]
 vLAG[5] vRAG[0] vRAG[1] vRAG[2] vRAG[3] vRAG[4] vRAG[5] vTAG[0] vTAG[1]
 vTAG[2] vTAG[3] vTAG[4] vTAG[5] vBAG[0] vBAG[1] vBAG[2] vBAG[3] vBAG[4]
 vBAG[5] maxX maxY
End

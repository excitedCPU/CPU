      � H  �        V_(T         �a         :   
Behavioral  � �y          �i 	� �� �i �9 ة �� � � >9 M� �� �� ҩ  �     �Q � �� �Q �! ܑ �� q "� B! Q� �q �� ֑        �� �� ��  �       �  �     �y          Y  #)  *�  Bi  Y�  a�  iy  qI  ��  �)  ��         A  '  .�  FQ  ]�  e�  ma  u1  ��  �  ��          �Q     v  ��          A     :   reset  A  �     p   2  Y      q          �     :   q  '  �     p   3  #)      q          �     :   clk_0  .�  �     p   4  *�      q          �     @     6�     ' Q4     2�  :�      >�     @      6�     v  �[     6�      FQ     :   bit_addr  FQ  �     p   5  Bi     >�          �     @     N!     ' Q4     J9  R	      U�     @      N!     v  �[     N!      ]�     :   	char_addr  ]�  �     p   6  Y�     U�          �     :   clk25  e�  �     p   7  a�     q          �     :   hs  ma  �     p   8  iy     q          �     :   vs  u1  �     p   9  qI     q          �     @     }     ' Q4     y  ��      ��     @      }     v  �[     }      ��     :   r  ��  �     p   :  ��     ��          �     @     �q     ' Q4     ��  �Y      �A     @      �q     v  �[     �q      �     :   g  �  �     p   ;  �)     �A          �     @     ��     ' Q4     ��  ��      ��     @      ��     v  �[     ��      ��     :   b  ��  �     p   <  ��     ��          �     :   	vga640480  �Q  �        0  �i  �  �          �!  �  � �         �	  �y  �� �         �     :   clk  �	  �9     p   A  �!      q          �9     @   
  ��     ' Q4     ��  ��      ީ     @      ��     v  �[     ��      �y     :   row_addr  �y  �9     p   B  �      ީ          �9     @     �I     ' Q4     �a  �1      �     @      �I     v  �[     �I      ��     :   col_addr  ��  �9     p   C  �      �          �9     :   dataOut �  �9     p   D �     q          �9     :   fontROM �  �        ? 	�  �9  �        
 Y ) $� <i S� kI s �� �� ��       
 A ! (� @Q W� o1 w �q �� ��         ��     :   clk A q     p   I Y      q         q     :   rst ! q     p   J )      q         q     :   	isNewChar (� q     p   K $�      q         q     @    0�     ' Q4    ,� 4�     8�     @     0�     v  �[    0�     @Q     :   input_ascii @Q q     p   L <i     8�         q     @    H!     ' Q4    D9 L	     O�     @     H!     v  �[    H!     W�     :   bit_addr W� q     p   M S�     O�         q     @    _�     ' Q4    [� cy     ga     @     _�     v  �[    _�     o1     :   	char_addr o1 q     p   N kI     ga         q     :   	can_write w q     p   O s     q         q     @   
 ~�     ' Q4    z� ��     ��     @     ~�     v  �[    ~�     �q     :   ascii_with_bit_addr �q q     p   P ��    ��         q     @    �A     ' Q4    �Y �)     �     @     �A     v  �[    �A     ��     :   bit_addr_last_three �� q     p   Q ��    �         q     :   not_exceed_max_col �� q     p   R ��     q         q     :   	my_buffer ��  �        G �� q  �     :   q_in �Q  �     p   U �i     q  [      �     :   clk25 �!  �     p   V �9     q  C      �     @    ��     ' Q4    �	 ��     ��     @     ��     v  �[    ��     ܑ     :   to_buffer_char_addr ܑ  �     p   W ة    �� �a      �     
    ��  � �a      ��    �y ܑ     @    �1     ' Q4    �I �     �     @     �1     v  �[    �1     ��     :   to_buffer_bit_addr ��  �     p   X ��    � �      �     
    �1  � �      �    �� ��     :   
not_exceed q  �     p   Y �     q  �      �     @   
 A     ' Q4    Y )          @     A     v  �[    A     "�     :   
to_rom_row "�  �     p   Z �     *�      �     
    A  � *�          &� "�     @    2�     ' Q4    .� 6i     :Q     @     2�     v  �[    2�     B!     :   
to_rom_col B!  �     p   [ >9    :Q I�      �     
    2�  � I�      :Q    F	 B!     :   temp Q�  �     p   \ M�     q  �      �     \     Bi �� ��     \     Y� ة ��     \     Y  B ��     \     a� �9 ��     \     #) �i ��     \     *�  ' ��     \     iy  N" ��     \     qI  U� ��     \     ��  mb ��     \     �)  �� ��     \     ��  �B ��        ^ ��  �i    ]y eI i1 U� Y� aa m q t� x� |�      �     :   Inst_vga640480 �q  �     E   ^ �� ��  �     \     �!  ' ��     \     � � ��     \     � >9 ��     \    � �i ��        k �� 	�    �Y �A �) �      �     :   Inst_fontROM ��  �     E   k �� ��  �     \    Y  ' ��     \    )  B ��     \    $�  .� ��     \    <i  FR ��     \    S� �� ��     \    kI ة ��     \    s M� ��     \    �� � ��     \    �� >9 ��     \    �� � ��        q ҩ ��   
 �� �� �� �i �Q �9 �! �	 �� ��      �     :   Inst_my_buffer ֑  �     E   q ҩ ��  �     %     �  �  ��     � �a     �   'C:/Projects/CPU/myVGA/VGAController.vhd �y  �                vgacontroller   
behavioral   work      vgacontroller   
behavioral   work      vgacontroller       work      std_logic_1164       IEEE      standard       std